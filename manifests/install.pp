class nodered::install (
  $install_dir  = undef,
){
  
  if ! defined(Package['nodejs']) {
    package { 'nodejs':
      ensure  =>  present,
    }
  }

  if ! defined(Package['git']) {
    package { 'git':
      ensure  =>  present,
    }
  }

  if ! defined(File['/usr/bin/node']) {
    file {  '/usr/bin/node':
      ensure  => link,
      target  =>  '/usr/bin/nodejs',
      require => Package['nodejs'],
    }
  }

  if ! defined(Package['npm']) {
    package { 'npm':
      ensure  =>  present,
    }
  }

  if ! defined(Package['grunt-cli']) {
    package { 'grunt-cli':
      ensure   =>  present,
      provider =>  'npm',
      require  =>  Package['npm'],
    }
  }

  if ! defined(Package['forever']) {
    package { 'forever':
      ensure   =>  present,
      provider =>  'npm',
      require  =>  Package['npm'],
    }
  }

  exec {'download_nodered':
    command =>  "/usr/bin/git clone --branch=0.10.2 https://github.com/node-red/node-red.git $install_dir",
    onlyif  => "/usr/bin/test ! -d ${install_dir}",
    require =>  Package['git'],
  }

  exec  { 'nodered_dependencies_install':
    command =>  '/usr/bin/npm install --production',
    cwd     =>  $install_dir,
    onlyif  => "/usr/bin/test ! -d ${install_dir}/node_modules",
    require =>  [Package['npm'], Exec['download_nodered'],],
  }
}
