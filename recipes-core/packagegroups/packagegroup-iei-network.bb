# Copyright 2023 IEI
inherit packagegroup

MODULAR_NETWORK_TOOLS = "libmbim libqmi modemmanager chromium-ozone-wayland brcm-patchram-plus"
RDEPENDS:${PN}:append = "${MODULAR_NETWORK_TOOLS}"
