FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:mx8m-nxp-bsp = "\
        file://0001-iMX8M-soc.mak-add-LPDDR_FW_VERSION.patch;patch=1 \
"
