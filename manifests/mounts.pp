# hardening mountpoints
class secc_os_linux::mounts {

  # noexec on /tmp prevents test-kitchen :/
  mount { '/tmp':
    ensure  => 'mounted',
    options => 'defaults,nodev,nosuid',
    target  => '/etc/fstab',
  }

  mount { '/var':
    ensure  => 'mounted',
    options => 'defaults,noexec,nodev,nosuid',
    target  => '/etc/fstab',
  }

  mount { '/home':
    ensure  => 'mounted',
    options => 'defaults,nodev',
    target  => '/etc/fstab',
  }

  mount {'/var/tmp':
    ensure  => 'mounted',
    device  => '/tmp',
    fstype  => 'none',
    options => 'bind',
  }

}
