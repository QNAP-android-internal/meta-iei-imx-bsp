#
# Modified Startup script and systemd unit file for the Weston Wayland compositor
#
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " file://setup-weston-init.sh"

S = "${WORKDIR}/sources"
UNPACKDIR = "${S}"

do_install:append() {
	install -d ${D}${bindir}
	install -p -m 0755 ${S}/setup-weston-init.sh ${D}${bindir}

	sed -i '/^ExecStart=\/usr\/bin\/weston*/i ExecStartPre=-\/usr\/bin\/setup-weston-init.sh' ${D}${systemd_system_unitdir}/weston.service
	sed -i '/^\[core\]/a require-outputs=none' ${D}${sysconfdir}/xdg/weston/weston.ini

	# Set HDMI as primary output
	echo 'WESTON_DRM_PRIMARY=HDMI-A-1' >> ${D}${sysconfdir}/default/weston
}

FILES:${PN} += "${bindir}/setup-weston-init.sh"
