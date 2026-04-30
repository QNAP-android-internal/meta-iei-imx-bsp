SUMMARY = "Python wrapper for NXP UUU library"
HOMEPAGE = "https://github.com/NXPmicro/libuuu"
LICENSE = "BSD-3-Clause"

LIC_FILES_CHKSUM = "file://LICENSE;md5=e6e72f45f3b08c41bf1aff1f5d610b97"

SRC_URI[sha256sum] = "93b0c556baa41f33cb8d931d5b22dd7dac32392c3e2fb062e2845d789a3a971c"

PYPI_PACKAGE = "libuuu"

do_configure:prepend() {
    cd ${S}
    sed -i 's/"setuptools[-_]scm[^"]*"//g' pyproject.toml
    sed -i 's/\[,/\[/g; s/,,/,/g; s/,\]/\]/g' pyproject.toml
}

export SETUPTOOLS_SCM_PRETEND_PV = "${PV}"

inherit pypi python_setuptools_build_meta native

INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_SYSROOT_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"

INSANE_SKIP:${PN}-native += "already-stripped dev-so arch libdir"

DEPENDS += " \
    python3-setuptools-native \
    python3-wheel-native \
    python3-build-native \
    python3-installer-native \
"
