# syslog configuration
# /var/log/secure and /var/log/bash_history
# extensions based of default os syslog configs

class secc_os_linux::syslog (
  $rsyslog_setting_var_log_messages,
  $rsyslog_manage_service
){

  if ( $::operatingsystem == 'RedHat' and $::operatingsystemmajrelease >= '6') or ( $::operatingsystem == 'CentOS' and $::operatingsystemmajrelease >= '6') {
    file { '/etc/rsyslog.d':
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    }

    # TODO: refactor for depencency to package rsyslog
    file { '/etc/rsyslog.d/secc-audit.conf':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      source  => 'puppet:///modules/secc_os_linux/etc/rsyslog.d/secc-audit.conf',
      require => File['/etc/rsyslog.d'],
    }

    if $rsyslog_manage_service {

      ensure_packages( ['rsyslog'] )

      service { 'rsyslog':
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        enable     => true,
        subscribe  => File['/etc/rsyslog.d/secc-audit.conf'],
      }

      file_line { 'secc_rsyslog_setting_var_log_messages' :
        ensure  => present,
        path    => '/etc/rsyslog.conf',
        line    => "${rsyslog_setting_var_log_messages}   /var/log/messages",
        match   => '.*/var/log/messages',
        require => Service['rsyslog'],
      }
    }
  }
}
