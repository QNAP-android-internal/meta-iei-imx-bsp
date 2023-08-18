#!/bin/sh

CWD=$(pwd)
PROGNAME="$CWD/imx-setup-release.sh"

if [ -z "$BUILD" ]; then
	BUILD="build"
fi

EULA=1 MACHINE=$MACHINE DISTRO=$DISTRO BUILD_DIR=$BUILD source $PROGNAME $@

CWD=$(pwd)
if [ -f ${CWD}/../sources/meta-iei-imx-bsp/conf/iei-conf/$MACHINE/bblayers.conf.append ]; then
	cat ${CWD}/../sources/meta-iei-imx-bsp/conf/iei-conf/$MACHINE/bblayers.conf.append >> ${CWD}/conf/bblayers.conf
fi
if [ -f ${CWD}/../sources/meta-iei-imx-bsp/conf/iei-conf/$MACHINE/local.conf.append ]; then
	cat ${CWD}/../sources/meta-iei-imx-bsp/conf/iei-conf/$MACHINE/local.conf.append >> ${CWD}/conf/local.conf
fi

echo "PA_USER ?= \"iei-user\"" >> ${CWD}/conf/local.conf

