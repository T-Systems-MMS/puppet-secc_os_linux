# config for inputrc - configuration

class secc_os_linux::inputrc {

  file_line { 'history_search_backward_for_page_up' :
    ensure => present,
    path   => '/etc/inputrc',
    line   => '"\e[5~": history-search-backward',
    match  => '^"\\\e\[5~":',
  }

  file_line { 'history_search_forward_for_page_down' :
    ensure => present,
    path   => '/etc/inputrc',
    line   => '"\e[6~": history-search-forward',
    match  => '^"\\\e\[6~":',
  }

  file_line { 'history_search_backward_for_up' :
    ensure => present,
    path   => '/etc/inputrc',
    line   => '"\e[A": history-search-backward',
    match  => '^"\\\e\[A":',
    after  => '^"\\\e\[6~":',
  }

  file_line { 'history_search_forward_for_down' :
    ensure => present,
    path   => '/etc/inputrc',
    line   => '"\e[B": history-search-forward',
    match  => '^"\\\e\[B":',
    after  => '^"\\\e\[6~":',
  }

}
