# config for password algorithm
# copied from puppet os hardening module - see hardening.io for details
class secc_os_linux::login_defs {
  
  # SoC - Requirement 50 - Falls Passwörter als Authentisierungsmerkmal genutzt werden, muss eine Änderung des eigenen Passwortes jederzeit durch den Benutzer möglich sein.
  
  file_line { 'login_defs_PASS_MIN_DAYS' :
    ensure => present,
    path   => '/etc/login.defs',
    line   => 'PASS_MIN_DAYS       0',
    match  => '^PASS_MIN_DAYS.*',
  }

  file_line { 'login_defs_ENCRYPT_METHOD' :
    ensure => present,
    path   => '/etc/login.defs',
    line   => 'ENCRYPT_METHOD SHA512',
    match  => 'ENCRYPT_METHOD.*',
  }

  file_line { 'login_defs_useradd_umask_initialization' :
    ensure => present,
    path   => '/etc/login.defs',
    line   => 'UMASK 077',
    match  => '^UMASK.*',
  }
  
}
