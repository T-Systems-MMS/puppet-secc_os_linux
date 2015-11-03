# RHEL - auditting for OS inputs and outputs
# rootsh

class secc_os_linux::rootsh {

  if ( $::operatingsystem == 'RedHat' ) or ( $::operatingsystem == 'CentOS' ) {

    # requires epel repo
    package { 'rootsh':
      ensure => 'present',
    }


  }
}
