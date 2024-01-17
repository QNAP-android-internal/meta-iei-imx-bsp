FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

APTGET_EXTRA_PACKAGES_REMOVE += " \
    xwayland \
    libgpod-common \
    whoopsie \
    pulseaudio \
    pulseaudio-module-bluetooth \
"
