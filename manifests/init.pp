# SecC Linux OS Hardening
class secc_os_linux (
  $ext_tftp_server_package_status = absent,
  $ext_xinetd_package_status      = absent,
  $ext_secure_mountpoint_tmp      = true,
  $ext_secure_mountpoint_var      = true,
  $ext_secure_mountpoint_var_tmp  = true,
  $ext_secure_mountpoint_home     = true,
  $ext_remove_users               = [ 'ftp', 'games', 'gopher', 'uucp' ],
  $ext_remove_groups              = [ 'ftp', 'games', 'gopher', 'uucp', 'video', 'tape' ],
  $ext_test_kitchen_run           = false,
  $ext_rootsh_enabled             = true,
  $ext_stop_and_disable_services      = [ 'acpid', 'anacron', 'cups', 'dhcpd', 'network-remotefs', 'haldaemon', 'lm_sensors', 'mdmonitor', 'netconsole', 'netfs', 'nfs', 'ntpdate', 'oddjobd', 'portmap', 'portreserve', 'qpidd', 'quota_nld', 'rdisc', 'rhnsd', 'rhsmcertd', 'saslauthd', 'sendmail', 'smartd', 'sysstat', 'vsftpd' ],
  $ext_stop_services                  = [ 'nfslock', 'rpcgssd', 'rpcidmapd', 'rpcsvcgssd' ],
){

  $tftp_server_package_status = hiera(tftp_server_package_status, $ext_tftp_server_package_status)
  $xinetd_package_status      = hiera(xinetd_package_status, $ext_xinetd_package_status)
  $secure_mountpoint_tmp      = hiera(secure_mountpoint_tmp, $ext_secure_mountpoint_tmp)
  $secure_mountpoint_var      = hiera(secure_mountpoint_var, $ext_secure_mountpoint_var)
  $secure_mountpoint_var_tmp  = hiera(secure_mountpoint_var_tmp, $ext_secure_mountpoint_var_tmp)
  $secure_mountpoint_home     = hiera(secure_mountpoint_var, $ext_secure_mountpoint_home)
  $remove_users               = hiera(remove_users, $ext_remove_users)
  $remove_groups              = hiera(remove_groups, $ext_remove_groups)
  $rootsh_enabled             = hiera(rootsh_enabled, $ext_rootsh_enabled)
  $stop_and_disable_services  = hiera(stop_and_disable_services, $ext_stop_and_disable_services)
  $stop_services              = hiera(stop_services, $ext_stop_services)

  include secc_os_linux::audit

  # disabled while rolling out to pilots
  # include secc_os_linux::arpwatch

  include secc_os_linux::inputrc

  include secc_os_linux::kernel

  include secc_os_linux::login_defs

  include secc_os_linux::modules

  class { 'secc_os_linux::mounts':
    secure_mountpoint_tmp     => $secure_mountpoint_tmp,
    secure_mountpoint_var     => $secure_mountpoint_var,
    secure_mountpoint_var_tmp => $secure_mountpoint_var_tmp,
    secure_mountpoint_home    => $secure_mountpoint_home,
    test_kitchen_run          => $ext_test_kitchen_run,
  }

  include secc_os_linux::password

  class { 'secc_os_linux::packages':
    tftp_server_package_status => $tftp_server_package_status,
    xinetd_package_status      => $xinetd_package_status,
  }
  #include secc_os_linux::packages

  include secc_os_linux::profile

  if ( $rootsh_enabled ) {
    include secc_os_linux::rootsh
  }

  class { 'secc_os_linux::services':
    stop_and_disable_services => $stop_and_disable_services,
    stop_services             => $stop_services,
  }

  include secc_os_linux::syslog

  class { 'secc_os_linux::users_group':
    remove_users  => $remove_users,
    remove_groups => $remove_groups,
  }

}
