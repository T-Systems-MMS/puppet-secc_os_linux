# config for password complexity
# copied from puppet os hardening module - see hardening.io for details
class secc_os_linux::password {

  # SoC - Requirement 3.01-23 - Falls Passwörter als Authentisierungsmerkmal genutzt werden, müssen diese mindestens 8 Zeichen lang sein und drei der folgenden Zeichentypen beinhalten:
  #       Kleinbuchstaben, Großbuchstaben, Ziffern und Sonderzeichen.
  # SoC - Requirement 3.01-25 - Falls Passwörter als Authentisierungsmerkmal genutzt werden, muss ein Schutz gegen Wörterbuch- und Brute-Force-Angriffe vorhanden sein,
  #       der das Erraten von Passwörtern stark erschwert.

    if ( $::operatingsystem == 'RedHat' ) or ( $::operatingsystem == 'CentOS' ) {
      if ( $::operatingsystemmajrelease == '6' ) {

        file_line { 'rhel_centos_6_password-auth_passwd-classes' :
          ensure => present,
          path   => '/etc/pam.d/password-auth',
          line   => 'password    requisite     pam_cracklib.so try_first_pass retry=3 minlen=10 dcredit=-1 ucredit=-1 lcredit=-1 ocredit=-1 type=',
          match  => '^password.*requisite.*',
        }
        file_line { 'rhel_centos_6_system-auth_passwd-classes' :
          ensure => present,
          path   => '/etc/pam.d/system-auth',
          line   => 'password    requisite     pam_cracklib.so try_first_pass retry=3 minlen=10 dcredit=-1 ucredit=-1 lcredit=-1 ocredit=-1 type=',
          match  => '^password.*requisite.*',
        }
        file_line { 'rhel_centos_6_password-auth_fail-lock' :
          ensure => present,
          path   => '/etc/pam.d/password-auth',
          line   => 'auth        required      pam_tally2.so onerr=fail deny=3 unlock_time=300',
          after  => 'auth        required      pam_env.so',
        }
        file_line { 'rhel_centos_6_system-auth_fail-lock' :
          ensure => present,
          path   => '/etc/pam.d/system-auth',
          line   => 'auth        required      pam_tally2.so onerr=fail deny=3 unlock_time=300',
          after  => 'auth        required      pam_env.so',
        }

      } elsif ( $::operatingsystemmajrelease == '7' ) {
        file_line { 'rhel_centos_7_password-minlen' :
          ensure => present,
          path   => '/etc/security/pwquality.conf',
          line   => 'minlen = 10',
          match  => 'minlen.*',
        }
        file_line { 'rhel_centos_7_password-dcredit' :
          ensure => present,
          path   => '/etc/security/pwquality.conf',
          line   => 'dcredit = -1',
          match  => 'dcredit.*',
        }
        file_line { 'rhel_centos_7_password-ucredit' :
          ensure => present,
          path   => '/etc/security/pwquality.conf',
          line   => 'ucredit = -1',
          match  => 'ucredit.*',
        }
        file_line { 'rhel_centos_7_password-lcredit' :
          ensure => present,
          path   => '/etc/security/pwquality.conf',
          line   => 'lcredit = -1',
          match  => 'lcredit.*',
        }
        file_line { 'rhel_centos_7_password-ocredit' :
          ensure => present,
          path   => '/etc/security/pwquality.conf',
          line   => 'ocredit = -1',
          match  => 'ocredit.*',
        }

        file_line { 'rhel_centos_7_password-auth_pwquality' :
          ensure => present,
          path   => '/etc/pam.d/password-auth',
          line   => 'password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=',
          match  => '^password.*requisite.*',
        }
        file_line { 'rhel_centos_7_system-auth_pwquality' :
          ensure => present,
          path   => '/etc/pam.d/system-auth',
          line   => 'password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=',
          match  => '^password.*requisite.*',
        }
        file_line { 'rhel_centos_7_password-auth_fail-lock' :
          ensure => present,
          path   => '/etc/pam.d/password-auth',
          line   => 'auth        required      pam_tally2.so onerr=fail deny=3 unlock_time=300',
          after  => 'auth        required      pam_env.so',
        }
        file_line { 'rhel_centos_7_system-auth_fail-lock' :
          ensure => present,
          path   => '/etc/pam.d/system-auth',
          line   => 'auth        required      pam_tally2.so onerr=fail deny=3 unlock_time=300',
          after  => 'auth        required      pam_env.so',
        }
      }
    }

}
