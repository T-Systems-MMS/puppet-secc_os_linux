# config for service availability and status
# copied from puppet os hardening module - see hardening.io for details

class secc_os_linux::services {

  # SoC - Requirement 3.01-1 - Nicht benötigte Dienste und Protokolle müssen deaktiviert werden.
  #    stop: https://git.fedorahosted.org/cgit/aqueduct.git/tree/compliance/puppet/stig/rhel-6/modules/services/manifests/init.pp
  # SoC - Requirement 3.37-7 - Das automatische Starten von Anwendungen auf Wechseldatenträgern muss abgeschaltet werden.
  #     autofs

  service {
    [
      #'acpid',
      #'anacron',
      #'cups',
      #'dhcpd',
      #'network-remotefs', # needs to come before haldaemon for SLES11
      #'haldaemon',
      #'lm_sensors',
      #'mdmonitor',
      #'netconsole',
      #'netfs',
      #'nfs',     # only remove this line if nfs must be enabled
      #'ntpdate',
      #'oddjobd',
      #'portmap',
      #'portreserve',
      #'qpidd',
      #'quota_nld',
      #'rdisc',
      #'rhnsd',    # RHEL specific
      #'rhsmcertd', # RHEL specific
      #'saslauthd', # disables SASL, used by LDAP and Kerberos
      #'sendmail',
      #'smartd',   # for virtual VMs, physical servers are covered via HP tools
      #'sysstat',
      #'vsftpd', # not necessary at every system
      $stop_and_disable_services,
    ]:
      ensure    => false,
      enable    => false,
      hasstatus => true;
  }

  service {
    [
      #'nfslock', # only remove this line if nfs must be enabled
      #'rpcgssd', # only remove this line if nfs must be enabled and Kerberos is in use
      #'rpcidmapd', # only remove this line if nfs must be enabled and NFSv4 is in use
      #'rpcsvcgssd', # only remove this line if nfs must be enabled and Kerberos is in use
      $stop_services,
    ]:
      ensure    => false,
      hasstatus => true;
  }
}
