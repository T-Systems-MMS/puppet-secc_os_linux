# syslog configuration
# /var/log/secure and /var/log/bash_history
# extensions based of default os syslog configs

class secc_os_linux::syslog {

  if ( $::operatingsystem == 'SLES' )  {
      if ( $::operatingsystemrelease  >= '11.0' ) and ( $::operatingsystemrelease  < '12.0' ) {
        file { '/etc/syslog-ng/syslog-ng.conf':
          ensure  => present,
          owner   => 'root',
          group   => 'root',
          mode    => '644',
          source  => 'puppet:///modules/secc_os_linux/etc/syslog-ng/sles11_syslog-ng.conf',
        }

        package { 'syslog-ng':
          ensure => installed,
        }

        service { 'syslog':
          ensure     => running,
          hasstatus  => true,
          hasrestart => true,
          enable     => true,
          subscribe  => File['/etc/syslog-ng/syslog-ng.conf'],
        }
      }


      if ( $::operatingsystemrelease  >= '12.0' ) and ( $::operatingsystemrelease  < '13.0' ) {
        file { '/etc/rsyslog.conf':
          ensure  => present,
          owner   => 'root',
          group   => 'root',
          mode    => '600',
          source  => 'puppet:///modules/secc_os_linux/etc/sles12_rsyslog.conf',
        }

        service { 'rsyslog':
          ensure     => running,
          hasstatus  => true,
          hasrestart => true,
          enable     => true,
          subscribe  => File['/etc/rsyslog.conf'],
        }

        package { 'rsyslog':
          ensure => installed,
        }
      }
  }

  if ( $::operatingsystem == 'RedHat' ) or ( $::operatingsystem == 'CentOS' ) {
      if ( $::operatingsystemmajrelease  == '6.0' ) {
        file { '/etc/rsyslog.conf':
          ensure  => present,
          owner   => 'root',
          group   => 'root',
          mode    => '644',
          source  => 'puppet:///modules/secc_os_linux/etc/rhel6_rsyslog.conf',
        }
      }

      if ( $::operatingsystemmajrelease  == '7.0' ) {
        file { '/etc/rsyslog.conf':
          ensure  => present,
          owner   => 'root',
          group   => 'root',
          mode    => '644',
          source  => 'puppet:///modules/secc_os_linux/etc/rhel7_rsyslog.conf',
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



