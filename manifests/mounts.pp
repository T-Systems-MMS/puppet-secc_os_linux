# hardening mountpoints
class secc_os_linux::mounts (){

  if $secure_mountpoint_tmp {
    mount { '/tmp':
      ensure  => 'mounted',
      options => $mount_options_tmp,
    }
  }

  if $secure_mountpoint_var_tmp {
    mount { '/var/tmp':
      ensure  => 'mounted',
      options => $mount_options_var_tmp,
    }
  }

  if $secure_mountpoint_var {
    mount { '/var':
      ensure  => 'mounted',
      options => $mount_options_var,
    }
  }

  if $secure_mountpoint_home {
    mount { '/home':
      ensure  => 'mounted',
      options => $mount_options_home,
    }
  }

}
