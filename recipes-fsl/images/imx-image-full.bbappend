install_demo:append() {

    if grep -q "icon=/home/root/.nxp-demo-experience/icon/icon_demo_launcher.png" ${IMAGE_ROOTFS}${sysconfdir}/xdg/weston/weston.ini
    then
        perl -0 -i -p -e 's/\[launcher\]\nicon=\/home\/root\/\.nxp-demo-experience\/icon\/icon_demo_launcher.png\npath=\/usr\/bin\/demoexperience//g;' ${IMAGE_ROOTFS}${sysconfdir}/xdg/weston/weston.ini
    fi

    printf "\n[launcher]\nicon=/usr/share/iei-lightbar/iei-lightbar_launcher.png\npath=/usr/bin/ieiLightbar" >> ${IMAGE_ROOTFS}${sysconfdir}/xdg/weston/weston.ini
}
