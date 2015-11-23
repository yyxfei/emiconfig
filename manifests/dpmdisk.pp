class emiconfig::dpmdisk {
  
  #
  # The standard variables are collected here:
  $headnode_fqdn = "ccsrm.ihep.ac.cn"
  $token_password = "asdfasdfasfasfdasfdasdf"
  $mysql_root_pass = "asdfasdfasfasfdasfdasdf"
  $db_user = "dpmmgr"
  $db_pass = "asdfasdfasfasfdasfdasdf"
  $localdomain = "ihep.ac.cn"
  $volist = ["atlas", "biomed", "dteam", "ops"]
  $disk_nodes = "dpmds01.ihep.ac.cn dpmds02.ihep.ac.cn dpmds03.ihep.ac.cn"
  $xrootd_sharedkey = "DXjgDTkK55fnyFr8gW1RcYv0pV7vkcWmZyHr9f4aoc8="
  $debug = false


  Class[Lcgdm::Base::Install] -> Class[Lcgdm::Rfio::Install]
  Class[Dmlite::Plugins::Adapter::Install] ~> Class[Dmlite::Dav::Service]
  Class[Dmlite::Plugins::Adapter::Install] ~> Class[Dmlite::Gridftp]

  #
  # lcgdm mountpoints configuration
  #Class[Lcgdm::Base::Config] ->
  #file {
  #   "/storage":
  #   ensure => directory,
  #   owner => "dpmmgr",
  #   group => "dpmmgr",   
  #   mode =>  0775;
  #   "/storage/disk011":
  #   ensure => directory,
  #   owner => "dpmmgr",
  #   group => "dpmmgr",
  #   seltype => "httpd_sys_content_t",
  #   mode => 0775;
  #   "/storage/disk012":
  #   ensure => directory,
  #   owner => "dpmmgr",
  #   group => "dpmmgr",
  #   seltype => "httpd_sys_content_t",
  #   mode => 0775;
  #   "/storage/disk013":
  #   ensure => directory,
  #   owner => "dpmmgr",
  #   group => "dpmmgr",
  #   seltype => "httpd_sys_content_t",
  #   mode => 0775;
  #   "/storage/disk014":
  #   ensure => directory,
  #   owner => "dpmmgr",
  #   group => "dpmmgr",
  #   seltype => "httpd_sys_content_t",
  #   mode => 0775;
  #   "/storage/disk01d1p1":
  #   ensure => directory,
  #   owner => "dpmmgr",
  #   group => "dpmmgr",
  #   seltype => "httpd_sys_content_t",
  #   mode => 0775;
  #}
  
  #
  # lcgdm configuration.
  #
  #class{"lcgdm::base":
  #    uid => 500,
  #    gid => 500,
  #}
  class{"lcgdm::base::config":
      uid => 500,
      gid => 500,
  }
  class{"lcgdm::base::install":}
  
  class{"lcgdm::ns::client":
    flavor  => "dpns",
    dpmhost => "${headnode_fqdn}"
  }
  
  #
  # RFIO configuration.
  #
  class{"lcgdm::rfio":
    dpmhost => "${headnode_fqdn}",
  }
  
  
  #
  # Entries in the shift.conf file, you can add in 'host' below the list of
  # machines that the DPM should trust (if any).
  #
  lcgdm::shift::trust_value{
    "DPM TRUST":
      component => "DPM",
      host      => "${headnode_fqdn} ${disk_nodes}";
    "DPNS TRUST":
      component => "DPNS",
      host      => "${headnode_fqdn} ${disk_nodes}";
    "RFIO TRUST":
      component => "RFIOD",
      host      => "${headnode_fqdn} ${disk_nodes}",
      all       => true
  }
  lcgdm::shift::protocol{"PROTOCOLS":
    component => "DPM",
    #proto     => "rfio gsiftp http https xroot",
    proto     => "rfio gsiftp http https xroot",
  }
  
  #
  # VOMS configuration (same VOs as above).
  #
  class{"voms::atlas":}
  class{"voms::dteam":}
  class{"voms::ops":}
  # class{"voms::biomed":}

  voms::client{'biomed':
        servers  => [{server => 'cclcgvomsli01.in2p3.fr',
                   port   => '15000',
                   dn    => '/O=GRID-FR/C=FR/O=CNRS/OU=CC-IN2P3/CN=cclcgvomsli01.in2p3.fr',
                   ca_dn => '/C=FR/O=CNRS/CN=GRID2-FR',
                  }]
   }

  
  #
  # Gridmapfile configuration.
  #
  $groupmap = {
    "vomss://voms.hellasgrid.gr:8443/voms/dteam?/dteam/Role=lcgadmin"   => "dteam",
    "vomss://voms.hellasgrid.gr:8443/voms/dteam?/dteam/Role=production" => "dteam",
    "vomss://voms.hellasgrid.gr:8443/voms/dteam?/dteam"                 => "dteam",
    "vomss://voms.cern.ch:8443/voms/atlas?/atlas/Role=lcgadmin"         => "atlas",
    "vomss://voms.cern.ch:8443/voms/atlas?/atlas/Role=production"       => "atlas",
    "vomss://voms.cern.ch:8443/voms/atlas?/atlas"                       => "atlas",
    "vomss://voms.cern.ch:8443/voms/ops?/ops"                           => "ops",
    "vomss://cclcgvomsli01.in2p3.fr:8443/voms/biomed?/biomed"           => "biomed",
  }
  lcgdm::mkgridmap::file {"lcgdm-mkgridmap":
    configfile   => "/etc/lcgdm-mkgridmap.conf",
    mapfile      => "/etc/lcgdm-mapfile",
    localmapfile => "/etc/lcgdm-mapfile-local",
    logfile      => "/var/log/lcgdm-mkgridmap.log",
    groupmap     => $groupmap,
    localmap     => {"nobody" => "nogroup"}
  }
  
  #
  # dmlite plugin configuration.
  class{"dmlite::disk":
    token_password => "${token_password}",
    dpmhost        => "${headnode_fqdn}",
    nshost         => "${headnode_fqdn}",
    enable_mysql_io => false,
    mysql_username => "${db_user}",
    mysql_password => "${db_pass}",
  }
  
  #
  # dmlite frontend configuration.
  #
  class{"dmlite::dav":}
  class{"dmlite::gridftp":
    dpmhost => "${headnode_fqdn}"
  }
  
  # The XrootD configuration is a bit more complicated and
  # the full config (incl. federations) will be explained here:
  # https://svnweb.cern.ch/trac/lcgdm/wiki/Dpm/Xroot/PuppetSetup
  
  #
  # The simplest xrootd configuration.
  #
  class{"xrootd::config":
    xrootd_user  => 'dpmmgr',
    xrootd_group => 'dpmmgr'
  }
  #$sharedkey = "32TO64CHARACTERSTRING"
  class{"dmlite::xrootd":
    nodetype              => [ 'disk' ],
    domain                => "${localdomain}",
    dpm_xrootd_debug      => $debug,
    dpm_xrootd_sharedkey  => "${xrootd_sharedkey}"
  }
  
  #
  # dmlite shell configuration.
  #
  #class{"dmlite::shell":}
  file {"/usr/local/bin/check_gsiftp.sh":
    mode         =>  '755',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/check_gsiftp.sh",
  }
  cron {"check_gsiftp":
    command   => "/usr/local/bin/check_gsiftp.sh",
    user      => 'root',
    minute    => '*/1',
    hour      => '*'

  }

  class { 'limits':
    purge_limits_d_dir => false,
  }
   limits::limits { 'user_nofile':
    ensure     => present,
    user       => '*',
    limit_type => 'nofile',
    soft       => '65000',
    hard       => '65000',
  }
   limits::limits { 'user_nproc':
    ensure     => present,
    user       => '*',
    limit_type => 'nproc',
    soft       => '65000',
    hard       => '65000',
  }
}
