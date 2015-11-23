class emiconfig::dcache (
  $postgremajor = 9, 
  $postgreminor = 3,
) {

  yumrepo { "postgresql":
     baseurl => "http://202.122.33.67/yum/postgre/${postgremajor}.${postgreminor}/rhel-${operatingsystemmajrelease}-x86_64",
     descr => "postgresql",
     enabled => 1,
     gpgcheck => 0,
     priority => 60,
     before   => Yumrepo['site']
  }

  $dcach_pkg=[
  "dcache",
  "nfs-utils",
  ]
  package{ $dcach_pkg:
    ensure => 'installed',
    require => Yumrepo ['site'],     
  }

  package { "dcap":
    ensure   => 'installed',
    require => Yumrepo ['site'],
  }
  $postgrespkg=[
  "postgresql${postgremajor}${postgreminor}-jdbc",
  "postgresql${postgremajor}${postgreminor}",
  "postgresql${postgremajor}${postgreminor}-server",
  "postgresql${postgremajor}${postgreminor}-libs",
  ]


  package {$postgrespkg:
    ensure   => 'installed',
    require => Yumrepo['site'],
  }
 
  package {"ca-policy-egi-core":
    ensure   => 'installed',
    require => Yumrepo['site'],
  }

  package {"fetch-crl":
    ensure   => 'installed',
    require => Yumrepo['site'],
  }
 
 package {"xfsprogs.x86_64":
    ensure   => 'installed',
    require => Yumrepo['site'],
  }
  
  package {"jdk":
    ensure   => 'installed',
    require => Yumrepo['site'],
  }
  # add file fot JAVA_HOME and package fetch-crl
  service { 'fetch-crl-cron':
    ensure   => true,
    require   => Package['fetch-crl']
  }
  file {'/etc/default/dcache':
    ensure  => 'present',
    owner   => 'root',
    mode    => '0644',
    content => 'JAVA_HOME=/usr/java/default'
  }

  #limits.conf
      limits::limits { 'dcache_nofile':
      ensure     => present,
      user       => 'dcache',
      limit_type => 'nofile',
      soft       => unlimited,
      }
      limits::limits { 'dcache_nproc':
      ensure     => present,
      user       => 'dcache',
      limit_type => 'nproc',
      soft       => 15656,
      }
      limits::limits { 'root_nofile':
      ensure     => present,
      user       => 'root',
      limit_type => 'nofile',
      soft       => unlimited,
      }

}
