# config for audit - configuration
# poor man bash auditting

class secc_os_linux::audit {

  file { '/etc/sysconfig/bash-prompt-xterm':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/secc_os_linux/etc/sysconfig/bash-prompt-xterm',
  }


  # RHEL or CentOS
  #if ( $::operatingsystem == 'RedHat' ) or ( $::operatingsystem == 'CentOS' ) {
  #    if ( $::operatingsystemmajrelease  == '6.0' ) {
  #      file { '/etc/bashrc':
  #        ensure => present,
  #        owner  => 'root',
  #        group  => 'root',
  #        mode   => '0644',
  #        source => 'puppet:///modules/secc_os_linux/etc/rhel6_bashrc',
  #      }
  #    }
  #
  #    if ( $::operatingsystemmajrelease  == '7.0' ) {
  #      file { '/etc/bashrc':
  #        ensure => present,
  #        owner  => 'root',
  #        group  => 'root',
  #        mode   => '0644',
  #        source => 'puppet:///modules/secc_os_linux/etc/rhel7_bashrc',
  #      }
  #    }
  #}

  file_line { '/etc/bashrc_secc_header' :
    ensure => present,
    path   => '/etc/bashrc',
    line   => '# AMCS SecC - settings',
    match  => '# AMCS SecC - settings.*',
    after  => '# vim:ts=4:sw=4',
  } ->

  file_line { '/etc/bashrc_secc_histcontrol' :
    ensure => present,
    path   => '/etc/bashrc',
    line   => 'export HISTCONTROL= 2>/dev/null',
    match  => 'export HISTCONTROL=.*',
  } ->

  file_line { '/etc/bashrc_secc_histcontrol_typeset' :
    ensure => present,
    path   => '/etc/bashrc',
    line   => 'typeset -r HISTCONTROL',
    match  => 'typeset -r HISTCONTROL',
  } ->

  file_line { '/etc/bashrc_secc_histfile' :
    ensure => present,
    path   => '/etc/bashrc',
    line   => 'export HISTFILE=$HOME/.bash_history 2>/dev/null',
    match  => 'export HISTFILE=.*',
  } ->

  file_line { '/etc/bashrc_secc_histfile_typeset':
    ensure => present,
    path   => '/etc/bashrc',
    line   => 'typeset -r HISTFILE',
    match  => 'typeset -r HISTFILE$',
  } ->

  file_line { '/etc/bashrc_secc_histfilesize':
    ensure => present,
    path   => '/etc/bashrc',
    line   => 'export HISTFILESIZE=5000 2>/dev/null',
    match  => 'export HISTFILESIZE=.*',
  } ->

  file_line { '/etc/bashrc_secc_histfilesize_typeset':
    ensure => present,
    path   => '/etc/bashrc',
    line   => 'typeset -r HISTFILESIZE',
    match  => 'typeset -r HISTFILESIZE',
  } ->

  file_line { '/etc/bashrc_secc_histignore':
    ensure => present,
    path   => '/etc/bashrc',
    line   => 'export HISTIGNORE= 2>/dev/null',
    match  => 'export HISTIGNORE=.*',
  } ->

  file_line { '/etc/bashrc_secc_histignore_typeset':
    ensure => present,
    path   => '/etc/bashrc',
    line   => 'typeset -r HISTIGNORE',
    match  => 'typeset -r HISTIGNORE',
  } ->

  file_line { '/etc/bashrc_secc_histsize':
    ensure => present,
    path   => '/etc/bashrc',
    line   => 'export HISTSIZE=2500 2>/dev/null',
    match  => 'export HISTSIZE=.*',
  } ->

  file_line { '/etc/bashrc_secc_histsize_typeset':
    ensure => present,
    path   => '/etc/bashrc',
    line   => 'typeset -r HISTSIZE',
    match  => 'typeset -r HISTSIZE',
  } ->

  file_line { '/etc/bashrc_secc_histtimeformat':
    ensure => present,
    path   => '/etc/bashrc',
    line   => 'export HISTTIMEFORMAT="%F - %H:%M:%S " 2>/dev/null',
    match  => 'export HISTTIMEFORMAT=.*',
  } ->

  file_line { '/etc/bashrc_secc_histtimeformat_typeset':
    ensure => present,
    path   => '/etc/bashrc',
    line   => 'typeset -r HISTTIMEFORMAT',
    match  => 'typeset -r HISTTIMEFORMAT',
  } ->

  file_line { '/etc/bashrc_secc_shopt_cmdhist':
    ensure => present,
    path   => '/etc/bashrc',
    line   => 'shopt -s cmdhist',
    match  => 'shopt -s cmdhist',
  } ->

  file_line { '/etc/bashrc_secc_shopt_histappend':
    ensure => present,
    path   => '/etc/bashrc',
    line   => 'shopt -s histappend',
    match  => 'shopt -s histappend',
  }

}
