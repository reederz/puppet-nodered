class nodered::install {
  
  class { 'nodejs': }

  if ! defined(Package['git']) {
    package { 'git':
      ensure  =>  present,
    }
  }

  if ! defined(File['/usr/bin/node']) {
    file {  '/usr/bin/node':
      ensure  => link,
      target  =>  '/usr/bin/nodejs',
      require => Class['nodejs'],
    }
  }


  if ! defined(Package['grunt-cli']) {
    package { 'grunt-cli':
      ensure   =>  present,
      provider =>  'npm',
      require => Class['nodejs'],
    }
  }

  if ! defined(Package['forever']) {
    package { 'forever':
      ensure   =>  present,
      provider =>  'npm',
      require => Class['nodejs'],
    }
  }

  package { 'node-red': 
      ensure   =>  present,
      provider =>  'npm',
      require => Class['nodejs'],
  }
}
