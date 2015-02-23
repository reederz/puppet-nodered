class nodered (
  $user     = undef,
  $password = undef,
  $install_dir = '/usr/local/src/nodered'
) {

  class { 'nodered::install':
    install_dir => $install_dir,
  }

  class { 'nodered::configure':
    user     => $user,
    password => $password,
    require  => Class['nodered::install'],
  }

  exec {  'run_nodered_forever':
    command  =>  "(/usr/local/bin/forever stop nodered || echo 'Node-RED was not running') && /usr/local/bin/forever start --uid 'nodered' --append ${install_dir}/red.js --settings /etc/nodered/settings.js -v",
    provider => 'shell',
    require  =>  Class['nodered::configure'],
  }

  cron {  'start_nodered_on_reboot':
    command =>  "(/usr/local/bin/forever stop nodered || echo 'Node-RED was not running') && /usr/local/bin/forever start --uid 'nodered' --append ${install_dir}/red.js --settings /etc/nodered/settings.js -v",
    special =>  'reboot',
    require =>  Class['nodered::configure'],
  }
}
