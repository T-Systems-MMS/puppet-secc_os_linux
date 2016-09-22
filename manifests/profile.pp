# config for umask setting
# copied from puppet os hardening module - see hardening.io for details
class secc_os_linux::profile {

  file { '/etc/profile.d/umask.sh':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/secc_os_linux/etc/profile.d/umask.sh',
  }

  # non interactive sessions could effect application behaviours and are not affected by default
  # this is for non-interactive logins

  if ( $::operatingsystem == 'RedHat' ) or ( $::operatingsystem == 'CentOS' )  {
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
