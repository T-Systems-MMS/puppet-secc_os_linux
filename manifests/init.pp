# SecC Linux OS Hardening
class secc_os_linux (
  $tftp_server_package_status       = absent,
  $xinetd_package_status            = absent,
  $remove_users                     = [ 'ftp', 'games', 'gopher', 'uucp' ],
  $remove_groups                    = [ 'ftp', 'games', 'gopher', 'uucp', 'video', 'tape' ],
  $remove_packages                  = [ 'abrtd', 'autofs', 'avahi-daemon', 'cpuspeed', 'ftp', 'inetd', 'kdump', 'rlogin', 'rsh-server', 'telnet-server', 'ypserv', 'ypbind', 'aic94xx-firmware', 'atmel-firmware', 'adaptec-firmware', 'bfa-firmware', 'brocade-firmware', 'icom-firmware', 'ipw-firmware', 'ipw2100-firmware', 'ipw2200-firmware', 'ivtv-firmware', 'iwl100-firmware', 'iwl105-firmware', 'iwl135-firmware', 'iwl1000-firmware', 'iwl2000-firmware', 'iwl2030-firmware', 'iwl3160-firmware', 'iwl3945-firmware', 'iwl4965-firmware', 'iwl5000-firmware', 'iwl5150-firmware', 'iwl6000-firmware', 'iwl6000g2a-firmware', 'iwl6000g2b-firmware', 'iwl6050-firmware', 'iwl7260-firmware', 'iwl7265-firmware', 'libertas-sd8686-firmware', 'libertas-sd8787-firmware', 'libertas-usb8388-firmware', 'mpt-firmware', 'ql2100-firmware', 'ql2200-firmware', 'ql23xx-firmware', 'ql2400-firmware', 'ql2500-firmware', 'rt61pci-firmware', 'rt73usb-firmware', 'xorg-x11-drv-ati-firmware', 'zd1211-firmware'],
  $test_kitchen_run                 = false,
  $rootsh_enabled                   = true,
  $bash_ps1                         = 'PS1="\[$(tput bold)\]\[$(tput setaf 3)\]\\u\[$(tput setaf 4)\]@\[$(tput setaf 2)\]\\h\[$(tput setaf 4)\]:\[$(tput setaf 7)\]\\w\[$(tput setaf 4)\]\\$ \[$(tput sgr0)\]"',
  $stop_and_disable_services        = [ 'abrtd', 'acpid', 'anacron', 'cups', 'dhcpd', 'network-remotefs', 'haldaemon', 'lm_sensors', 'mdmonitor', 'netconsole', 'netfs', 'nfs', 'ntpdate', 'oddjobd', 'portmap', 'portreserve', 'qpidd', 'quota_nld', 'rdisc', 'rhnsd', 'rhsmcertd', 'saslauthd', 'sendmail', 'smartd', 'sysstat', 'vsftpd', 'wpa_supplicant' ],
  $stop_services                    = [ 'nfslock', 'rpcgssd', 'rpcidmapd', 'rpcsvcgssd' ],
  $rsyslog_setting_var_log_messages = '*.info;mail.none;authpriv.none;cron.none;local5.none;local6.none',
  $logrotate_enabled                = true,
  $logrotate_time                   = 'weekly',
  $logrotate_rotate                 = '13',
  $logrotate_missingok              = false,
  $logrotate_dateext                = false,
  $logrotate_compress               = false,
  $enable_ipv4_forwarding           = false,
  $enable_ipv6                      = false,
  $enable_ipv6_forwarding           = false,
  $arp_restricted                   = true,
  $enable_stack_protection          = true,
  $rsyslog_manage_service           = true,
  $disable_kernel_modules           = [ 'usb-storage', 'firewire-core', 'firewire-ohci', 'cramfs', 'freevxfs', 'jffs2', 'hfs', 'hfsplus', 'squashfs', 'udf', 'isdn' ],
  $mount_options_tmp                = 'defaults,noexec,nodev,nosuid',
  $mount_options_var                = 'defaults,nodev,nosuid',
  $mount_options_var_tmp            = 'bind',
  $mount_options_home               = 'defaults,nodev',
  $secure_mountpoint_tmp            = true,
  $secure_mountpoint_var            = true,
  $secure_mountpoint_var_tmp        = true,
  $secure_mountpoint_home           = true,
  $profile_umask                    = '027',
  $manage_passwords                 = true,
){

  include secc_os_linux::audit

  # disabled while rolling out to pilots
  # include secc_os_linux::arpwatch

  include secc_os_linux::inputrc

  class {'secc_os_linux::kernel':
    enable_ipv4_forwarding  => $enable_ipv4_forwarding,
    enable_ipv6             => $enable_ipv6,
    enable_ipv6_forwarding  => $enable_ipv6_forwarding,
    arp_restricted          => $arp_restricted,
    enable_stack_protection => $enable_stack_protection,
  }

  include secc_os_linux::login_defs

  class { 'secc_os_linux::modules':
    disable_kernel_modules    => $disable_kernel_modules,
  }

  contain secc_os_linux::mounts

  contain secc_os_linux::password

  class { 'secc_os_linux::packages':
    tftp_server_package_status => $tftp_server_package_status,
    xinetd_package_status      => $xinetd_package_status,
    remove_packages            => $remove_packages,
  }

  class { 'secc_os_linux::profile':
    profile_umask => $profile_umask,
  }

  class { 'secc_os_linux::rootsh':
    rootsh_enabled => $rootsh_enabled,
    bash_ps1       => $bash_ps1,
  }

  class { 'secc_os_linux::services':
    stop_and_disable_services => $stop_and_disable_services,
    stop_services             => $stop_services,
  }

  class { 'secc_os_linux::syslog':
    rsyslog_setting_var_log_messages => $rsyslog_setting_var_log_messages,
    rsyslog_manage_service           => $rsyslog_manage_service,
  }

  class { 'secc_os_linux::users_group':
    remove_users  => $remove_users,
    remove_groups => $remove_groups,
  }

  class { 'secc_os_linux::logrotate':
    logrotate_enabled   => $logrotate_enabled,
    logrotate_time      => $logrotate_time,
    logrotate_rotate    => $logrotate_rotate,
    logrotate_missingok => $logrotate_missingok,
    logrotate_dateext   => $logrotate_dateext,
    logrotate_compress  => $logrotate_compress,
  }

}
