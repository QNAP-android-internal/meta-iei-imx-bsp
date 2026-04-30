# =============================================================================
# nxp-ahab-secureboot.bbclass
#
# Assembles and AHAB-signs an i.MX 95 boot image using nxpimage (SPSDK).
# Intended to be inherited by an image recipe so it runs after all boot
# artefacts have been deployed to DEPLOY_DIR_IMAGE.
#
# Required variables in machine.conf / local.conf:
#   DISTRO_FEATURES:append = " secureboot"
#   AHAB_SIGNER_KEY   — absolute path to the OEM SRK private signing key
#   AHAB_SRK_KEY_0..3 — absolute paths to the four SRK public keys
# =============================================================================

# ---------------------------------------------------------------------------
# nxpimage tool
# Resolved from the host PATH — install SPSDK on the build host with:
#   pip install spsdk
# Override NXPIMAGE_TOOL in local.conf to use an explicit path if needed.
# ---------------------------------------------------------------------------
NXPIMAGE_TOOL ??= "nxpimage"

# ---------------------------------------------------------------------------
# YAML template directory
# The four .yaml / .yaml.in files next to this bbclass are copied into
# DEPLOY_DIR_IMAGE at signing time.  Override AHAB_YAML_TEMPLATE_DIR to
# point at a custom set of templates if the NXP reference layout is not used.
#
# THISDIR cannot be used reliably here — it resolves to whichever file
# triggered class parsing (local.conf, recipe, etc.), not the bbclass file.
# Instead, search BBPATH for the classes/nxp-ahab-secureboot directory that
# ships alongside this bbclass.
# ---------------------------------------------------------------------------
python() {
    if d.getVar('AHAB_YAML_TEMPLATE_DIR'):
        return
    import os
    for p in (d.getVar('BBPATH') or '').split(':'):
        candidate = os.path.join(p, 'classes', 'nxp-ahab-secureboot')
        if os.path.isdir(candidate):
            d.setVar('AHAB_YAML_TEMPLATE_DIR', candidate)
            return
    bb.warn('nxp-ahab-secureboot: AHAB_YAML_TEMPLATE_DIR not found via BBPATH; '
            'set it manually in local.conf or machine.conf')
}

# ---------------------------------------------------------------------------
# Signing key variables
# Set these in machine.conf (absolute paths, no shell expansions).
# ---------------------------------------------------------------------------

# OEM SRK private key used to sign the AHAB container.
AHAB_SIGNER_KEY ??= ""

# Four OEM SRK public keys that form the Super Root Key table.
# The SRK hash of this table is burned into eFuses to authenticate boot images.
AHAB_SRK_KEY_0 ??= ""
AHAB_SRK_KEY_1 ??= ""
AHAB_SRK_KEY_2 ??= ""
AHAB_SRK_KEY_3 ??= ""

# ---------------------------------------------------------------------------
# Output filenames (relative to DEPLOY_DIR_IMAGE)
# ---------------------------------------------------------------------------

# Intermediate assembled image (step 3 output / step 4 input).
# Using a distinct name avoids overwriting the unsigned flash.bin produced
# by imx-boot / imx-mkimage.
AHAB_ASSEMBLED_BIN ??= "ahab-flash.bin"

# Final AHAB-signed boot image (step 4 output).
AHAB_SIGNED_BIN ??= "signed-flash.bin"

# eFuse programming script produced alongside the signed image.
AHAB_FUSE_SCRIPT ??= "ahab-fuse-script"

# ---------------------------------------------------------------------------
# Kernel + DTB signing variables
# Set AHAB_KERNEL_DTB in machine.conf to the deployed DTB filename.
# ---------------------------------------------------------------------------

# Kernel image filename (relative to DEPLOY_DIR_IMAGE).
AHAB_KERNEL_IMAGE ??= "Image"

# DTB filename (relative to DEPLOY_DIR_IMAGE) — machine-specific, must be set.
AHAB_KERNEL_DTB ??= "imx95-smarc-ismc-cb.dtb"

# Output filename for the signed kernel+DTB AHAB container.
AHAB_KERNEL_SIGNED_BIN ??= "os_cntr_signed.bin"

addtask do_ahab_sign before do_image_wic
do_ahab_sign[dirs]      = "${DEPLOY_DIR_IMAGE}"
do_ahab_sign[nostamp]   = "1"
do_ahab_sign[lockfiles] = "${DEPLOY_DIR_IMAGE}/.ahab-sign.lock"
do_ahab_sign[depends] += " \
    virtual/kernel:do_deploy \
    virtual/bootloader:do_deploy \
    imx-atf:do_deploy \
    ${@bb.utils.contains('MACHINE_FEATURES', 'optee', 'optee-os:do_deploy', '', d)} \
    python3-spsdk-native:do_populate_sysroot \
"
WKS_FILES = " imx-imx-boot-bootpart-signed.wks.in imx-image-full.wks"
IMAGE_BOOT_FILES = " \
    ${AHAB_KERNEL_SIGNED_BIN} \
    tee.bin \
"
IMAGE_NAME_SUFFIX = "-signed.rootfs"

do_ahab_sign() {
    if ! command -v "${NXPIMAGE_TOOL}" >/dev/null 2>&1; then
        bbfatal "nxp-ahab-secureboot: '${NXPIMAGE_TOOL}' not found. \
Ensure python3-spsdk-native has been built successfully."
    fi

    if [ -z "${AHAB_SIGNER_KEY}" ]; then
        bbfatal "nxp-ahab-secureboot: AHAB_SIGNER_KEY is not set. \
Set it to the absolute path of the OEM SRK private key in machine.conf."
    fi
    if [ ! -f "${AHAB_SIGNER_KEY}" ]; then
        bbfatal "nxp-ahab-secureboot: AHAB_SIGNER_KEY '${AHAB_SIGNER_KEY}' not found."
    fi

    # BitBake expands ${AHAB_SRK_KEY_N} at task-script generation time.
    # Use a name:value pair list so the variable name appears in error messages.
    for _kv in \
        "AHAB_SRK_KEY_0:${AHAB_SRK_KEY_0}" \
        "AHAB_SRK_KEY_1:${AHAB_SRK_KEY_1}" \
        "AHAB_SRK_KEY_2:${AHAB_SRK_KEY_2}" \
        "AHAB_SRK_KEY_3:${AHAB_SRK_KEY_3}" \
    ; do
        _kname="${_kv%%:*}"
        _key="${_kv#*:}"
        if [ -z "${_key}" ]; then
            bbfatal "nxp-ahab-secureboot: ${_kname} is not set."
        fi
        if [ ! -f "${_key}" ]; then
            bbfatal "nxp-ahab-secureboot: ${_kname} '${_key}' not found."
        fi
    done

    if [ ! -d "${AHAB_YAML_TEMPLATE_DIR}" ]; then
        bbfatal "nxp-ahab-secureboot: AHAB_YAML_TEMPLATE_DIR \
'${AHAB_YAML_TEMPLATE_DIR}' does not exist."
    fi

    if [ -z "${AHAB_KERNEL_DTB}" ]; then
        bbfatal "nxp-ahab-secureboot: AHAB_KERNEL_DTB is not set. \
Set it to the deployed DTB filename (relative to DEPLOY_DIR_IMAGE) in machine.conf."
    fi
    if [ ! -f "${AHAB_KERNEL_IMAGE}" ]; then
        bbfatal "nxp-ahab-secureboot: AHAB_KERNEL_IMAGE '${AHAB_KERNEL_IMAGE}' not found in ${DEPLOY_DIR_IMAGE}."
    fi
    if [ ! -f "${AHAB_KERNEL_DTB}" ]; then
        bbfatal "nxp-ahab-secureboot: AHAB_KERNEL_DTB '${AHAB_KERNEL_DTB}' not found in ${DEPLOY_DIR_IMAGE}."
    fi

    # -----------------------------------------------------------------------
    # Step 0 — Deploy YAML templates into DEPLOY_DIR_IMAGE
    #
    # The sign YAML (.yaml.in) is processed through sed to substitute the
    # @PLACEHOLDER@ markers with the actual key paths supplied by the user.
    # -----------------------------------------------------------------------
    bbnote "nxp-ahab-secureboot: deploying YAML templates to ${DEPLOY_DIR_IMAGE}"

    for _yaml in ${AHAB_YAML_TEMPLATE_DIR}/*.yaml*; do
        # Process the sign YAML template — replace @PLACEHOLDER@ with real key paths
        sed \
            -e "s|@AHAB_KERNEL_SIGNED_BIN@|${AHAB_KERNEL_SIGNED_BIN}|g" \
            -e "s|@AHAB_KERNEL_IMAGE@|${AHAB_KERNEL_IMAGE}|g"            \
            -e "s|@AHAB_KERNEL_DTB@|${AHAB_KERNEL_DTB}|g"               \
            -e "s|@AHAB_SIGNER_KEY@|${AHAB_SIGNER_KEY}|g"               \
            -e "s|@AHAB_SRK_KEY_0@|${AHAB_SRK_KEY_0}|g"                 \
            -e "s|@AHAB_SRK_KEY_1@|${AHAB_SRK_KEY_1}|g"                 \
            -e "s|@AHAB_SRK_KEY_2@|${AHAB_SRK_KEY_2}|g"                 \
            -e "s|@AHAB_SRK_KEY_3@|${AHAB_SRK_KEY_3}|g"                 \
            ${_yaml} > ${DEPLOY_DIR_IMAGE}/$(basename ${_yaml%.in*})
    done

    cd "${DEPLOY_DIR_IMAGE}"

    # Fix OpenSSL 3.0 Legacy Provider fails under environment of native sysroot
    export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1

    # -----------------------------------------------------------------------
    # Step 1 — Generate signed SPL AHAB container  →  primary_ahab.bin
    # -----------------------------------------------------------------------
    bbnote "nxp-ahab-secureboot: step 1 — signed SPL container"
    ${NXPIMAGE_TOOL} ahab export -c imx95_ahab_uboot_spl.yaml

    # -----------------------------------------------------------------------
    # Step 2 — Generate signed ATF AHAB container  →  secondary_ahab.bin
    # -----------------------------------------------------------------------
    bbnote "nxp-ahab-secureboot: step 2 — signed ATF container"
    ${NXPIMAGE_TOOL} ahab export -c imx95_ahab_uboot_atf.yaml

    # -----------------------------------------------------------------------
    # Step 3 — Assemble bootable image from both containers
    #          →  ${AHAB_ASSEMBLED_BIN}
    # -----------------------------------------------------------------------
    bbnote "nxp-ahab-secureboot: step 3 — assembling ${AHAB_ASSEMBLED_BIN}"
    ${NXPIMAGE_TOOL} -v bootable-image export \
        -c imx95_ahab_uboot_bimg.yaml \
        -o "${AHAB_ASSEMBLED_BIN}"

    if [ ! -f "${AHAB_ASSEMBLED_BIN}" ]; then
        bbfatal "nxp-ahab-secureboot: step 3 did not produce '${AHAB_ASSEMBLED_BIN}'"
    fi

    # -----------------------------------------------------------------------
    # Step 4 — Sign assembled image with AHAB  →  ${AHAB_SIGNED_BIN}
    # The eFuse programming script is written to DEPLOY_DIR_IMAGE alongside
    # the signed binary so production programming tools can find it.
    # -----------------------------------------------------------------------
    bbnote "nxp-ahab-secureboot: step 4 — signing → ${AHAB_SIGNED_BIN}"
    ${NXPIMAGE_TOOL} ahab sign \
        -c imx95_ahab_signed_flash.yaml \
        -b "${AHAB_ASSEMBLED_BIN}" \
        -o "${AHAB_SIGNED_BIN}" \
        -fs "${AHAB_FUSE_SCRIPT}" \
        --force

    if [ ! -f "${AHAB_SIGNED_BIN}" ]; then
        bbfatal "nxp-ahab-secureboot: step 4 did not produce '${AHAB_SIGNED_BIN}'"
    fi

    # -----------------------------------------------------------------------
    # Step 5 — Sign kernel + DTB with AHAB  →  ${AHAB_KERNEL_SIGNED_BIN}
    # -----------------------------------------------------------------------
    bbnote "nxp-ahab-secureboot: step 5 — signing kernel+DTB → ${AHAB_KERNEL_SIGNED_BIN}"
    ${NXPIMAGE_TOOL} -v ahab export \
        -c imx95_signed_ahab_kernel_dtb.yaml

    if [ ! -f "${AHAB_KERNEL_SIGNED_BIN}" ]; then
        bbfatal "nxp-ahab-secureboot: step 5 did not produce '${AHAB_KERNEL_SIGNED_BIN}'"
    fi

    # -----------------------------------------------------------------------
    # Cleanup — remove intermediate artefacts that are no longer needed
    # -----------------------------------------------------------------------
    bbnote "nxp-ahab-secureboot: removing intermediate artefacts"
    rm -f primary_ahab.bin secondary_ahab.bin \
          "${AHAB_ASSEMBLED_BIN}" \
          ahab_oem* \
          *.yaml

    bbnote "nxp-ahab-secureboot: done — ${DEPLOY_DIR_IMAGE}/${AHAB_SIGNED_BIN}, \
${DEPLOY_DIR_IMAGE}/${AHAB_KERNEL_SIGNED_BIN}"
}
