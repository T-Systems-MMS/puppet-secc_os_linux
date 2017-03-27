class secc_os_linux::packages (
  $tftp_server_package_status,
  $xinetd_package_status,
  $remove_packages,
){

  # SoC - Requirement 3.01-3 - Nicht benoetigte Software darf nicht installiert oder muss deinstalliert werden.

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

  # uninstall unwanted packages, configured as default parameter to $ext_remove_packages in init.pp
  # handling of special behaviour of centos7, which basically deletes linux-firmware, as dependency of xorg-x11-drv-ati-firmware
  # tickets ASC-188 & DEVOPS-1687
  if ( $::is_virtual ) {
      ensure_packages( $remove_packages, {'ensure' => 'absent'} )
  } else {
      ensure_packages( delete($remove_packages, 'xorg-x11-drv-ati-firmware'), {'ensure' => 'absent'} )
  }

  # uninstalled by default parameter 'absent' in init.pp
  ensure_packages( 'tftp-server', {'ensure' => $tftp_server_package_status} )
  ensure_packages( 'xinetd', {'ensure' => $xinetd_package_status} )

  # packages we need for every service
  ensure_packages( ['curl', 'wget'], {'ensure' => 'present'} )

}
