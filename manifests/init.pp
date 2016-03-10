# SecC Linux OS Hardening
class secc_os_linux (
  $ext_tftp_server_package_status = absent,
  $ext_xinetd_package_status      = absent,
  $ext_secure_mountpoint_tmp      = true,
  $ext_secure_mountpoint_var      = true,
  $ext_secure_mountpoint_var_tmp  = true,
  $ext_secure_mountpoint_home     = true,
){

  $tftp_server_package_status = hiera(tftp_server_package_status, $ext_tftp_server_package_status)
  $xinetd_package_status      = hiera(xinetd_package_status, $ext_xinetd_package_status)
  $secure_mountpoint_tmp      = hiera(secure_mountpoint_tmp, $ext_secure_mountpoint_tmp)
  $secure_mountpoint_var      = hiera(secure_mountpoint_var, $ext_secure_mountpoint_var)
  $secure_mountpoint_var_tmp  = hiera(secure_mountpoint_var_tmp, $ext_secure_mountpoint_var_tmp)
  $secure_mountpoint_home      = hiera(secure_mountpoint_var, $ext_secure_mountpoint_home)


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
    secure_mountpoint_home    => $secure_mountpoint_home
  }

  include secc_os_linux::password

  class { 'secc_os_linux::packages':
    tftp_server_package_status => $tftp_server_package_status,
    xinetd_package_status      => $xinetd_package_status,
  }
  #include secc_os_linux::packages

  include secc_os_linux::profile

  include secc_os_linux::rootsh

  include secc_os_linux::services

  include secc_os_linux::syslog

}
