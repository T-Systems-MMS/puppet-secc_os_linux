# syslog configuration
# /var/log/secure and /var/log/bash_history
# extensions based of default os syslog configs

class secc_os_linux::syslog {

  if ( $::operatingsystem == 'RedHat' ) or ( $::operatingsystem == 'CentOS' ) {
      file { '/etc/rsyslog.d/secc-audit.conf':
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/secc_os_linux/etc/rsyslog.d/secc-audit.conf',
      }

      package { 'rsyslog':
        ensure => installed,
      }

      service { 'rsyslog':
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        enable     => true,
        subscribe  => File['/etc/rsyslog.d/secc-audit.conf'],
      }
  }

}



