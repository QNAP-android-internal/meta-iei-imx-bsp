OS_RELEASE_FIELDS = "\
    ID BUILD_ID \
"

do_compile[nostamp] = "1"

do_install:append() {
    META_IEI_PATH=$(echo ${BBPATH} | awk -F: '{for (i=1;i<=NF;i++)printf("%s\n", $i)}' |grep meta-iei-imx-bsp)
    cd ${META_IEI_PATH}

    case ${MACHINE} in
        wafer-imx8mp)
            OS_VERSION=$(git tag -l "*YOCTO-050-*" --sort=-v:refname | sed -n 1p)
        ;;
    esac
    cd -
    install -d ${D}${sysconfdir}
    echo "VERSION=${OS_VERSION}" >> ${D}${sysconfdir}/os-release
}

