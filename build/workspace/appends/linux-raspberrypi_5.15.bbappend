FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
FILESPATH:prepend := "/home/retpolanne/Dev/renesas-journey-rpicm4/build/workspace/sources/linux-raspberrypi/oe-local-files:"
# srctreebase: /home/retpolanne/Dev/renesas-journey-rpicm4/build/workspace/sources/linux-raspberrypi

inherit externalsrc
# NOTE: We use pn- overrides here to avoid affecting multiple variants in the case where the recipe uses BBCLASSEXTEND
EXTERNALSRC:pn-linux-raspberrypi = "/home/retpolanne/Dev/renesas-journey-rpicm4/build/workspace/sources/linux-raspberrypi"
SRCTREECOVEREDTASKS = "do_validate_branches do_kernel_checkout do_fetch do_unpack do_kernel_configcheck"

do_patch[noexec] = "1"

do_configure:append() {
    cp ${B}/.config ${S}/.config.baseline
    ln -sfT ${B}/.config ${S}/.config.new
}

do_kernel_configme:prepend() {
    if [ -e ${S}/.config ]; then
        mv ${S}/.config ${S}/.config.old
    fi
}

do_configure:append() {
    if [ ! ${DEVTOOL_DISABLE_MENUCONFIG} ]; then
        cp ${B}/.config ${S}/.config.baseline
        ln -sfT ${B}/.config ${S}/.config.new
    fi
}

# initial_rev: 0086da6acd41600d47b87b05874f99704216426f
