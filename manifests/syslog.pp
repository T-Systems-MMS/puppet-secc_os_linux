# syslog configuration
# /var/log/secure and /var/log/bash_history
# extensions based of default os syslog configs

class secc_os_linux::syslog {

  if ( $::operatingsystem == 'RedHat' ) or ( $::operatingsystem == 'CentOS' ) {
      if ( $::operatingsystemmajrelease  == '6.0' ) {
        file { '/etc/rsyslog.conf':
          ensure => present,
          owner  => 'root',
          group  => 'root',
          mode   => '0644',
          source => 'puppet:///modules/secc_os_linux/etc/rhel6_rsyslog.conf',
        }
      }

      if ( $::operatingsystemmajrelease  == '7.0' ) {
        file { '/etc/rsyslog.conf':
          ensure => present,
          owner  => 'root',
          group  => 'root',
          mode   => '0644',
          source => 'puppet:///modules/secc_os_linux/etc/rhel7_rsyslog.conf',
        }
      }

      package { 'rsyslog':
        ensure => installed,
      }

      service { 'rsyslog':
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        enable     => true,
        subscribe  => File['/etc/rsyslog.conf'],
      }
  }

}



