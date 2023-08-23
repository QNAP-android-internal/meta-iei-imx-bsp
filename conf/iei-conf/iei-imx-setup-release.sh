#!/bin/sh

CWD=$(pwd)
PROGNAME="$CWD/imx-setup-release.sh"

if [ -z "$BUILD" ]; then
	BUILD="build"
fi

CURRENT_DISTRO="$DISTRO"

EULA=1 MACHINE=$MACHINE DISTRO=$DISTRO BUILD_DIR=$BUILD source $PROGNAME $@


CWD=$(pwd)
if [ -f ${CWD}/../sources/meta-iei-imx-bsp/conf/iei-conf/$MACHINE/bblayers.conf.append ]; then
	cat ${CWD}/../sources/meta-iei-imx-bsp/conf/iei-conf/$MACHINE/bblayers.conf.append >> ${CWD}/conf/bblayers.conf
fi
if [ -f ${CWD}/../sources/meta-iei-imx-bsp/conf/iei-conf/$MACHINE/local.conf.append ]; then
	cat ${CWD}/../sources/meta-iei-imx-bsp/conf/iei-conf/$MACHINE/local.conf.append >> ${CWD}/conf/local.conf
fi

echo "PA_USER ?= \"iei-user\"" >> ${CWD}/conf/local.conf

# Include meta-nxp-desktop for building imx-image-desktop
if [ "$CURRENT_DISTRO" = "imx-desktop-xwayland" ]; then
    if [ -f conf/local.conf ]; then
        echo ""                                                                       >> conf/local.conf
        echo "# Include ubuntu environment and packages settings"                     >> conf/local.conf
        echo "require conf/machine/include/ubuntubasics.inc"                          >> conf/local.conf
        echo ""                                                                       >> conf/local.conf
        echo "# Switch to rpm packaging to avoid rootfs build break"                  >> conf/local.conf
        echo "PACKAGE_CLASSES = \"package_rpm\""                                      >> conf/local.conf
        echo ""                                                                       >> conf/local.conf
        echo "# Save lots of disk space"                                              >> conf/local.conf
        echo "INHERIT += \"rm_work\""                                                 >> conf/local.conf
        echo ""                                                                       >> conf/local.conf
        echo "# Set your proxy if necessary"                                          >> conf/local.conf
        echo "#ENV_HOST_PROXIES = \"http_proxy=\""                                    >> conf/local.conf
        echo ""                                                                       >> conf/local.conf
        echo "# Set user account and password"                                        >> conf/local.conf
        echo "#APTGET_ADD_USERS = \"user:password:shell\""                            >> conf/local.conf
        echo "#  format 'name:password:shell'."                                       >> conf/local.conf
        echo "#    'name' is the user name."                                          >> conf/local.conf
        echo "#    'password' is an encrypted password (e.g. generated with"          >> conf/local.conf
        echo "#    \`echo \"P4sSw0rD\" \| openssl passwd -stdin\`)."                  >> conf/local.conf
        echo "#    If empty or missing, they'll get an empty password."               >> conf/local.conf
        echo "#    'shell' is the default shell (if empty, default is /bin/sh)."      >> conf/local.conf
        echo -e "\n# Change the default user to 'ubuntu'"                             >> conf/local.conf
        echo "APTGET_ADD_USERS = \"ubuntu:xA5hQLsgw2DlE:/bin/bash\""                  >> conf/local.conf

        echo "BBLAYERS += \"\${BSPDIR}/sources/meta-nxp-desktop\""                    >> conf/bblayers.conf

        echo ""
        echo "IMX Desktop setup complete!"
        echo ""
        echo "You can now build the following Desktop images:"
        echo ""
        echo "$ bitbake imx-image-desktop"
        echo ""
    fi
fi

