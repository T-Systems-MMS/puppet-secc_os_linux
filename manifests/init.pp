# SecC Linux OS Hardening
class secc_os_linux (
  $ext_tftp_server_package_status = absent,
  $ext_xinetd_package_status      = absent,
){

  $tftp_server_package_status = hiera(tftp_server_package_status, $ext_tftp_server_package_status)
  $xinetd_package_status      = hiera(xinetd_package_status, $ext_xinetd_package_status)

  include secc_os_linux::audit

  # disabled while rolling out to pilots
  # include secc_os_linux::arpwatch

  include secc_os_linux::inputrc

  include secc_os_linux::kernel

  include secc_os_linux::login_defs

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
