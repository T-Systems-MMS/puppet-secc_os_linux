# config for service availability and status
# copied from puppet os hardening module - see hardening.io for details

class secc_os_linux::packages (
  $tftp_server_package_status,
  $xinetd_package_status,
  $remove_packages,
){

  # SoC - Requirement 3.01-3 - Nicht benötigte Software darf nicht installiert oder muss deinstalliert werden.
  #    deinstall: telnet, abrt


  # own handling of alsa-firmware, because dependency between those package have to be removed "yum -y erase" and it reduces the risk of unwanted deinstallations
  # not working ...

  if ( $::operatingsystem == 'RedHat' ) or ( $::operatingsystem == 'CentOS' ) {
      if ( $::operatingsystemmajrelease == '6' ) {
        exec { 'remove_alsa-firmware':
          command => '/usr/bin/yum -y erase alsa-firmware alsa-tools-firmware',
          onlyif  => '/usr/bin/yum list installed | /bin/grep alsa-firmware',
        }
      } elsif ( $::operatingsystemmajrelease == '7' ) {
        exec { 'remove_alsa-firmware':
          command => '/usr/bin/yum -y erase alsa-firmware alsa-tools-firmware',
          onlyif  => '/usr/bin/yum list installed | /usr/bin/grep alsa-firmware',
        }
      }
  }
  
  ensure_packages( ['tftp-server'], {'ensure' => $tftp_server_package_status} )
  ensure_packages( ['xinetd'], {'ensure' => $xinetd_package_status} )

  ensure_packages(
    [
      # 'abrtd',
      # 'autofs',
      # 'avahi-daemon',
      # 'cpuspeed',  #frequency scaling not supported under xen kernels / vmware unknown / for physical servers it could be relevant
      # 'ftp',
      # 'inetd',
      # 'kdump',
      # 'rlogin',
      # 'rsh-server',
      # 'telnet-server',
      # 'ypserv',
      # 'ypbind',
      # remove default installed firmware
      # 'aic94xx-firmware',
      # 'atmel-firmware',
      # 'adaptec-firmware',
      # 'bfa-firmware',
      # 'brocade-firmware',
      # 'icom-firmware',
      # 'ipw-firmware',
      # 'ipw2100-firmware',
      # 'ipw2200-firmware',
      # 'ivtv-firmware',
      # 'iwl100-firmware',
      # 'iwl105-firmware',
      # 'iwl135-firmware',
      # 'iwl1000-firmware',
      # 'iwl2000-firmware',
      # 'iwl2030-firmware',
      # 'iwl3160-firmware',
      # 'iwl3945-firmware',
      # 'iwl4965-firmware',
      # 'iwl5000-firmware',
      # 'iwl5150-firmware',
      # 'iwl6000-firmware',
      # 'iwl6000g2a-firmware',
      # 'iwl6000g2b-firmware',
      # 'iwl6050-firmware',
      # 'iwl7260-firmware',
      # 'iwl7265-firmware',
      # 'libertas-sd8686-firmware',
      # 'libertas-sd8787-firmware',
      # 'libertas-usb8388-firmware',
      # 'mpt-firmware',
      # 'ql2100-firmware',
      # 'ql2200-firmware',
      # 'ql23xx-firmware',
      # 'ql2400-firmware',
      # 'ql2500-firmware',
      # 'rt61pci-firmware',
      # 'rt73usb-firmware',
      # 'xorg-x11-drv-ati-firmware',
      # 'zd1211-firmware',
      $remove_packages,
    ],
      {'ensure' => 'absent'}
  )

  # packages we need for every service
  ensure_packages( ['curl', 'wget'], {'ensure' => 'present'} )

}
