class arpwatch {

  # arpwatch to watch for arp spoofing
  package { 'arpwatch':
    ensure => installed,
  }

  service { 'arpwatch':
    ensure => running,
    enable => true,
    require => Package['arpwatch'],
  }

	if ( $::operatingsystem == 'RedHat' ) or ( $::operatingsystem == 'CentOS' ) {
	  file { '/etc/sysconfig/arpwatch':
	    ensure => present,
	    owner  => 'root',
	    group  => 'root',
	    mode   => '0644',
	    source => 'puppet:///modules/secc_os_linux/etc/sysconfig/arpwatch',
	  }

  }
}
