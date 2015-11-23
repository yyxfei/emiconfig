class  emiconfig::autocvmfs {
  file { '/etc/auto.master':
    ensure   =>  file,
    owner    => 0,
    group    => 0,
    mode     => '0644',
    source   =>  "puppet:///modules/emiconfig/auto-cvmfs.master",
    before   => Service['autofs'],
    notify   => Service['autofs']
  }
  package { 'autofs':
    ensure   => present,
    require  => Yumrepo['site']
  }
  file { '/etc/auto.local':
    ensure   =>  file,
    owner    => 0,
    group    => 0,
    mode     => '0644',
    source   =>  "puppet:///modules/emiconfig/auto.local",
    before   => Service['autofs'],
    notify   => Service['autofs']
  }
  service {'autofs':
    ensure     =>  'running',
    enable     =>  true,
    name       =>  "autofs",
    hasstatus  =>  true,
    hasrestart =>  true,
    before     => Package['autofs'],
  }
  if $operatingsystemmajrelease == '6' {
     package { 'rpcbind':
      ensure   => present,
      require  => Yumrepo['site']
    }
     package { 'nfs-utils':
      ensure   => present,
      require  => Yumrepo['site']
    }

     service { 'rpcbind':
      ensure     => 'running',
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Package['rpcbind'],
      }
  }
}
