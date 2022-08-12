# Systemback

![Systemback-logo](./systemback/logo.png)

This is a fork of [BluewhaleRobot/systemback](https://github.com/BluewhaleRobot/systemback), which is also a fork of the [original project](https://launchpad.net/systemback) (which is no longer maintained by the creator). This is made for [Arch Linux](http://archlinux.org/) and it's derivatives (Arch-based), such as [Manjaro](https://manjaro.org), [Garuda Linux](http://garudalinux.org/), [RebornOS](https://rebornos.org), [CachyOS](https://cachyos.org),... (and not for Debian or Ubuntu)

![SB](./systemback/systemback.png)

Simple system backup and restore application with extra features

Systemback makes it easy to create backups of the system and the users configuration files. In case of problems you can easily restore the previous state of the system. There are extra features like system copying, system installation and Live system creation.

## Install

### Within Debian (-based)

* It can be built using pure debian (-based, with [debhelper](https://aur.archlinux.org/packages/debhelper)) then convert to arch package with `debtap`

### With AUR helper

```bash
pacman-key --recv-key 50B2C005A67B264F --keyserver 'hkp://keyserver.ubuntu.com:80'
yay -S systemback-bin # works with `paru` or any other aur helper
```

### Prebuilt binaries

* Prebuilt binaries are available at [yuunix_aur](https://github.com/shadichy/yuunix_aur)

add this to your `/etc/pacman.conf` with npacman or the ATT.

```conf
[yuunix_aur]
SigLevel = Optional TrustedOnly
Server = <https://shadichy.github.io/>$repo/$arch
```

then run `sudo pacman -Sy systemback`

## Build

### Clone github repository

```bash
git clone https://github.com/shadichy/systemback-archlinux
cd systemback-archlinux/
```

### Build package

```bash
makepkg # will work if u resolved all deps
```

#### Or

```bash
cd systemback/
dpkg-buildpackage # or debuild
cd ../
debtap <package>.deb
```

Images of Systemback
![prev](https://www.unixmen.com/wp-content/uploads/2014/07/Systemback_010.png)

## Note

> Build successful, installable, but unable to run yet

## Jobs to to

Arch support is still WIP:

* ~~Move `apt` to `pacman`~~ (Done)
* ~~Move `casper` | `live-boot` to `mkinitcpio-live-boot`~~ (Done)
* ~~Move `initramfs-tools` to `mkinitcpio`~~ (Done)
* ~~Add support for `overlayfs`, replacing `unionfs`~~ (Done)
* Fix issues
* request upstream push :)

## Changelog

1.8.9

* Fix support for NVMe

1.8.8

* Merge from <https://github.com/fconidi/Systemback_source-1.9.4>
* Add support for NVMe
