# RHEL - auditting for OS inputs and outputs
# rootsh

class secc_os_linux::rootsh (
  $rootsh_enabled,
  $bash_ps1,
) {

  if ( $::operatingsystem == 'RedHat' and $::operatingsystemmajrelease >= '6') or ( $::operatingsystem == 'CentOS' and $::operatingsystemmajrelease >= '6') {
    # requires epel repo
      if ( $rootsh_enabled ) {
        package { 'rootsh':
          ensure => 'present',
        }
      }
      else {
        package { 'rootsh':
          ensure => 'absent',
        }
      }

    #file_line { '/etc/bashrc_ps1_prompt' :
    #  ensure => present,
    #  path   => '/etc/bashrc',
    #  line   => $bash_ps1,
    #  match  => $bash_ps1,
    #  after  => '# vim:ts=4:sw=4',
    #}

  }
}
