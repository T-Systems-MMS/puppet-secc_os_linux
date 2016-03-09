# disable potential critical kernel modules
class secc_os_linux::modules {

  file { '/etc/modprobe.d/secc-blacklist.conf':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/secc_os_linux/etc/modprobe.d/secc-blacklist.conf',
  }

}
