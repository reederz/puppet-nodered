class nodered (
  $user     = undef,
  $password = undef,
) {

  class { 'nodered::install': }

  class { 'nodered::configure':
    user     => $user,
    password => $password,
    require  => Class['nodered::install'],
  }


  exec {  'run_nodered_forever':
    command  =>  "($(${::nodejs::params::npm_path} get prefix)/bin/forever stop nodered || echo 'Node-RED was not running') && $(${::nodejs::params::npm_path} get prefix)/bin/forever start --uid 'nodered' --append $(${::nodejs::params::npm_path} get prefix)/bin/node-red --settings /etc/nodered/settings.js -v",
    provider => 'shell',
    require  =>  Class['nodered::configure'],
  }

  cron {  'start_nodered_on_reboot':
    command =>  "($(${::nodejs::params::npm_path} get prefix)/bin/forever stop nodered || echo 'Node-RED was not running') && $(${::nodejs::params::npm_path} get prefix)/bin/forever start --uid 'nodered' --append $(${::nodejs::params::npm_path} get prefix)/bin/node-red --settings /etc/nodered/settings.js -v",
    special =>  'reboot',
    require =>  Class['nodered::configure'],
  }
}
