# Systemback

This is a fork of [BluewhaleRobot/systemback](https://github.com/BluewhaleRobot/systemback). The [original project](https://launchpad.net/systemback) is no longer maintained by the creator.

Simple system backup and restore application with extra features

Systemback makes it easy to create backups of the system and the users configuration files. In case of problems you can easily restore the previous state of the system. There are extra features like system copying, system installation and Live system creation.

## Install

* Currently haven't have aur yet *

```bash
pacman-key --recv-key 50B2C005A67B264F --keyserver 'hkp://keyserver.ubuntu.com:80'
yay -S systemback
```

## Build

```bash
git clone https://github.com/shadichy/systemback-archlinux
cd systemback-archlinux
makepkg -si
```

## Changelog

1.8.8

- Merge from https://github.com/fconidi/Systemback_source-1.9.4
- Add support for NVMe