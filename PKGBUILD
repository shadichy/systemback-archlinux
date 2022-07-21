# Maintainer: shadichy <shadichy.dev@gmail.com>
pkgbase=systemback
pkgname=("lib${pkgbase}" "${pkgbase}-cli" "${pkgbase}-efiboot-amd64" "${pkgbase}-locales" "${pkgbase}-scheduler" "${pkgbase}")
pkgver=1.8.9
pkgrel=2
pkgdesc='Simple system backup and restore application with extra features'
arch=('x86_64')
url='https://github.com/shadichy/systemback-archlinux'
license=('GPL')
depends=('util-linux' 'util-linux-libs' 'parted' 'qt5-base>=5.5.0' 'gcc-libs' 'procps-ng' 'mkinitcpio-live-boot' 'gnu-free-fonts' 'libx11' 'dosfstools' 'libisoburn' 'squashfs-tools' 'syslinux' 'xterm' 'gdialog' 'xz')
makedepends=('ncurses' 'qt5-tools' 'base-devel' 'debtap' 'debhelper' )
optdepends=('grub' 'btrfs-progs' 'jfsutils' 'reiserfsprogs' 'xfsprogs' 'unionfs-fuse')
source=(systemback-archlinux::https://github.com/shadichy/systemback-archlinux.git)
md5sums=('SKIP')

prepare() {
    kname=$(pacman -Qo /usr/lib/modules/$(uname -r) | grep -v headers | awk '{print $5}')
    cd "${srcdir}"
    cp libsystemback/slib.cpp libsystemback/slib.cpp.bak
    sed -i 's/${default-kernel}/'$kname'/g' libsystemback/slib.cpp
    cp systemback/systemback.cpp systemback/systemback.cpp.bak
    sed -i 's/${default-kernel}/'$kname'/g' systemback/systemback.cpp
}

build() {
    cd "$srcdir"
    dpkg-buildpackage -d -us -uc
}

package() {
    sudo debtap -u
    for pkg in "${pkgname[@]}"; do
        debtap -q "$pkg-$pkgver-amd64.deb" << EOF
        $pkg
        ${license[@]}
        EOF

    done

    cd "${srcdir}"
    rm -f libsystemback/slib.cpp
    mv libsystemback/slib.cpp.bak libsystemback/slib.cpp
    rm -f systemback/systemback.cpp
    mv systemback/systemback.cpp.bak systemback/systemback.cpp

}



