#!/bin/zsh
# dpkg-buildpackage -d -us -uc

	qmake-qt5
	touch configure-stamp

    make -j $(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1)
	touch build-arch-stamp

	lrelease-qt5 systemback.pro
	touch build-indep-stamp

	rm -f configure-stamp build-*-stamp lang/*.qm libsystemback/libmount.hpp
	[ ! -f Makefile ] || $(MAKE) distclean
	dh_clean

	dh_installdirs -a
	dh_install -a
	dh_installman debian/systemback.1 -p systemback
	dh_installman debian/systemback-cli.1 -p systemback-cli
	# dh_strip --dbg-package=systemback-dbg -p systemback
	# dh_strip --dbg-package=systemback-cli-dbg -p systemback-cli
	# dh_strip --dbg-package=systemback-scheduler-dbg -p systemback-scheduler
	# dh_strip --dbg-package=libsystemback-dbg -p libsystemback
	dh_link -a
	dh_fixperms -a
	chmod 4755 debian/systemback-scheduler/usr/lib/systemback/sbsustart
	dh_makeshlibs -nV "libsystemback (= $(shell dpkg-parsechangelog | sed -n 's/^Version: //p'))" -a
	dh_shlibdeps --dpkg-shlibdeps-params=--ignore-missing-info -a
	dh_installdeb -a
	dh_gencontrol -a
	dh_installdocs -a
	dh_installchangelogs -a
	dh_lintian -a
	dh_compress -a
	dh_builddeb -a

	dh_install -i
	dh_fixperms -i
	dh_installdeb -i
	dh_gencontrol -i
	dh_installdocs -i
	dh_installchangelogs -i
	dh_compress -i
	dh_builddeb -i
