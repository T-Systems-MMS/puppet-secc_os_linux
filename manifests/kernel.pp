# config for kernel settings
# copied from puppet os hardening module - see hardening.io for details
#

# SoC - Requirement 3.21-1 - Betriebssystemfunktionen, die nicht für den Betrieb eines Servers benötigt werden, müssen abgeschaltet werden.
# SoC - Requirement 3.21-3 - Falls vorhanden, muss die Funktion für „rp_filter“ (Reverse Path Filter) bzw. eine entsprechende Funktion des verwendeten Derivates gesetzt sein. Ebenso muss "strict destination multihoming“ aktiviert sein.
# SoC - Requirement 3.21-5 - Der Schutz vor Buffer Overflows muss aktiviert sein.
# SoC - Requirement 3.37-6 - Netzfunktionen im Betriebssystemkern, die für den Betrieb als Server nicht benötigt werden, müssen abgeschaltet werden.
# SoC - Requirement 3.37-10 - Das System darf keine IP-Pakete verarbeiten, deren Absenderadresse nicht über die Schnittstelle erreicht wird, an der das Paket eingegangen ist.
# SoC - Requirement 3.37-11 - Die Verarbeitung von ICMPv4 und ICMPv6 Paketen, die für den Betrieb nicht benötigt werden, muss deaktiviert werden.
# SoC - Requirement 3.37-12 - IP-Pakete mit nicht benötigten Optionen oder Erweiterungs-Headern dürfen nicht bearbeitet werden.
class secc_os_linux::kernel (
  $cpu_vendor              = 'intel',
  $enable_ipv4_forwarding  = false,
  $enable_ipv6             = false,
  $enable_ipv6_forwarding  = false,
  $arp_restricted          = true,
  $enable_stack_protection = true,
){

  # Networking
  # ----------

  # IPv6 enabled
  if $enable_ipv6 {

    file_line { 'kernel_enable_IPv6' :
      ensure => present,
      path   => '/etc/sysctl.conf',
      line   => 'net.ipv6.conf.all.disable_ipv6 = 0',
      match  => 'net.ipv6.conf.all.disable_ipv6.*',
      notify => Exec['sysctl_load'],
    }

    if $enable_ipv6_forwarding {

      file_line { 'kernel_enable_IPv6_routing' :
        ensure => present,
        path   => '/etc/sysctl.conf',
        line   => 'net.ipv6.conf.all.forwarding = 1',
        match  => 'net.ipv6.conf.all.forwarding.*',
        notify => Exec['sysctl_load'],
      }


    } else {

        file_line { 'kernel_disable_IPv6_routing' :
          ensure => present,
          path   => '/etc/sysctl.conf',
          line   => 'net.ipv6.conf.all.forwarding = 0',
          match  => 'net.ipv6.conf.all.forwarding.*',
          notify => Exec['sysctl_load'],
        }

    }
  } else {
    # IPv6 disabled - only the relevant taken

      file_line { 'kernel_disable_IPv6_completely' :
        ensure => present,
        path   => '/etc/sysctl.conf',
        line   => 'net.ipv6.conf.all.disable_ipv6 = 1',
        match  => 'net.ipv6.conf.all.disable_ipv6.*',
        notify => Exec['sysctl_load'],
      }

      file_line { 'kernel_disable_IPv6_routing' :
        ensure => present,
        path   => '/etc/sysctl.conf',
        line   => 'net.ipv6.conf.all.forwarding = 0',
        match  => 'net.ipv6.conf.all.forwarding.*',
        notify => Exec['sysctl_load'],
      }

  }

  # Only enable IP traffic forwarding, if required.
  file_line { 'kernel_disable_IPv4_routing' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.ip_forward = 0',
    match  => 'net.ipv4.ip_forward.*',
    notify => Exec['sysctl_load'],
  }

  # Enable RFC-recommended source validation feature. It should not be used for routers on complex networks, but is helpful for end hosts and routers serving small networks.
  file_line { 'kernel_enable_IPv4_reverse_path_filtering' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.conf.all.rp_filter = 1',
    match  => 'net.ipv4.conf.all.rp_filter.*',
    notify => Exec['sysctl_load'],
  }

  file_line { 'kernel_enable_IPv4_reverse_path_filtering_default' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.conf.default.rp_filter = 1',
    match  => 'net.ipv4.conf.default.rp_filter.*',
    notify => Exec['sysctl_load'],
  }

  # Reduce the surface on SMURF attacks. Make sure to ignore ECHO broadcasts, which are only required in broad network analysis.
  file_line { 'kernel_IPv4_ignore_icmp_broadcasts' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.icmp_echo_ignore_broadcasts = 1',
    match  => 'net.ipv4.icmp_echo_ignore_broadcasts.*',
    notify => Exec['sysctl_load'],
  }

  file_line { 'kernel_IPv4_log_bad_network_messages' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.icmp_ignore_bogus_error_responses = 1',
    match  => 'net.ipv4.icmp_ignore_bogus_error_responses.*',
    notify => Exec['sysctl_load'],
  }

  file_line { 'kernel_IPv4_do_not_accept_source_routing' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.conf.all.accept_source_route = 0',
    match  => 'net.ipv4.conf.all.accept_source_route.*',
    notify => Exec['sysctl_load'],
  }

  # Accepting source route can lead to malicious networking behavior, so disable it if not needed.
  file_line { 'kernel_IPv4_do_not_accept_source_routing_default' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.conf.default.accept_source_route = 0',
    match  => 'net.ipv4.conf.default.accept_source_route.*',
    notify => Exec['sysctl_load'],
  }

  # Accepting source route can lead to malicious networking behavior, so disable it if not needed.
  file_line { 'kernel_IPv4_do_not_accept_redirects' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.conf.all.accept_redirects = 0',
    match  => 'net.ipv4.conf.all.accept_redirects.*',
    notify => Exec['sysctl_load'],
  }

  file_line { 'kernel_IPv4_do_not_accept_redirects_default' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.conf.default.accept_redirects = 0',
    match  => 'net.ipv4.conf.default.accept_redirects.*',
    notify => Exec['sysctl_load'],
  }

  file_line { 'kernel_IPv4_do_not_accept_secure_redirects' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.conf.all.secure_redirects = 0',
    match  => 'net.ipv4.conf.all.secure_redirects.*',
    notify => Exec['sysctl_load'],
  }

  file_line { 'kernel_IPv4_do_not_accept_secure_redirects_default' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.conf.default.secure_redirects = 0',
    match  => 'net.ipv4.conf.default.secure_redirects.*',
    notify => Exec['sysctl_load'],
  }

  # For non-routers: don't send redirects, these settings are 0
  file_line { 'kernel_IPv4_do_not_send_redirects' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.conf.all.send_redirects = 0',
    match  => 'net.ipv4.conf.all.send_redirects.*',
    notify => Exec['sysctl_load'],
  }
  file_line { 'kernel_IPv4_do_not_send_redirects_default' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.conf.default.send_redirects = 0',
    match  => 'net.ipv4.conf.default.send_redirects.*',
    notify => Exec['sysctl_load'],
  }


  file_line { 'kernel_IPv4_tcp_sync_protection' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.tcp_syncookies = 1',
    match  => 'net.ipv4.tcp_syncookies.*',
    notify => Exec['sysctl_load'],
  }

  file_line { 'kernel_IPv4_icmp_ratelimit' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.icmp_ratelimit = 100',
    match  => 'net.ipv4.icmp_ratelimit.*',
    notify => Exec['sysctl_load'],
  }

  file_line { 'kernel_IPv4_icmp_ratemask' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.icmp_ratemask = 88089',
    match  => 'net.ipv4.icmp_ratemask.*',
    notify => Exec['sysctl_load'],
  }

  file_line { 'kernel_IPv4_tcp_timestamps' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.tcp_timestamps = 0',
    match  => 'net.ipv4.tcp_timestamps.*',
    notify => Exec['sysctl_load'],
  }


  # ARP control
  if $arp_restricted {

    file_line { 'kernel_IPv4_arp_ignore' :
      ensure => present,
      path   => '/etc/sysctl.conf',
      line   => 'net.ipv4.conf.all.arp_ignore = 1',
      match  => 'net.ipv4.conf.all.arp_ignore.*',
      notify => Exec['sysctl_load'],
    }

    file_line { 'kernel_IPv4_arp_ignore_default' :
      ensure => present,
      path   => '/etc/sysctl.conf',
      line   => 'net.ipv4.conf.default.arp_ignore = 1',
      match  => 'net.ipv4.conf.default.arp_ignore.*',
      notify => Exec['sysctl_load'],
    }

    file_line { 'kernel_IPv4_arp_filter' :
      ensure => present,
      path   => '/etc/sysctl.conf',
      line   => 'net.ipv4.conf.all.arp_filter = 1',
      match  => 'net.ipv4.conf.all.arp_filter.*',
      notify => Exec['sysctl_load'],
    }

    file_line { 'kernel_IPv4_arp_announce_interface' :
      ensure => present,
      path   => '/etc/sysctl.conf',
      line   => 'net.ipv4.conf.all.arp_announce = 2',
      match  => 'net.ipv4.conf.all.arp_announce.*',
      notify => Exec['sysctl_load'],
    }

  } else {

      file_line { 'kernel_IPv4_arp_dont_ignore' :
        ensure => present,
        path   => '/etc/sysctl.conf',
        line   => 'net.ipv4.conf.all.arp_ignore = 0',
        match  => 'net.ipv4.conf.all.arp_ignore.*',
        notify => Exec['sysctl_load'],
      }

      file_line { 'kernel_IPv4_arp_announce_interface' :
        ensure => present,
        path   => '/etc/sysctl.conf',
        line   => 'net.ipv4.conf.all.arp_announce = 2',
        match  => 'net.ipv4.conf.all.arp_announce.*',
        notify => Exec['sysctl_load'],
      }

      file_line { 'kernel_IPv4_arp_filter' :
        ensure => present,
        path   => '/etc/sysctl.conf',
        line   => 'net.ipv4.conf.all.arp_filter = 1',
        match  => 'net.ipv4.conf.all.arp_filter.*',
        notify => Exec['sysctl_load'],
      }
  }


  # RFC 1337 fix F1
  # This note describes some theoretically-possible failure modes for TCP connections and discusses possible remedies.
  # In particular, one very simple fix is identified.
  file_line { 'kernel_IPv4_rfx1337_f1_fix' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.tcp_rfc1337 = 1',
    match  => 'net.ipv4.tcp_rfc1337.*',
    notify => Exec['sysctl_load'],
  }


  # log martian packets (risky, may cause DoS)
  file_line {'kernel_IPv4_log_faked_network_packets':
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.conf.all.log_martians = 1',
    match  => 'net.ipv4.conf.all.log_martians.*',
    notify => Exec['sysctl_load'],
  }

  file_line {'kernel_IPv4_log_faked_network_packets_default':
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'net.ipv4.conf.default.log_martians = 1',
    match  => 'net.ipv4.conf.default.log_martians.*',
    notify => Exec['sysctl_load'],
  }

  # Magic Sysrq should be disabled, but can also be set to a safe value if so desired for physical machines.
  # It can allow a safe reboot if the system hangs and is a 'cleaner' alternative to hitting the reset button.
  # The following values are permitted:
  #
  # * **0** - disable sysrq
  # * **1** - enable sysrq completely
  # * **>1** - bitmask of enabled sysrq functions:
  # * **2** - control of console logging level
  # * **4** - control of keyboard (SAK, unraw)
  # * **8** - debugging dumps of processes etc.
  # * **16** - sync command
  # * **32** - remount read-only
  # * **64** - signalling of processes (term, kill, oom-kill)
  # * **128** - reboot/poweroff
  # * **256** - nicing of all RT tasks

  file_line { 'kernel_magic_sysrq' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'kernel.sysrq = 0',
    match  => 'kernel.sysrq.*',
    notify => Exec['sysctl_load'],
  }


  # Prevent core dumps with SUID. These are usually only needed by developers and may contain sensitive information.
  file_line { 'kernel_core_dump_suid' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'fs.suid_dumpable = 0',
    match  => 'fs.suid_dumpable.*',
    notify => Exec['sysctl_load'],
  }


  # buffer overflow protection
  file_line { 'kernel_random_va_space' :
    ensure => present,
    path   => '/etc/sysctl.conf',
    line   => 'kernel.randomize_va_space = 2',
    match  => 'kernel.randomize_va_space.*',
    notify => Exec['sysctl_load'],
  }

  if ( $::kernelmajversion < '3.0' ) {
    file_line { 'kernel_exec_shield' :
      ensure => present,
      path   => '/etc/sysctl.conf',
      line   => 'kernel.exec-shield = 1',
      match  => 'kernel.exec-shield.*',
      notify => Exec['sysctl_load'],
    }

  }


  exec { 'sysctl_load':
    command     => '/sbin/sysctl -p /etc/sysctl.conf',
    refreshonly => true,
  }

}
