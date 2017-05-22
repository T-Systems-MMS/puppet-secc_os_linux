# hardening mountpoints
class secc_os_linux::mounts (){

  if $::secc_os_linux::secure_mountpoint_tmp {
    mount { '/tmp':
      ensure  => 'mounted',
      options => $::secc_os_linux::mount_options_tmp,
    }
  }

  if $::secc_os_linux::secure_mountpoint_var_tmp {
    mount { '/var/tmp':
      ensure  => 'mounted',
      options => $::secc_os_linux::mount_options_var_tmp,
    }
  }

  if $::secc_os_linux::secure_mountpoint_var {
    mount { '/var':
      ensure  => 'mounted',
      options => $::secc_os_linux::mount_options_var,
    }
  }

  if $::secc_os_linux::secure_mountpoint_home {
    mount { '/home':
      ensure  => 'mounted',
      options => $::secc_os_linux::mount_options_home,
    }
  }

}
