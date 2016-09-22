class secc_os_linux::logrotate (
  $logrotate_enabled,
  $logrotate_time,
  $logrotate_rotate,
  $logrotate_missingok,
  $logrotate_dateext,
  $logrotate_compress,
  $logrotate_package,
) {
  
  if ($logrotate_enabled) {
    
    file {'/etc/logrotate.d/bash_history':
      ensure  => 'present',
      content => template('secc_os_linux/etc/logrotate.d/bash_history.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }
  }
}