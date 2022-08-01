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
makedepends=('ncurses' 'qt5-tools' 'debtap' 'make' 'gcc11' 'dpkg')
optdepends=('grub' 'btrfs-progs' 'jfsutils' 'reiserfsprogs' 'xfsprogs' 'unionfs-fuse')
source=(systemback-archlinux::git+https://github.com/shadichy/systemback-archlinux.git)
md5sums=('SKIP')

build() {
    cd "${srcdir}/${pkgbase}-archlinux/${pkgbase}"
    # cd "../${pkgbase}"

    dpkg-buildpackage -d -us -uc
    # /usr/bin/konsole -e "/bin/zsh -c 'dpkg-buildpackage -d -us -uc'"
	# qmake-qt5
	# touch configure-stamp

    # make -j $(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1)
	# touch build-arch-stamp

	# lrelease-qt5 systemback.pro
	# touch build-indep-stamp

	# rm -f configure-stamp build-*-stamp lang/*.qm libsystemback/libmount.hpp
	# [ ! -f Makefile ] || $(MAKE) distclean
	# dh_clean

	# dh_installdirs -a
	# dh_install -a
	# dh_installman debian/systemback.1 -p systemback
	# dh_installman debian/systemback-cli.1 -p systemback-cli
	# dh_strip --dbg-package=systemback-dbg -p systemback
	# dh_strip --dbg-package=systemback-cli-dbg -p systemback-cli
	# dh_strip --dbg-package=systemback-scheduler-dbg -p systemback-scheduler
	# dh_strip --dbg-package=libsystemback-dbg -p libsystemback
	# dh_link -a
	# dh_fixperms -a
	# chmod 4755 debian/systemback-scheduler/usr/lib/systemback/sbsustart
	# dh_makeshlibs -nV "libsystemback (= $(shell dpkg-parsechangelog | sed -n 's/^Version: //p'))" -a
	# dh_shlibdeps --dpkg-shlibdeps-params=--ignore-missing-info -a
	# dh_installdeb -a
	# dh_gencontrol -a
	# dh_installdocs -a
	# dh_installchangelogs -a
	# dh_lintian -a
	# dh_compress -a
	# dh_builddeb -a

	# dh_install -i
	# dh_fixperms -i
	# dh_installdeb -i
	# dh_gencontrol -i
	# dh_installdocs -i
	# dh_installchangelogs -i
	# dh_compress -i
	# dh_builddeb -i
}

package_libsystemback() {
    cd "${srcdir}/${pkgbase}-archlinux"
    echo -e "lib${pkgbase}\n${license[@]}" | debtap -q "lib${pkgbase}-$pkgver-amd64.deb"
}
package_systemback-cli() {
    cd "${srcdir}/${pkgbase}-archlinux"
    echo -e "${pkgbase}-cli\n${license[@]}" | debtap -q "${pkgbase}-cli-$pkgver-amd64.deb"
}
package_systemback-efiboot-amd64() {
    cd "${srcdir}/${pkgbase}-archlinux"
    echo -e "${pkgbase}-efiboot-amd64\n${license[@]}" | debtap -q "${pkgbase}-efiboot-amd64-$pkgver-amd64.deb"
}
package_systemback-locales() {
    cd "${srcdir}/${pkgbase}-archlinux"
    echo -e "${pkgbase}-locales\n${license[@]}" | debtap -q "${pkgbase}-locales-$pkgver-amd64.deb"
}
package_systemback-scheduler() {
    cd "${srcdir}/${pkgbase}-archlinux"
    echo -e "${pkgbase}-scheduler\n${license[@]}" | debtap -q "${pkgbase}-scheduler-$pkgver-amd64.deb"
}
package_systemback() {
    cd "${srcdir}/${pkgbase}-archlinux"
    echo -e "${pkgbase}\n${license[@]}" | debtap -q "${pkgbase}-$pkgver-amd64.deb"
}


