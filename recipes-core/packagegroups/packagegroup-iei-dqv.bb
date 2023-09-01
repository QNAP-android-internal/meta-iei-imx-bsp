# Copyright 2023 IEI
inherit packagegroup

DQV_TOOLS = "dialog jq"
RDEPENDS:${PN}:append = "${DQV_TOOLS}"
