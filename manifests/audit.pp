# config for audit - configuration
# poor man bash auditting

class secc_os_linux::audit {

  file { '/etc/sysconfig/bash-prompt-xterm':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/secc_os_linux/etc/sysconfig/bash-prompt-xterm',
  }

  # SLES
  if ( $::operatingsystem == 'SLES' )  {
    file { '/etc/bash.bashrc.local':
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/secc_os_linux/etc/sles_bash.bashrc.local',
    }
  }

  # RHEL or CentOS
  if ( $::operatingsystem == 'RedHat' ) or ( $::operatingsystem == 'CentOS' ) {
      if ( $::operatingsystemmajrelease  == '6.0' ) {
        file { '/etc/bashrc':
          ensure => present,
          owner  => 'root',
          group  => 'root',
          mode   => '0644',
          source => 'puppet:///modules/secc_os_linux/etc/rhel6_bashrc',
        }
      }

      if ( $::operatingsystemmajrelease  == '7.0' ) {
        file { '/etc/bashrc':
          ensure => present,
          owner  => 'root',
          group  => 'root',
          mode   => '0644',
          source => 'puppet:///modules/secc_os_linux/etc/rhel7_bashrc',
        }
      }
  }

}
