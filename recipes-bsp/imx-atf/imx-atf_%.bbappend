FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = "\
        file://0001-imx8m-imx8m_psci_common.c-fix-the-issue-that-powerof.patch;patch=1 \
"
