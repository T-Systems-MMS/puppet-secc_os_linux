# config for inputrc - configuration

class secc_os_linux::inputrc {

  file_line { 'history_search_backward' :
    ensure => present,
    path   => '/etc/inputrc',
    line   => '"\e[5~": history-search-backward',
    match  => '"\\e\[5~":.*',
  }

  file_line { 'history_search_forward' :
    ensure => present,
    path   => '/etc/inputrc',
    line   => '"\e[6~": history-search-forward',
    match  => '"\\e\[6~":.*',
  }

}
