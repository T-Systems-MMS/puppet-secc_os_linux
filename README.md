# SecC OS Linux Module

[![Build Status](https://travis-ci.org/T-Systems-MMS/puppet-secc_os_linux.svg?branch=master)](https://travis-ci.org/T-Systems-MMS/puppet-secc_os_linux)

## Table of Contents
1. [Overview](#overview)
3. [Module Description - What the module does and why it is useful](#module-description)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)

## Overview

This module provides coverage of the SoC conditions for Linux.

## Module Description

This module adjusts kernel settings in `/etc/sysctl.conf`, manages services, uninstalls unneeded packages.
Further it manages files relevant for user authentication, including `/etc/login.defs` and `/etc/pam.d/system-auth`.

## Requirement - Coverage

* SoC Requirements 3.01-1, 3.01-3, 3.37-7 are covered in `packages.pp` and `services.pp`
* SoC Requirements 3.21-1, 3.21-3, 3.21-5, 3.37-6, 3.37-10, 3.37-11, 3.37-12 are covered via `kernel.pp` (`/etc/sysctl.conf`)
* SoC Requirement 3.21-4 are partially covered in `secc_sshd` and with this module
* SoC Requirements 3.01-23, 3.01-24, 3.01-25 are covered via `password.pp`, `login_defs.pp` (password policies - `/etc/login.defs` and `/etc/pam.d/*`) and `profile.pp`
* SoC Requirement 3.21-10 is covered in `profile.pp`

## Parts
* `audit.pp` configures rudimentary logging of bash activities
  * logging can be redirected via syslog to an external server (facility: local6)
* `inputrc.pp` configures bash history search (ctrl+r)
* `kernel.pp` manages `/etc/sysctl.conf` with mostly network relevant settings
* `login_defs.pp` controlls default umask, encryption modes and password min age
* `logrotate.pp` adds rotation for bash_history
* `modules.pp` blacklists some problemativ kernel modules
* `mounts.pp` controlls mount points and sets sensible mount options
* `packages.pp` uninstalls unneeded software
* `password.pp` configures passwort policy (1 special character, upper and lower case letters, and at least one digit, minimum size of 10 chars)
* `profile.pp` controlls default umask
  * can be parametrized, but this breaks SoC compliance
* `rootsh.pp` providews logging of all root acitivites via `rootsh` (slight duplication to audit logging)
* `services.pp` manages state of detault services
* `syslog.pp`configures logging of:
  * authpriv /var/log/secure
  * local6 /var/log/bash_history (bash audit)
* `users_group.pp` deletes unneeded groups and user accounts

# Usage
* the package `logrotate` has to be installed manually
* Configuration of mount points can be deactivated
  * Example:
  ```
  secc_os_linux::ext_secure_mountpoint_tmp: false
  secc_os_linux::ext_secure_mountpoint_var: false
  secc_os_linux::ext_secure_mountpoint_var_tmp: false
  secc_os_linux::ext_secure_mountpoint_home: false
  ```
* Parameters for mount points can be tuned on a per partition basis
  * Example:
  ```
  secc_os_linux::ext_mount_options_tmp: 'defaults,noexec,nodev,nosuid'
  secc_os_linux::ext_mount_options_var: 'defaults,noexec,nodev,nosuid'
  secc_os_linux::ext_mount_options_home: 'defaults,nodev'
  secc_os_linux::ext_mount_options_var_tmp: 'bind'
  ```

# Reference

* The requirements come from the technical safety requirements (https://www.telekom.com/psa) of the PSA procedure

# Limitations

* This module was tested with CentOS6 and CentOS7
