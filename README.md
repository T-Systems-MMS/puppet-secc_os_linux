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
Dieses Modul bietet eine Abdeckung der SoC Anforderungen für Linux

## Module Description
Das Modul kontrolliert sowohl Kernelsettings in /etc/sysctl.conf, Dienste Status via chkconfig bzw. deren Existenz (z.B. telnet), /etc/login.defs, /etc/pam.d/system-auth, /etc/pam.d/system-auth und  als auch XXXX.

## Requirement - Abdeckung
- SoC Requirements 3.01-1, 3.01-3, 3.37-7 werden in packages.pp sowie services.pp erfüllt.
- SoC Requirements 3.21-1, 3.21-3, 3.21-5, 3.37-6, 3.37-10, 3.37-11, 3.37-12 werden über kernel.pp (/etc/sysctl.conf) erfüllt.
- SoC Requirement 3.21-4 wird teilweise im SSH Modul (ssh.conf) und teilweise hier erfüllt.
- SoC Requirements 3.01-23, 3.01-24, 3.01-25 wird über password.pp und login_defs.pp, Passwort-Policies (/etc/login.defs und /etc/pam.d/\*) und Profile erfüllt.
- SoC Requirement 3.21-10 wird in profile.pp erfüllt.

## Abweichungen
- nicht abgedeckte SoC Requirements müssen geprüft und ggf. in diesem Modul ergänzt werden.

## Teile
- audit konfiguriert rudimentäres Protokollieren von Aktivitäten auf der Bash. Kann über die syslog-Konfiguration von local6 auch an andere Server gesandt werden.
- inputrc konfiguriert Search-Verhalten der Bash (strg+r)
- syslog konfiguriert das Loggen von:
-- authpriv /var/log/secure
-- local6 /var/log/bash_history (bash audit)
- kernel setzt vor Allem netzwerkrelevante Settings in der /etc/sysctl.conf um.
- login_defs kontrolliert default umask, encryption modes und password min age.
- password stellt Passwortrichtlinien bereit (mind. 1 Sonderzeichen, Groß- wie Kleinbuchstaben und eine Zahl, sowie eine Mindestanzahl von 10 Zeichen)
- profile kontrolliert default umask, kann aber parametrisiert werden <span style="color:red">!! mit dem parametrisieren der umask werden die SOC Requirements  umgangen </span>
- rootsh stellt saubere Loggingmoeglichkeiten auf ssh Ebene zur Verfügung (ausschliesslich Redhat Derivate; leichte Dopplung zu audit )
- services steuert die Existenz und den Status von Diensten
- syslog stellt ein standardisiertes von SSH Aktivitäten und Bash-Loggings her (/var/log/secure und /var/log/bash_history)
- logrotate rotiert bash_history

# Usage
- Das Modul sollte 1-zu-1 in die Projekt-Repositories übernommen werden können, aber der Rollout sollte kontrolliert über die einzelnen Umgebungen Richtung Live erfolgen.
- um die Funktion von logrotate sicherzustellen, muss das Package wenn es nicht schon installiert ist manuell installiert werden
- Die Konfiguration der mounts kann deaktiviert werden:
  - Beispiel:
  ```
  secc_os_linux::ext_secure_mountpoint_tmp: false
  secc_os_linux::ext_secure_mountpoint_var: false
  secc_os_linux::ext_secure_mountpoint_var_tmp: false
  secc_os_linux::ext_secure_mountpoint_home: false
  ```
- Weiterhin können die mount-Parameter der einzelnen Partitionen separat angepasst werden:
  - Beispiel:
  ```
  secc_os_linux::ext_mount_options_tmp: 'defaults,noexec,nodev,nosuid'
  secc_os_linux::ext_mount_options_var: 'defaults,noexec,nodev,nosuid'
  secc_os_linux::ext_mount_options_home: 'defaults,nodev'
  secc_os_linux::ext_mount_options_var_tmp: 'bind'
  ```

## Usage ohne Puppet
- Eine Copy&Paste Übernahme in Projekte ist nicht möglich, aber die notwendigen Parameter sind anhand der Manifeste und Templates auslesbar.

## Verifikation
- Die Verifikation des sicheren Moduls kann über Serverspec (s. Serverspec im Repo) getestet werden.

# Reference
- Anforderungen stammen aus den technischen Sicherheitsanforderungen (https://www.telekom.com/psa) des PSA Verfahrens

# Limitations
- Modul wurde erfolgreich gegen CentOS6, RHEL6, RHEL7, SLES11 und SLES12 getestet.
- Bash-Auditing funktioniert nicht bei SLES 11, da "history" in PROMPT_COMMAND leer ist.
