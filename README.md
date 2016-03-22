# AMCS SecC - Linux OS Module - Version 1.2.1

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview
Dieses Modul bietet eine Abdeckung der SoC Anforderungen für Linux.

##Module Description
Das Modul kontrolliert sowohl Kernelsettings in /etc/sysctl.conf, Dienste Status via chkconfig bzw. deren Existenz (z.B. telnet), /etc/login.defs, /etc/pam.d/system-auth, /etc/pam.d/system-auth und  als auch XXXX.

###Requirement - Abdeckung
- SoC Requirements 3.01-1, 3.01-3, 3.37-7 werden in packages.pp sowie services.pp erfüllt.
- SoC Requirements 3.21-1, 3.21-3, 3.21-5, 3.37-6, 3.37-10, 3.37-11, 3.37-12 werden über kernel.pp (/etc/sysctl.conf) erfüllt.
- SoC Requirement 3.21-4 wird teilweise im SSH Modul (ssh.conf) und teilweise hier erfüllt.
- SoC Requirements 3.01-23, 3.01-24, 3.01-25 wird über password.pp und login_defs.pp, Passwort-Policies (/etc/login.defs und /etc/pam.d/*) und Profile erfüllt.
- SoC Requirement 3.21-10 wird in profile.pp erfüllt.

###Abweichungen
- nicht abgedeckte SoC Requirements müssen geprüft und ggf. in diesem Modul ergänzt werden.

### Teile
- audit konfiguriert rudimentäres Protokollieren von Aktivitäten auf der Bash. Kann über die syslog-Konfiguration von local6 auch an andere Server gesandt werden.
- inputrc konfiguriert Search-Verhalten der Bash (strg+r)
- syslog konfiguriert das Loggen von:
-- authpriv /var/log/secure
-- local6 /var/log/bash_history (bash audit)
- kernel setzt vor Allem netzwerkrelevante Settings in der /etc/sysctl.conf um.
- login_defs kontrolliert default umask, encryption modes und password min age.
- password stellt Passwortrichtlinien bereit (mind. 1 Sonderzeichen, Groß- wie Kleinbuchstaben und eine Zahl, sowie eine Mindestanzahl von 10 Zeichen)
- profile kontrolliert default umask
- rootsh stellt saubere Loggingmoeglichkeiten auf ssh Ebene zur Verfügung (ausschliesslich Redhat Derivate; leichte Dopplung zu audit )
- services steuert die Existenz und den Status von Diensten
- syslog stellt ein standardisiertes von SSH Aktivitäten und Bash-Loggings her (/var/log/secure und /var/log/bash_history)

##Usage
- Das Modul sollte 1-zu-1 in die Projekt-Repositories übernommen werden können, aber der Rollout sollte kontrolliert über die einzelnen Umgebungen Richtung Live erfolgen.
- Wichtig ist die Anpassung der Partitionsparameter (secure_mountpoint_*), da sonst das Modul fehlschlagen kann.

###Usage ohne Puppet
- Eine Copy&Paste Übernahme in Projekte ist nicht möglich, aber die notwendigen Parameter sind anhand der Manifeste und Templates auslesbar.

###Verifikation
- Die Verifikation des sicheren Moduls kann über Serverspec (s. Serverspec im Repo) getestet werden.

##Reference
- OS(Unix)-Anforderungen stammen aus PSA 07 2015.

##Limitations
- Modul wurde erfolgreich gegen CentOS6, RHEL6, RHEL7, SLES11 und SLES12 getestet.
- Bash-Auditting funktioniert nicht bei SLES 11, da "history" in PROMPT_COMMAND leer ist.

##Development
- Änderungen am Modul sollten auch im Serverspec Script secc_os_linux_spec.rb nachgezogen werden.

##Release Notes/Contributors/Etc **Optional**
- Initialrelease.
- 1.0.1 fix of rootsh integration in /etc/profile to allow non interactive shells to work (like scp)
- 1.0.2 added arpwatch to detect arp-spoofing attack (alerting not included)
- 1.0.3 fixed alsa-firmware conflict, which occured only once at the first run
- 1.1.0 added test kitchen integration (with ruby 2.2.4) and parameters for xinetd and tftp-servers
- 1.2.0 added CIS compliant mount point configurations and disabled firewall and usb storage kernel modules
- 1.3.0 removed the not needed SLES stuff, moved rsyslog config to own file under /etc/rsyslog.d/, removed non needed files from module
- next: iptables integration (maybe own module) or augeas instead of file_line

