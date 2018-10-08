# CHANGELOG
## [UNRELEASED]
* extended tests for /etc/profile.d/umask.sh

## [1.9.0] - 2018-07-23
* remove obsolete files
* add `abrtd` to disabled services
* add rsyslog.d to managed directories

## [1.8.0] - 2018-07-15
* initial public release

## [1.5.0]
* make mountpoints configurable
* add teamcity tests

## [1.3.26]
* added parameter to disable rsyslog service management

## [1.3.0]
* removed the not needed SLES stuff
* moved rsyslog config to own file under /etc/rsyslog.d/
* removed non needed files from module

## [1.2.0]
* added CIS compliant mount point configurations
* disabled firewall and usb storage kernel modules

## [1.1.0]
* added test kitchen integration (with ruby 2.2.4)
* parameters for xinetd and tftp-servers

## [1.0.3]
* fixed alsa-firmware conflict, which occured only once at the first run

## [1.0.2]
* added arpwatch to detect arp-spoofing attack (alerting not included)

## [1.0.1]
* fix of rootsh integration in /etc/profile to allow non interactive shells to work (like scp)
