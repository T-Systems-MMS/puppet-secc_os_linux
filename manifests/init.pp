# SecC Linux OS Hardening
class secc_os_linux {

  include secc_os_linux::arpwatch

  include secc_os_linux::audit

  include secc_os_linux::inputrc

  include secc_os_linux::kernel

  include secc_os_linux::login_defs

  include secc_os_linux::password

  include secc_os_linux::profile

  include secc_os_linux::rootsh

  include secc_os_linux::services

  include secc_os_linux::syslog

}
