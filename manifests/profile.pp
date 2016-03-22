# config for umask setting
# copied from puppet os hardening module - see hardening.io for details
class secc_os_linux::profile {

  # this is for interactive logins
  file_line { 'etc_profile_umask' :
    ensure => present,
    path   => '/etc/profile',
    line   => 'umask 027',
    match  => 'umask 02.*',
  }

  # non interactive sessions could effect application behaviours and are not affected by default
  # this is for non-interactive logins

  if ( $::operatingsystem == 'RedHat' ) or ( $::operatingsystem == 'CentOS' )  {
          file_line { 'etc_rhel_bashrc_umask' :
            ensure => present,
            path   => '/etc/bashrc',
            line   => 'umask 027',
            match  => 'umask 02.*',
          }

          file_line { 'etc_profile_rootsh' :
            ensure => present,
            path   => '/etc/profile',
            line   => 'if [ -x /usr/bin/rootsh ] && [[ $- = *i* ]]; then  exec /usr/bin/rootsh --no-logfile ; fi',
            match  => '^if.*([ -x \/usr\/bin\/rootsh ] && \[\[ \$- \= \*i\* \]\]; then  exec \/usr\/bin\/rootsh --no-logfile ;).*fi$',
            #line   => ' if   [ -x /usr/bin/rootsh ]; then   exec /usr/bin/rootsh --no-logfile ; fi',
            #match  => '^if.*([ -x \/usr\/bin\/rootsh ]; then   exec \/usr\/bin\/rootsh --no-logfile ;).*fi$',
          }

  }

}
