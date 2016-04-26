# syslog configuration
# /var/log/secure and /var/log/bash_history
# extensions based of default os syslog configs

class secc_os_linux::syslog (
  $rsyslog_setting_var_log_messages,
){

  if ( $::operatingsystem == 'RedHat' ) or ( $::operatingsystem == 'CentOS' ) {
      file { '/etc/rsyslog.d/secc-audit.conf':
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/secc_os_linux/etc/rsyslog.d/secc-audit.conf',
      }

      ensure_packages( ['rsyslog'] )

      service { 'rsyslog':
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        enable     => true,
        #subscribe  => [ File['/etc/rsyslog.d/secc-audit.conf'], File['/etc/rsyslog.conf'] ],
        subscribe  => File['/etc/rsyslog.d/secc-audit.conf'],
      }

      file_line { 'secc_rsyslog_setting_var_log_messages' :
        ensure  => present,
        path    => '/etc/rsyslog.conf',
        line    => "${rsyslog_setting_var_log_messages}   /var/log/messages",
        #'*.info;mail.none;authpriv.none;cron.none;local5.none;local6.none                /var/log/messages',
        match   => '.*/var/log/messages',
        require => Service['rsyslog'],
        #notify  => Service['rsyslog'],
      }
  }

}



