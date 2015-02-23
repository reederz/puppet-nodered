class nodered::configure (
  $user     = undef,
  $password = undef,
){

  $password_hash = md5($password)
  file {  '/etc/nodered':
    ensure  => directory,
  }

  if $user != undef and $password != undef {
    $with_pass = true
  } else {
    $with_pass = false
  }
  file {  '/etc/nodered/settings.js':
    ensure  => present,
    content => template('nodered/settings.js.erb'),
    require => File['/etc/nodered'],
  }
}
