############################################################################
##
## Copyright (C) 2025 IEI Integration Corp.
## Contact: dev@ieiworld.com
##
## This file is part of the TechNexion bitbake/yocto meta-layer
##
## GNU General Public License Usage
## Alternatively, this file may be used under the terms of the GNU
## General Public License version 3 or (at your option) any later version
## approved by the KDE Free Qt Foundation. The licenses are as published by
## the Free Software Foundation and appearing in the file LICENSE.GPL3
## included in the packaging of this file. Please review the following
## information to ensure the GNU General Public License requirements will
## be met: https://www.gnu.org/licenses/gpl-3.0.html.
##
############################################################################


IMAGE_INSTALL:append = " cloud-utils-growpart tn-growpart-helper tn-ubuntu-custom packagegroup-iei-network zram pulseaudio pulseaudio-server \
                         u-boot-fw-utils"

UBOOT_ENV_DEVICE:mx9-generic-bsp = "mmcblk0"
UBOOT_ENV_SIZE:mx9-generic-bsp = "0x4000"
UBOOT_ENV_OFFSET:mx9-generic-bsp = "0x700000"

# Get poky version from conf/distro/poky.conf
POKY_VERSION_UPSTREAM := "${@bb.process.run('grep ^DISTRO_VERSION ' + bb.utils.which(d.getVar('BBPATH'), 'conf/distro/poky.conf'), shell=True)[0].split(chr(34))[1]}"
