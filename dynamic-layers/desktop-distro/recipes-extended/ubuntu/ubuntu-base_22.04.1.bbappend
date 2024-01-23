FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

APTGET_EXTRA_PACKAGES_REMOVE += " \
    xwayland \
    libgpod-common \
    whoopsie \
    pulseaudio \
    pulseaudio-module-bluetooth \
"

APTGET_EXTRA_PACKAGES += " \
    mmc-utils \
    usbutils \
    gpiod \
    memtester \
    fim \
    glmark2-es2-wayland \
    blueman \
    python3-numpy \
"
