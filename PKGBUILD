# Maintainer: shadichy <shadichy.dev@gmail.com>
pkgbase=systemback
pkgname=("lib${pkgbase}" "${pkgbase}-cli" "${pkgbase}-efiboot-amd64" "${pkgbase}-locales" "${pkgbase}-scheduler" "${pkgbase}")
pkgver=1.8.9
pkgrel=2
pkgdesc='Simple system backup and restore application with extra features'
arch=('x86_64')
url='https://github.com/shadichy/systemback-archlinux'
license=('GPL')
depends=('util-linux' 'util-linux-libs' 'parted' 'qt5-base>=5.5.0' 'gcc-libs' 'procps-ng' 'gnu-free-fonts' 'libx11' 'dosfstools' 'libisoburn' 'squashfs-tools' 'syslinux' 'xterm' 'zenity' 'xz')
makedepends=('ncurses' 'qt5-tools' 'debtap' 'make' )
optdepends=('grub' 'btrfs-progs' 'jfsutils' 'reiserfsprogs' 'xfsprogs' 'unionfs-fuse')
source=(systemback-archlinux::git+https://github.com/shadichy/systemback-archlinux.git)
md5sums=('SKIP')

prepare() {
    kname=$(pacman -Qo /usr/lib/modules/$(uname -r) | grep -v headers | awk '{print $5}')
    cd "${srcdir}/${pkgbase}-archlinux/${pkgbase}"
    cp libsystemback/sblib.cpp libsystemback/sblib.cpp.bak
    sed -i 's/${default-kernel}/'$kname'/g' libsystemback/sblib.cpp
    cp systemback/systemback.cpp systemback/systemback.cpp.bak
    sed -i 's/${default-kernel}/'$kname'/g' systemback/systemback.cpp
}

build() {
    cd "${srcdir}/${pkgbase}-archlinux/${pkgbase}"
    dpkg-buildpackage -d -us -uc
}

package_libsystemback() {
    cd "${srcdir}/${pkgbase}-archlinux"
    echo -e "$pkg\n${license[@]}" | debtap -q "libsystemback-$pkgver-amd64.deb"

    cd "${pkgbase}"
    rm -f libsystemback/slib.cpp
    mv libsystemback/slib.cpp.bak libsystemback/slib.cpp
}
package_systemback-cli() {
    cd "${srcdir}/${pkgbase}-archlinux"
    echo -e "$pkg\n${license[@]}" | debtap -q "systemback-cli-$pkgver-amd64.deb"
}
package_systemback-efiboot-amd64() {
    cd "${srcdir}/${pkgbase}-archlinux"
    echo -e "$pkg\n${license[@]}" | debtap -q "systemback-efiboot-amd64-$pkgver-amd64.deb"
}
package_systemback-locales() {
    cd "${srcdir}/${pkgbase}-archlinux"
    echo -e "$pkg\n${license[@]}" | debtap -q "systemback-locales-$pkgver-amd64.deb"
}
package_systemback-scheduler() {
    cd "${srcdir}/${pkgbase}-archlinux"
    echo -e "$pkg\n${license[@]}" | debtap -q "systemback-scheduler-$pkgver-amd64.deb"
}
package_systemback() {
    cd "${srcdir}/${pkgbase}-archlinux"
    echo -e "$pkg\n${license[@]}" | debtap -q "systemback-$pkgver-amd64.deb"

    cd "${pkgbase}"
    rm -f systemback/systemback.cpp
    mv systemback/systemback.cpp.bak systemback/systemback.cpp
}


