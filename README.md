# AMCS SecC - Linux OS Module - Version 1.0.1

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
- SoC Requirements 1, 3, 14 werden in services.pp erfüllt.
- SoC Requirements 5, 11, 13, 16, 34, 35, 38 werden über kernel.pp (/etc/sysctl.conf) erfüllt.
- SoC Requirement 15 wird teilweise im SSH Modul (ssh.conf) und teilweise hier erfüllt.
- SoC Requirements 49,50,51 wird über password.pp, Passwort-Policies (/etc/login.defs und /etc/pam.d/*) und Profile erfüllt.

###Abweichungen
- SoC Requirements 2,4,7-10,12,17-20,22-33, 36,37, 39-48,53,54 müssen geprüft werden.

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
- next: iptables integration (maybe own module)
