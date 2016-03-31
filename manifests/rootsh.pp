# RHEL - auditting for OS inputs and outputs
# rootsh

class secc_os_linux::rootsh (
  $rootsh_enabled,
  $bash_ps1,
) {

  if ( $::operatingsystem == 'RedHat' ) or ( $::operatingsystem == 'CentOS' ) {

    # requires epel repo
    if ( $rootsh_enabled ) {
      package { 'rootsh':
        ensure => 'present',
      }
    }

    file_line { '/etc/bashrc_ps1_prompt' :
      ensure => present,
      path   => '/etc/bashrc',
      line   => $bash_ps1,
      match  => $bash_ps1,
      after  => '# vim:ts=4:sw=4',
    }


  }
}
