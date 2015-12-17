# config for service availability and status
# copied from puppet os hardening module - see hardening.io for details

class secc_os_linux::services {

  # SoC - Requirement 3.01-1 - Nicht benötigte Dienste und Protokolle müssen deaktiviert werden.
  #    stop: https://git.fedorahosted.org/cgit/aqueduct.git/tree/compliance/puppet/stig/rhel-6/modules/services/manifests/init.pp
  # SoC - Requirement 3.01-3 - Nicht benötigte Software darf nicht installiert oder muss deinstalliert werden.
  #    deinstall: telnet, abrt
  # SoC - Requirement 3.37-7 - Das automatische Starten von Anwendungen auf Wechseldatenträgern muss abgeschaltet werden.
  #     autofs

  service {
    [
      'acpid',
      'anacron',
      'atd',
      'cups',
      'dhcpd',
      'network-remotefs', # needs to come before haldaemon for SLES11
      'haldaemon',
      'lm_sensors',
      'mdmonitor',
      'named',
      'netconsole',
      'netfs',
      'nfs',     # only remove this line if nfs must be enabled
      'nfslock', # only remove this line if nfs must be enabled
      'ntpdate',
      'oddjobd',
      'portmap',
      'portreserve',
      'qpidd',
      'quota_nld',
      'rdisc',
      'rhnsd',    # RHEL specific
      'rhsmcertd', # RHEL specific
      'rpcgssd', # only remove this line if nfs must be enabled and Kerberos is in use
      'rpcidmapd', # only remove this line if nfs must be enabled and NFSv4 is in use
      'rpcsvcgssd', # only remove this line if nfs must be enabled and Kerberos is in use
      'saslauthd', # disables SASL, used by LDAP and Kerberos
      'sendmail',
      'smartd',   # for virtual VMs, physical servers are covered via HP tools
      'sysstat',
      'vsftpd', # not necessary at every system
    ]:
      ensure    => false,
      enable    => false,
      hasstatus => true;
  }


  # own handling of alsa-firmware, because dependency between those package have to be removed "yum -y erase" and it reduces the risk of unwanted deinstallations
  package {
    [
      'alsa-firmware',
      'alsa-tools-firmware',
    ]:
    ensure => purged,
  }

  package {
    [
      'abrtd',
      'autofs',
      'avahi',
      'avahi-daemon',
      'cpuspeed',  #frequency scaling not supported under xen kernels / vmware unknown / for physical servers it could be relevant
      'ftp',
      'inetd',
      'kdump',
      'rlogin',
      'rsh-server',
      'telnet',
      'telnet-server',
      'tftp-server',
      'ypserv',
      'ypbind',
      'xinetd',

      # remove default installed firmware
      'aic94xx-firmware',
      'atmel-firmware',
      'adaptec-firmware',
      'bfa-firmware',
      'brocade-firmware',
      'icom-firmware',
      'ipw-firmware',
      'ipw2100-firmware',
      'ipw2200-firmware',
      'ivtv-firmware',
      'iwl100-firmware',
      'iwl105-firmware',
      'iwl135-firmware',
      'iwl1000-firmware',
      'iwl2000-firmware',
      'iwl2030-firmware',
      'iwl3160-firmware',
      'iwl3945-firmware',
      'iwl4965-firmware',
      'iwl5000-firmware',
      'iwl5150-firmware',
      'iwl6000-firmware',
      'iwl6000g2a-firmware',
      'iwl6000g2b-firmware',
      'iwl6050-firmware',
      'iwl7260-firmware',
      'libertas-sd8686-firmware',
      'libertas-sd8787-firmware',
      'libertas-usb8388-firmware',
      'mpt-firmware',
      'ql2100-firmware',
      'ql2200-firmware',
      'ql23xx-firmware',
      'ql2400-firmware',
      'ql2500-firmware',
      'rt61pci-firmware',
      'rt73usb-firmware',
      'xorg-x11-drv-ati-firmware',
      'zd1211-firmware',
    ]:
      ensure => 'absent',
  }

  # packages we need for every service
  package {
    [
      'curl',
      'strace',
      'tcpdump',
      'wget',
    ]:
      ensure => 'present',
  }

  # arpwatch to watch for arp spoofing
  package { 'arpwatch':
    ensure => installed,
  }

  service { 'arpwatch':
    ensure => running,
    enable => true,
  }
}
