FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = "\
        file://0001-rules.d-99-systemd.rules-disable-ID_BACKLIGHT_CLAMP-.patch;patch=1 \
"
