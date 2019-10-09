class emiconfig::dpmheadold {

  #
  # This is an example configuration for a DPM Head Node.
  #
  # You can check the puppet modules 'lcgdm' and 'dmlite' for any additional options available.
  # !! Please replace the placeholders for usernames and passwords !!
  #

  #
  # The standard variables are collected here:
  #
  $token_password = "lcg123"
  $mysql_root_pass = "lcg123"
  $db_user = "dpmmgr"
  $db_pass = "lcg123"
  $localdomain = "ihep.ac.cn"
  $volist = ["atlas", "lhcb", "biomed", "dteam", "ops"]
  $disk_nodes = "dpmds01.ihep.ac.cn  dpmds02.ihep.ac.cn dpmds03.ihep.ac.cn dpmlhcb01.ihep.ac.cn"
  $xrootd_sharedkey = "DXjgDTkK55fnyFr8gW1RcYv0pV7vkcWmZyHr9f4aoc8="
  $debug = false
  
  #
  # Set inter-module dependencies
  #
  Class[mysql::server] -> Class[lcgdm::ns::service]
  #Class[Lcgdm::Dpm::Service] -> Lcgdm::Dpm::Pool <| |>
  Class[lcgdm::dpm::service] -> Class[dmlite::plugins::adapter::install]
  Class[dmlite::plugins::adapter::install] ~> Class[dmlite::srm::install]
  Class[dmlite::plugins::adapter::install] ~> Class[dmlite::gridftp]
  Class[dmlite::plugins::adapter::install] ~> Class[dmlite::dav]
  Dmlite::Plugins::Adapter::Create_config <| |> -> Class[dmlite::dav::install]
  Class[dmlite::plugins::mysql::install] ~> Class[dmlite::srm::install]
  Class[dmlite::plugins::mysql::install] ~> Class[dmlite::gridftp]
  Class[dmlite::plugins::mysql::install] ~> Class[dmlite::dav]
  #Class[bdii] ~> Class[lcgdm::bdii::dpm]
  # GIP installation and configuration

  
  #
  # The firewall configuration
  #
  
  #
  # MySQL server setup - disable if it is not local
  #
  class{ '::mysql::server':
    root_password    => "${mysql_root_pass}",
    override_options => { 
        'mysqld' => { 
              'bind-address' => '202.122.33.64',
              'max_connections' => '2048',
              'max_binlog_size' => '100M',
              'max_allowed_packet' => '16M',
              'key_buffer_size' => '512M',
              'query_cache_limit' => '1M',
              'query_cache_size' => '256M',
              'thread_cache_size' => '64',
              'thread_stack' => '256K',
              'innodb_flush_method' => 'O_DIRECT',
              'innodb_buffer_pool_size' => '1000000000',
         } 
    }
  } 
  #
  # DPM and DPNS daemon configuration.
  #
  #class{"lcgdm":
  #  dbflavor => "mysql",
  #  dbuser   => "${db_user}",
  #  dbpass   => "${db_pass}",
  #  dbhost   => "localhost",
  #  domain   => "${localdomain}",
  #  volist   => $volist,
  #}


  Class[lcgdm::ns::service] -> Class[lcgdm::dpm::service]
  Class[lcgdm::ns::service] -> Class[lcgdm::ns::client]
  Class[lcgdm::dpm::service] -> Lcgdm::Ns::Domain <| |>
  Lcgdm::Ns::Domain <| |> -> Lcgdm::Ns::Vo <| |>

  validate_bool(true)

  #
  # Base configuration
  #
  if !defined(Class["Lcgdm::Base"]) {
    class{"lcgdm::base":
      uid => 500,
      gid => 500,
    }
  }

  #
  # Nameserver client and server configuration.
  #

  class{"lcgdm::ns::config":
    flavor   => "dpns",
    dbflavor => "mysql",
    dbuser   => "${db_user}",
    dbpass   => "${db_pass}",
    dbhost   => "localhost",
    dbmanage => true,
    coredump => "no",
    numthreads => 80
  }
  class{"lcgdm::ns::install":}
  class{"lcgdm::ns::service":}
  class{"lcgdm::ns::client":
    flavor => "dpns"
  }


  #
  # DPM daemon configuration.
  #
  class{"lcgdm::dpm::config":
    dbflavor => "mysql",
    dbuser   => "${db_user}",
    dbpass   => "${db_pass}",
    dbhost   => "localhost",
    dbmanage => true,
    coredump => "no",
    numfthreads => 60,
    numsthreads => 20
  }
  class{"lcgdm::dpm::install":}
  class{"lcgdm::dpm::service":}

  #
  # Create path for domain and VOs to be enabled.
  #
  validate_array($volist)

  lcgdm::ns::domain{"${localdomain}":}
  lcgdm::ns::vo{$volist:
    	domain => "${localdomain}",
  }
# package emi-verion for publist emi version
  package{'emi-version':
    ensure  => 'installed',
    before  => Yumrepo['site']
  }

  
  #
  # RFIO configuration.
  #
  class{"lcgdm::rfio":
    dpmhost => "ccsrm.ihep.ac.cn",
  }



  lcgdm::dpm::pool{"atlas":
   def_filesize => "100M"
  }

  lcgdm::dpm::pool{"lhcb":
    def_filesize => "100M"
  }

  lcgdm::dpm::pool{"opsdteam":
   def_filesize => "100M"
  }

  # config filesystem
  lcgdm::dpm::filesystem{"dpmds01.ihep.ac.cn-/storage/disk011":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds01.ihep.ac.cn",
    fs      => "/storage/disk011"
  }

  lcgdm::dpm::filesystem{"dpmds01.ihep.ac.cn-/storage/disk012":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds01.ihep.ac.cn",
    fs      => "/storage/disk012"
  }
  lcgdm::dpm::filesystem{"dpmds01.ihep.ac.cn-/storage/disk013":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds01.ihep.ac.cn",
    fs      => "/storage/disk013"
  }
  lcgdm::dpm::filesystem{"dpmds01.ihep.ac.cn-/storage/disk014":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds01.ihep.ac.cn",
    fs      => "/storage/disk014"
  }
  lcgdm::dpm::filesystem{"dpmds01.ihep.ac.cn-/storage/disk01d1p1":
    ensure  => present,
    pool    => "opsdteam",
    server  => "dpmds01.ihep.ac.cn",
    fs      => "/storage/disk01d1p1"
  }
  lcgdm::dpm::filesystem{"dpmds02.ihep.ac.cn-/storage/disk021":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds02.ihep.ac.cn",
    fs      => "/storage/disk021"
  }
  lcgdm::dpm::filesystem{"dpmds02.ihep.ac.cn-/storage/disk022":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds02.ihep.ac.cn",
    fs      => "/storage/disk022"
  }
  lcgdm::dpm::filesystem{"dpmds02.ihep.ac.cn-/storage/disk023":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds02.ihep.ac.cn",
    fs      => "/storage/disk023"
  }
  lcgdm::dpm::filesystem{"dpmds02.ihep.ac.cn-/storage/disk024":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds02.ihep.ac.cn",
    fs      => "/storage/disk024"
  }
  lcgdm::dpm::filesystem{"dpmds02.ihep.ac.cn-/storage/disk025":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds02.ihep.ac.cn",
    fs      => "/storage/disk025"
  }
  lcgdm::dpm::filesystem{"dpmds02.ihep.ac.cn-/storage/disk026":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds02.ihep.ac.cn",
    fs      => "/storage/disk026"
  }
  lcgdm::dpm::filesystem{"dpmds02.ihep.ac.cn-/storage/disk027":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds02.ihep.ac.cn",
    fs      => "/storage/disk027"
  }
  lcgdm::dpm::filesystem{"dpmds02.ihep.ac.cn-/storage/disk028":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds02.ihep.ac.cn",
    fs      => "/storage/disk028"
  }
  lcgdm::dpm::filesystem{"dpmds03.ihep.ac.cn-/storage/disk031":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds03.ihep.ac.cn",
    fs      => "/storage/disk031"
  }
  lcgdm::dpm::filesystem{"dpmds03.ihep.ac.cn-/storage/disk032":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds03.ihep.ac.cn",
    fs      => "/storage/disk032"
  }
  lcgdm::dpm::filesystem{"dpmds03.ihep.ac.cn-/storage/disk033":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds03.ihep.ac.cn",
    fs      => "/storage/disk033"
  }
  lcgdm::dpm::filesystem{"dpmds03.ihep.ac.cn-/storage/disk034":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds03.ihep.ac.cn",
    fs      => "/storage/disk034"
  }
  lcgdm::dpm::filesystem{"dpmds03.ihep.ac.cn-/storage/disk035":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds03.ihep.ac.cn",
    fs      => "/storage/disk035"
  }
  lcgdm::dpm::filesystem{"dpmds03.ihep.ac.cn-/storage/disk036":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds03.ihep.ac.cn",
    fs      => "/storage/disk036"
  }
  lcgdm::dpm::filesystem{"dpmds03.ihep.ac.cn-/storage/disk037":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds03.ihep.ac.cn",
    fs      => "/storage/disk037"
  }
  lcgdm::dpm::filesystem{"dpmds03.ihep.ac.cn-/storage/disk038":
    ensure  => present,
    pool    => "atlas",
    server  => "dpmds03.ihep.ac.cn",
    fs      => "/storage/disk038"
  }
  lcgdm::dpm::filesystem{"dpmlhcb01.ihep.ac.cn-/storage/lhcb01_01":
    ensure  => present,
    pool    => "lhcb",
    server  => "dpmlhcb01.ihep.ac.cn",
    fs      => "/storage/lhcb01_01"
  }
  lcgdm::dpm::filesystem{"dpmlhcb01.ihep.ac.cn-/storage/lhcb01_02":
    ensure  => present,
    pool    => "lhcb",
    server  => "dpmlhcb01.ihep.ac.cn",
    fs      => "/storage/lhcb01_02"
  }
  lcgdm::dpm::filesystem{"dpmlhcb01.ihep.ac.cn-/storage/lhcb01_03":
    ensure  => present,
    pool    => "lhcb",
    server  => "dpmlhcb01.ihep.ac.cn",
    fs      => "/storage/lhcb01_03"
  }
  lcgdm::dpm::filesystem{"dpmlhcb01.ihep.ac.cn-/storage/lhcb01_04":
    ensure  => present,
    pool    => "lhcb",
    server  => "dpmlhcb01.ihep.ac.cn",
    fs      => "/storage/lhcb01_04"
  }
  lcgdm::dpm::filesystem{"dpmlhcb01.ihep.ac.cn-/storage/lhcb01_05":
    ensure  => present,
    pool    => "lhcb",
    server  => "dpmlhcb01.ihep.ac.cn",
    fs      => "/storage/lhcb01_05"
  }
  lcgdm::dpm::filesystem{"dpmlhcb01.ihep.ac.cn-/storage/lhcb01_06":
    ensure  => present,
    pool    => "lhcb",
    server  => "dpmlhcb01.ihep.ac.cn",
    fs      => "/storage/lhcb01_06"
  }





  #
  # Entries in the shift.conf file, you can add in 'host' below the list of
  # machines that the DPM should trust (if any).
  #
  lcgdm::shift::trust_value{
    "DPM TRUST":
      component => "DPM",
      host      => "${disk_nodes}";
    "DPNS TRUST":
      component => "DPNS",
      host      => "${disk_nodes}";
    "RFIO TRUST":
      component => "RFIOD",
      host      => "${disk_nodes}",
      all       => true
  }
  lcgdm::shift::protocol{"PROTOCOLS":
    component => "DPM",
#    proto     => "rfio gsiftp http https xroot"
    proto     => "rfio gsiftp http https xroot"
  }
  
  #
  # VOMS configuration (same VOs as above).
  #
  class{"voms::atlas":}
  class{"voms::lhcb":}
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
    "vomss://voms2.hellasgrid.gr:8443/voms/dteam?/dteam/Role=lcgadmin"   => "dteam",
    "vomss://voms2.hellasgrid.gr:8443/voms/dteam?/dteam/Role=production" => "dteam",
    "vomss://voms2.hellasgrid.gr:8443/voms/dteam?/dteam"                 => "dteam",
    "vomss://voms2.cern.ch:8443/voms/atlas?/atlas/Role=lcgadmin"         => "atlas",
    "vomss://voms2.cern.ch:8443/voms/atlas?/atlas/Role=production"       => "atlas",
    "vomss://voms2.cern.ch:8443/voms/atlas?/atlas"                       => "atlas",
    "vomss://voms2.cern.ch:8443/voms/lhcb?/lhcb/Role=lcgadmin"           => "lhcb",
    "vomss://voms2.cern.ch:8443/voms/lhcb?/lhcb/Role=production"         => "lhcb",
    "vomss://voms2.cern.ch:8443/voms/lhcb?/lhcb"                         => "lhcb",
    "vomss://voms2.cern.ch:8443/voms/ops?/ops"                           => "ops",
    "vomss://lcg-voms2.cern.ch:8443/voms/atlas?/atlas/Role=lcgadmin"         => "atlas",
    "vomss://lcg-voms2.cern.ch:8443/voms/atlas?/atlas/Role=production"       => "atlas",
    "vomss://lcg-voms2.cern.ch:8443/voms/atlas?/atlas"                       => "atlas",
    "vomss://lcg-voms2.cern.ch:8443/voms/lhcb?/lhcb/Role=lcgadmin"           => "lhcb",
    "vomss://lcg-voms2.cern.ch:8443/voms/lhcb?/lhcb/Role=production"         => "lhcb",
    "vomss://lcg-voms2.cern.ch:8443/voms/lhcb?/lhcb"                         => "lhcb",
    "vomss://lcg-voms2.cern.ch:8443/voms/ops?/ops"                           => "ops",
    "vomss://cclcgvomsli01.in2p3.fr:8443/voms/biomed?/biomed"           => "biomed",
  }
  lcgdm::mkgridmap::file {"lcgdm-mkgridmap":
    configfile   => "/etc/lcgdm-mkgridmap.conf",
    mapfile      => "/etc/lcgdm-mapfile",
    localmapfile => "/etc/lcgdm-mapfile-local",
    logfile      => "/var/log/lcgdm-mkgridmap.log",
    groupmap     => $groupmap,
    localmap     => {"/C=CN/O=HEP/O=IHEP/OU=CC/CN=ccsrm.ihep.ac.cn" => "atlas"}
  }
  
  #
  # dmlite configuration.
  #
  class{"dmlite::head":
    token_password => "${token_password}",
    mysql_username => "${db_user}",
    mysql_password => "${db_pass}",
  }
  
  #
  # Frontends based on dmlite.
  #
  class{"dmlite::dav":
    ns_macaroon_secret => "lasjWS&df9p83jjaljd982oi23aKS*JSAA#lsjdfoiaspodihfaposhdfasijfdlknxzlkadsfks2837fjlAS6AL*SAAKSJDljiajdi192873alsjd"
  }

  #class{"dmlite::srm":}
  Class[dmlite::srm::install] -> Class[dmlite::srm::config] -> Class[dmlite::srm::service]

  class{"dmlite::srm::install":
    user  => "dpmmgr",
    group => "dpmmgr"
  }
  class{"dmlite::srm::config":
    dbflavor => "mysql",
    dpmhost  => $fpdn,
    nshost   => $fqdn,
    numthreads => 99
  }
  class{"dmlite::srm::service":}

  class{"dmlite::gridftp":
    dpmhost => "ccsrm.ihep.ac.cn"
  }
  
  #bdii installation and configuration with default values
  class {"bdii":
   selinux            => false,
   manage_firewall    => false
  }

 

  # GIP installation and configuration
  class{"lcgdm::bdii::dpm":
      sitename => "BEIJING-LCG2",
      vos => $volist,
  }
  
  # The XrootD configuration is a bit more complicated and
  # the full config (incl. federations) will be explained here:
  # https://svnweb.cern.ch/trac/lcgdm/wiki/Dpm/Xroot/PuppetSetup
  
  #
  # The simplest xrootd configuration.
  #
  package{'xrootd-server-atlas-n2n-plugin':
    ensure  => 'installed',
    before  => Class['Dmlite::xrootd']
  }
  $atlas_env = {
    "LFC_HOST"            => "prod-lfc-atlas-ro.cern.ch",
    "LFC_CONRETRY"        => 0,
    "GLOBUS_THREAD_MODEL" => "pthread",
    "CSEC_MECH"           => "ID"
  }

  $atlas_fed = {
    name           => 'atlas',
    fed_host       => 'atlas-xrd-asia.grid.sinica.edu.tw',
    xrootd_port    => 1094,
    cmsd_port      => 1098,
    local_port     => 11000,
    namelib_prefix => '/dpm/ihep.ac.cn/home/atlas',
    namelib        => 'XrdOucName2NameLFC.so root=/dpm/cern.ch/home/atlas match=dpmhost.example.com',
    setenv         => $atlas_env,
    paths          => [ '/atlas', '/atlas/scratch' ]
  }

  class{"xrootd::config":
    xrootd_user  => 'dpmmgr',
    xrootd_group => 'dpmmgr'
  }
  class{"dmlite::xrootd":
    nodetype              => [ 'head' ],
    domain                => "${localdomain}",
    dpm_xrootd_serverport => 1095,
    dpm_xrootd_debug      => $debug,
    dpm_xrootd_sharedkey  => "${xrootd_sharedkey}",
    dpm_xrootd_fedredirs  => { "atlas" => $atlas_fed }
  }
 
  Class[dmlite::plugins::memcache::install] ~> Class[dmlite::dav::service]
  Class[dmlite::plugins::memcache::install] ~> Class[dmlite::gridftp]
  Class[dmlite::plugins::memcache::install] ~> Class[dmlite::srm::service]
  
  Class[lcgdm::base::config]
  ->
  class{"memcached":
     # the memory in MB assigned to memcached
     max_memory => 2000,
     # access from localhost only
     listen_ip  => "127.0.0.1",
     }
  ->
  class{"dmlite::plugins::memcache":
   # cache entry expiration limit, in seconds
   expiration_limit => 600,
   # use posix style when accessing folder content
   posix            => 'on',
   } 
  #
  # dmlite shell configuration.
  #
  class{"dmlite::shell":}
  # limit conf
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
  # add for apel storage
  package {"apel-ssm":
    ensure  => 'installed',
    before  => Yumrepo['site']
  }
  file {'/etc/cron.daily/dpm-accounting':
    mode       =>  '755',
    owner      =>  'root',
    group      =>  'root',
    source     =>  "puppet:///modules/emiconfig/dpm-accounting",
    require    => Package['apel-ssm'],
  }
}
