class emiconfig::autofs {
  #include autofs

  #autofs::mount { 'ihepbatch':
  #  mount       => '/ihepbatch',
  #  mapfile     => '/etc/auto.local',
  #  options     => '--timeout=120'
  #}

  #autofs::mapfile { 'auto.local':
  #  path     => '/etc/auto.local',
  #  mappings => [
  #    { 'key' => 'gridfs1', 'options' => '-fstype=nfs,soft,lookupcache=positive,rsize=32768,wsize=32768,soft,intr,retrans=20,timeo=15,vers=4,nosuid', 'fs' => '192.168.50.41:/gridfs1' },
  #  ]
  #}
  package { 'nfs-utils':
    ensure   => present,
    require  => Yumrepo['site']
  } ->
  service { 'rpcbind':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }->
  package { 'autofs':
    ensure   => present,
    require  => Yumrepo['site']
  }->
  
    file { '/etc/auto.local':
      ensure   =>  file,
      owner    => 0,
      group    => 0,
      mode     => '0644',
      source   =>  "puppet:///modules/emiconfig/auto.local",
    } ->
    file {'/etc/auto.sandbox':
      ensure   => file,
      owner    => 0,
      group    => 0,
      mode     => '0644',
      source   => "puppet:///modules/emiconfig/auto.sandbox",
    } ->
    case $operatingsystemmajrelease {
      '6': {
        file { '/etc/auto.master':
          ensure   =>  file,
          owner    => 0,
          group    => 0,
          mode     => '0644',
          source   =>  "puppet:///modules/emiconfig/auto-cvmfs.master",
          notify   => Service['autofs']
        }  
      }
      '7': {
        file { '/etc/auto.master.d/sandbox.autofs':
          ensure   =>  file,
          owner    => 0,
          group    => 0,
          mode     => '0644',
          source   =>  "puppet:///modules/emiconfig/sandbox.autofs",
        }->
        file { '/etc/auto.master.d/local.autofs':
          ensure   =>  file,
          owner    => 0,
          group    => 0,
          mode     => '0644',
          source   =>  "puppet:///modules/emiconfig/local.autofs",
        } 
      }
    } ~>
  service {'autofs':
    ensure     =>  'running',
    enable     =>  true,
    name       =>  "autofs",
    hasstatus  =>  true,
    hasrestart =>  true,
  }
}
