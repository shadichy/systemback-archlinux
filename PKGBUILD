# Maintainer: shadichy <shadichy.dev@gmail.com>
pkgbase=systemback
sb=$pkgbase
pkgname=("lib${sb}" "${sb}-cli" "${sb}" "${sb}-efiboot-amd64")
pkgver=1.8.9
pkgrel=4
pkgdesc='Simple system backup and restore application with extra features'
arch=(x86_64 i686 pentium4)
march=""
url='https://github.com/shadichy/systemback-archlinux'
license=('GPL')
depends=('util-linux' 'util-linux-libs' 'parted' 'qt5-base>=5.5.0' 'procps-ng' 'gnu-free-fonts' 'dosfstools' 'libisoburn' 'squashfs-tools' 'syslinux' 'xterm' 'xz' 'mkinitcpio-live-boot' 'zstd')
optdepends=('btrfs-progs' 'jfsutils' 'reiserfsprogs' 'xfsprogs' 'unionfs-fuse' 'update-grub' 'cdrtools')
makedepends=('ncurses' 'qt5-tools' 'make' 'gcc11' 'dpkg' 'util-linux' 'util-linux-libs' 'qt5-base>=5.5.0' 'gcc11-libs' 'procps-ng' 'libarchive')
# source=()
# md5sums=('SKIP')

case $(uname -m) in
x86_64) march="amd64" ;;
i?86)
    march="i386"
    depends+=('libxcrypt-compat' 'llvm13-libs')
    ;;
*)
    echo "Unsupported architecture: $(uname -m)"
    exit 1
    ;;
esac

build() {
    cd "../${sb}"
    qmake-qt5
    make -j$(nproc --all)
    lrelease-qt5 systemback.pro
}

package_libsystemback() {
    pkgdesc='Libary for Systemback'

    mkdir -p ${pkgdir}/usr/lib/${sb}
    mkdir -p ${pkgdir}/usr/include/lib${sb}
    mkdir -p ${pkgdir}/usr/share/${sb}/scripts
    mkdir -p ${pkgdir}/usr/share/licenses/${sb}

    cd "../${sb}"

    install -dm755 ${pkgdir}/usr/lib/${sb}
    install -dm755 ${pkgdir}/usr/include/lib${sb}
    install -dm755 ${pkgdir}/usr/share/${sb}/scripts
    install -dm755 ${pkgdir}/usr/share/licenses/${sb}

    install -m755 lib${sb}/lib${sb}.so* ${pkgdir}/usr/lib/${sb}
    install -m755 lib${sb}/*.hpp ${pkgdir}/usr/include/lib${sb}
    install -m755 lib${sb}/scripts/* ${pkgdir}/usr/share/${sb}/scripts
    install -m755 LICENSE ${pkgdir}/usr/share/licenses/${sb}
}
package_systemback-cli() {
    depends+=('ncurses' "lib${sb}")

    mkdir -p ${pkgdir}/usr/bin
    install -dm755 ${pkgdir}/usr/bin

    cd "../${sb}"

    install -m755 ${sb}-cli/${sb}-cli ${pkgdir}/usr/bin
}
package_systemback() {
    depends+=('libx11' 'zenity' "lib${sb}" 'grub' 'mtools' 'arch-install-scripts')
    optdepends+=('kdialog' 'amd-ucode' 'intel-ucode')

    case $march in
    x86_64) optdepends+=('systemback-efiboot-amd64') ;;
    i?86) depends+=('systemback-efiboot-amd64') ;;
    esac
    mkdir -p ${pkgdir}/etc/${sb}
    mkdir -p ${pkgdir}/etc/xdg/autostart

    mkdir -p ${pkgdir}/usr/bin
    mkdir -p ${pkgdir}/usr/lib/${sb}

    mkdir -p ${pkgdir}/usr/share/${sb}/lang
    mkdir -p ${pkgdir}/usr/share/polkit-1/actions/

    appdir=usr/share/applications
    mkdir -p ${pkgdir}/$appdir

    icondir=usr/share/icons/hicolor
    mkdir -p ${pkgdir}/$icondir/128x128/apps
    mkdir -p ${pkgdir}/$icondir/256x256/apps
    mkdir -p ${pkgdir}/$icondir/48x48/apps
    mkdir -p ${pkgdir}/$icondir/64x64/apps

    cd "../${sb}"

    install -dm664 ${pkgdir}/etc/${sb}
    install -dm644 ${pkgdir}/usr/share/${sb}/lang
    install -dm644 ${pkgdir}/usr/share/polkit-1/actions/

    install -dm644 ${pkgdir}/$icondir/128x128/apps
    install -dm644 ${pkgdir}/$icondir/256x256/apps
    install -dm644 ${pkgdir}/$icondir/48x48/apps
    install -dm644 ${pkgdir}/$icondir/64x64/apps

    install -dm755 ${pkgdir}/etc/xdg/autostart
    install -dm755 ${pkgdir}/$appdir

    install -dm755 ${pkgdir}/usr/lib/${sb}
    install -dm755 ${pkgdir}/usr/bin

    install -m660 ${sb}.conf ${pkgdir}/etc/${sb}
    install -m644 lang/*.qm ${pkgdir}/usr/share/${sb}/lang
    install -m644 org.${sb}.sbsustart.policy ${pkgdir}/usr/share/polkit-1/actions/

    install -m644 icons/128x128/${sb}.png ${pkgdir}/$icondir/128x128/apps
    install -m644 icons/256x256/${sb}.png ${pkgdir}/$icondir/256x256/apps
    install -m644 icons/48x48/${sb}.png ${pkgdir}/$icondir/48x48/apps
    install -m644 icons/64x64/${sb}.png ${pkgdir}/$icondir/64x64/apps

    install -m755 sbschedule.desktop ${pkgdir}/etc/xdg/autostart
    install -m755 org.${sb}.${sb}.desktop ${pkgdir}/$appdir
    ln -s org.${sb}.${sb}.desktop ${pkgdir}/$appdir/${sb}.desktop

    install -m755 sbscheduler/sbscheduler \
        sbsustart/sbsustart \
        sbsysupgrade/sbsysupgrade \
        ${pkgdir}/usr/lib/${sb}

    install -m755 ../sbsustart \
        ${sb}/${sb} \
        ${pkgdir}/usr/bin
}

package_systemback-efiboot-amd64() {
    mkdir -p ${pkgdir}/usr/share/${sb}
    install -dm644 ${pkgdir}/usr/share/${sb}

    if [ $march = amd64 ]; then
        grub-mkrescue -V "SBROOT" -o "grub.iso" --modules="part_msdos part_gpt part_apple fat exfat iso9660 hfs hfsplus ntfs crypto gzio zstd xzio lzopio" --themes=
        bsdtar -xf grub.iso
        rm -f grub.iso
        tar --zstd -cf efi-amd64.bootfiles ./*
    else
        cd "../${sb}"
    fi
    install -m644 efi-amd64.bootfiles ${pkgdir}/usr/share/${sb}
}
