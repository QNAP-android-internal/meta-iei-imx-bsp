# Copyright 2023 IEI
inherit packagegroup

DQV_TOOLS = "dialog jq stress-ng"
RDEPENDS:${PN}:append = "${DQV_TOOLS}"
