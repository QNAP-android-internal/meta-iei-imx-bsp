OS_RELEASE_FIELDS = "\
    ID BUILD_ID \
"

do_compile[nostamp] = "1"

do_install:append() {
    META_IEI_PATH=$(echo ${BBPATH} | awk -F: '{for (i=1;i<=NF;i++)printf("%s\n", $i)}' |grep meta-iei-imx-bsp)
    cd ${META_IEI_PATH}

    case ${MACHINE} in
        wafer-imx8mp)
            PRODUCT_ID="B643"
        ;;
        imx95-smarc-ismc-cb)
            PRODUCT_ID="B0787"
        ;;
        *)
            PRODUCT_ID=""
        ;;
    esac

    if [ -n "${POKY_VERSION_UPSTREAM}" ]; then

        PREFIX_STR="${PRODUCT_ID}_YOCTO-${POKY_VERSION_UPSTREAM}"
        FOUND_TAG=$(git tag -l "*${PREFIX_STR}-R*" --sort=-v:refname | sed -n 1p)

        if [ -n "$FOUND_TAG" ]; then
                OS_VERSION="${FOUND_TAG}"
        else
                OS_VERSION="${PREFIX_STR}-DEV"
        fi
    fi

    cd -
    install -d ${D}${sysconfdir}
    echo "VERSION=${OS_VERSION}" >> ${D}${sysconfdir}/os-release
}

