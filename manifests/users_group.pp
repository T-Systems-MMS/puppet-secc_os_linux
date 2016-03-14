# groups and users to be managed
class secc_os_linux::users_group (
  $remove_users,
  $remove_groups
){

  user {
    [
      #'ftp',
      #'games',
      #'gopher',
      #'uucp',
      $remove_users,
    ]:
    ensure => 'absent',
    before => Group[$remove_groups],
  }

  group {
    [
      #'ftp',
      #'games',
      #'gopher',
      #'uucp',
      #'video',
      #'tape',
      $remove_groups,
    ]:
    ensure => 'absent',
  }


}
