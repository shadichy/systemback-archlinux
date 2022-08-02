# Maintainer: shadichy <shadichy.dev@gmail.com>
pkgbase=systemback
pkgname=("lib${pkgbase}" "${pkgbase}-cli" "${pkgbase}-efiboot-amd64" "${pkgbase}-locales" "${pkgbase}-scheduler" "${pkgbase}")
pkgver=1.8.9
pkgrel=2
pkgdesc='Simple system backup and restore application with extra features'
arch=('x86_64')
url='https://github.com/shadichy/systemback-archlinux'
license=('GPL')
depends=('util-linux' 'util-linux-libs' 'parted' 'qt5-base>=5.5.0' 'gcc-libs' 'procps-ng' 'gnu-free-fonts' 'dosfstools' 'libisoburn' 'squashfs-tools' 'syslinux' 'xterm' 'xz')
optdepends=('grub' 'btrfs-progs' 'jfsutils' 'reiserfsprogs' 'xfsprogs' 'unionfs-fuse' 'kdialog')
makedepends=('ncurses' 'qt5-tools' 'make' 'gcc11' 'dpkg' 'debhelper' 'util-linux' 'util-linux-libs' 'qt5-base>=5.5.0' 'gcc-libs' 'procps-ng')
source=(systemback-archlinux::git+https://github.com/shadichy/systemback-archlinux.git)
md5sums=('SKIP')

build() {
    cd "${srcdir}/${pkgbase}-archlinux/${pkgbase}"
    dpkg-buildpackage -d -us -uc
}

package_libsystemback() {
    # cd "${srcdir}/${pkgbase}-archlinux"
    # echo -e "lib${pkgbase}\n${license[@]}" | debtap -q "lib${pkgbase}_${pkgver}_amd64.deb"
    dpkg-deb -xv "${srcdir}/${pkgbase}-archlinux/lib${pkgbase}_${pkgver}_amd64.deb" "${srcdir}/${pkgbase}-archlinux/lib${pkgbase}"
    cp -dr --no-preserve=ownership "${srcdir}/${pkgbase}-archlinux/lib${pkgbase}/usr" "${pkgdir}/usr"
    install -dm755 "${pkgdir}/usr"
}
package_systemback-cli() {
    # cd "${srcdir}/${pkgbase}-archlinux"
    # echo -e "${pkgbase}-cli\n${license[@]}" | debtap -q "${pkgbase}-cli_${pkgver}_amd64.deb"
    depends+=('ncurses' 'libsystemback' 'systemback-efiboot-amd64')
    dpkg-deb -xv "${srcdir}/${pkgbase}-archlinux/${pkgbase}-cli_${pkgver}_amd64.deb" "${srcdir}/${pkgbase}-archlinux/${pkgbase}-cli"
    cp -dr --no-preserve=ownership "${srcdir}/${pkgbase}-archlinux/${pkgbase}-cli/usr" "${pkgdir}/usr"
    install -dm755 "${pkgdir}/usr"
}
package_systemback-efiboot-amd64() {
    # cd "${srcdir}/${pkgbase}-archlinux"
    # echo -e "${pkgbase}-efiboot-amd64\n${license[@]}" | debtap -q "${pkgbase}-efiboot-amd64_${pkgver}_amd64.deb"
    depends=('syslinux')
    optdepends=('grub' 'systemback')
    dpkg-deb -xv "${srcdir}/${pkgbase}-archlinux/${pkgbase}-efiboot-amd64_${pkgver}_all.deb" "${srcdir}/${pkgbase}-archlinux/${pkgbase}-efiboot-amd64"
    cp -dr --no-preserve=ownership "${srcdir}/${pkgbase}-archlinux/${pkgbase}-efiboot-amd64/usr" "${pkgdir}/usr"
    install -dm755 "${pkgdir}/usr"
}
package_systemback-locales() {
    # cd "${srcdir}/${pkgbase}-archlinux"
    # echo -e "${pkgbase}-locales\n${license[@]}" | debtap -q "${pkgbase}-locales_${pkgver}_amd64.deb"
    depends=()
    optdepends=('systemback')
    dpkg-deb -xv "${srcdir}/${pkgbase}-archlinux/${pkgbase}-locales_${pkgver}_all.deb" "${srcdir}/${pkgbase}-archlinux/${pkgbase}-locales"
    cp -dr --no-preserve=ownership "${srcdir}/${pkgbase}-archlinux/${pkgbase}-locales/usr" "${pkgdir}/usr"
    install -dm755 "${pkgdir}/usr"
}
package_systemback-scheduler() {
    # cd "${srcdir}/${pkgbase}-archlinux"
    # echo -e "${pkgbase}-scheduler\n${license[@]}" | debtap -q "${pkgbase}-scheduler_${pkgver}_amd64.deb"
    depends+=('libsystemback')
    optdepends=('systemback')
    dpkg-deb -xv "${srcdir}/${pkgbase}-archlinux/${pkgbase}-scheduler_${pkgver}_amd64.deb" "${srcdir}/${pkgbase}-archlinux/${pkgbase}-scheduler"
    cp -dr --no-preserve=ownership "${srcdir}/${pkgbase}-archlinux/${pkgbase}-scheduler/usr" "${pkgdir}/usr"
    mkdir -p "${pkgdir}/usr/bin"
    cat << EOF > "${pkgdir}/usr/bin/sbsustart"
#!/bin/bash

BASE_CMD="/usr/lib/systemback/sbsustart \$@"

if test "x\`id -u\`" != "x0"; then
    if test "xpkexec --disable-internal-agent" = "x"; then
        echo "Root privileges are required for running systemback."
        \$BASE_CMD
        exit 1
    fi
    ENABLE_XHOST_ROOT=yes
    GRANTED_XHOST_ROOT=no
    if test "x\$ENABLE_XHOST_ROOT" = 'xyes' && xhost 1> /dev/null 2>&1; then
        if ! xhost | grep -qi 'SI:localuser:root$'; then
            xhost +SI:localuser:root
            GRANTED_XHOST_ROOT=yes
        fi
    fi

    pkexec --disable-internal-agent '/usr/bin/sbsustart' "\$@"
    status=\$?

    if test "x\$GRANTED_XHOST_ROOT" = 'xyes'; then
        xhost -SI:localuser:root
    fi
    exit \$status
fi

\$BASE_CMD
EOF
    chmod +755 "${pkgdir}/usr/bin/sbsustart"
    install -dm755 "${pkgdir}/usr"
}
package_systemback() {
    # cd "${srcdir}/${pkgbase}-archlinux"
    # echo -e "${pkgbase}\n${license[@]}" | debtap -q "${pkgbase}_${pkgver}_amd64.deb"
    depends+=( 'libx11' 'zenity' 'libsystemback' 'systemback-efiboot-amd64' 'systemback-locales' 'systemback-scheduler' )
    dpkg-deb -xv "${srcdir}/${pkgbase}-archlinux/${pkgbase}_${pkgver}_amd64.deb" "${srcdir}/${pkgbase}-archlinux/${pkgbase}"
    cp -dr --no-preserve=ownership "${srcdir}/${pkgbase}-archlinux/${pkgbase}/usr" "${pkgdir}/usr"
    cp "${pkgdir}/usr/share/applications/systemback.desktop" "${pkgdir}/usr/share/applications/org.systemback.systemback.desktop"
    mv "${pkgdir}/usr/bin/systemback" "${pkgdir}/usr/lib/systemback/sbbin"
    cat <<EOF >"${pkgdir}/usr/bin/systemback"
#!/bin/bash

BASE_CMD="/usr/lib/systemback/sbbin \$@"

if test "x\`id -u\`" != "x0"; then
    if test "xpkexec --disable-internal-agent" = "x"; then
        echo "Root privileges are required for running systemback."
        \$BASE_CMD
        exit 1
    fi
    ENABLE_XHOST_ROOT=yes
    GRANTED_XHOST_ROOT=no
    if test "x\$ENABLE_XHOST_ROOT" = 'xyes' && xhost 1> /dev/null 2>&1; then
        if ! xhost | grep -qi 'SI:localuser:root$'; then
            xhost +SI:localuser:root
            GRANTED_XHOST_ROOT=yes
        fi
    fi

    pkexec --disable-internal-agent '/usr/bin/systemback' "\$@"
    status=\$?

    if test "x\$GRANTED_XHOST_ROOT" = 'xyes'; then
        xhost -SI:localuser:root
    fi
    exit \$status
fi

\$BASE_CMD
EOF
    chmod +755 "${pkgdir}/usr/bin/systemback"
    mkdir -p "${pkgdir}/usr/share/polkit-1/actions/"
    cat << EOF > "${pkgdir}/usr/share/polkit-1/actions/org.systemback.systemback.policy"
<?xml version="1.0"?>
<!DOCTYPE policyconfig PUBLIC "-//freedesktop//DTD PolicyKit Policy Configuration 1.0//EN" "http://www.freedesktop.org/standards/PolicyKit/1/policyconfig.dtd">
<policyconfig>
    <vendor>systemback</vendor>
    <vendor_url>https://github.com/shadichy/systemback-archlinux</vendor_url>
    <action id="org.systemback.systemback">
        <description>Run Systemback</description>
        <Message>Authorize Systemback to run</Message>
        <icon_name>systemback</icon_name>
        <defaults>
            <allow_any>auth_admin</allow_any>
            <allow_active>auth_admin</allow_active>
            <allow_inactive>auth_admin</allow_inactive>
        </defaults>
        <annotate key="org.freedesktop.policykit.exec.path">/usr/bin/systemback</annotate>
        <annotate key="org.freedesktop.policykit.exec.allow_gui">true</annotate>
    </action>
</policyconfig>
EOF
    install -dm755 "${pkgdir}/usr"
}
