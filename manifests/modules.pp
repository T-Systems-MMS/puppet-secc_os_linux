# disable potential critical kernel modules
class secc_os_linux::modules(
  $disable_kernel_modules,
) {

  file { '/etc/modprobe.d/secc-blacklist.conf':
    ensure  => present,
    content => template('secc_os_linux/etc/modprobe.d/secc-blacklist.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

}
