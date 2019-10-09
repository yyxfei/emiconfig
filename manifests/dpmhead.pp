class emiconfig::dpmhead {
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

  class{"dpm::headnode":
    localdomain                   => 'ihep.ac.cn',
    db_user                       => 'dpmmgr',
    db_pass                       => 'lcg123',
    db_host                       => 'localhost',
    disk_nodes                    => ['dpmds01.ihep.ac.cn','dpmds02.ihep.ac.cn','dpmds03.ihep.ac.cn','dpmlhcb01.ihep.ac.cn',],
    local_db                      => true,
    mysql_root_pass               => 'lcg123',
    token_password                => 'kwpoMyvcusgdbyyws6gfcxhntkLoh8jilwivnivel',
    xrootd_sharedkey              => 'DXjgDTkK55fnyFr8gW1RcYv0pV7vkcWmZyHr9f4aoc8=',
    configure_dpm_xrootd_checksum => true,
    site_name                     => 'BEIJING-LCG2',
    volist                        => ["atlas", "lhcb", "biomed", "dteam", "ops"],
    new_installation              => false,
    memcached_enabled             => true,
    dpmmgr_uid                    => '500',
    dpmmgr_gid                    => '500',
    configure_dome                => true,
    configure_domeadapter         => true,
    host_dn                       => '/C=CN/O=HEP/O=IHEP/OU=CC/CN=ccsrm.ihep.ac.cn',
    pools                         => ['opsdteam:200M','atlas:200M','lhcb:100M'],
    gridftp_redirect              => true,
    filesystems                  => [
      "opsdteam:dpmds01.ihep.ac.cn:/storage/disk01d1p1",
      "atlas:dpmds01.ihep.ac.cn:/storage/disk011",
      "atlas:dpmds01.ihep.ac.cn:/storage/disk012",
      "atlas:dpmds01.ihep.ac.cn:/storage/disk013",
      "atlas:dpmds01.ihep.ac.cn:/storage/disk014",
      "atlas:dpmds02.ihep.ac.cn:/storage/disk021",
      "atlas:dpmds02.ihep.ac.cn:/storage/disk022",
      "atlas:dpmds02.ihep.ac.cn:/storage/disk023",
      "atlas:dpmds02.ihep.ac.cn:/storage/disk024",
      "atlas:dpmds02.ihep.ac.cn:/storage/disk025",
      "atlas:dpmds02.ihep.ac.cn:/storage/disk026",
      "atlas:dpmds02.ihep.ac.cn:/storage/disk027",
      "atlas:dpmds02.ihep.ac.cn:/storage/disk028",
      "atlas:dpmds03.ihep.ac.cn:/storage/disk031",
      "atlas:dpmds03.ihep.ac.cn:/storage/disk032",
      "atlas:dpmds03.ihep.ac.cn:/storage/disk033",
      "atlas:dpmds03.ihep.ac.cn:/storage/disk034",
      "atlas:dpmds03.ihep.ac.cn:/storage/disk035",
      "atlas:dpmds03.ihep.ac.cn:/storage/disk036",
      "atlas:dpmds03.ihep.ac.cn:/storage/disk037",
      "atlas:dpmds03.ihep.ac.cn:/storage/disk038",
      "lhcb:dpmlhcb01.ihep.ac.cn:/storage/lhcb01_01",
      "lhcb:dpmlhcb01.ihep.ac.cn:/storage/lhcb01_02",
      "lhcb:dpmlhcb01.ihep.ac.cn:/storage/lhcb01_03",
      "lhcb:dpmlhcb01.ihep.ac.cn:/storage/lhcb01_04",
      "lhcb:dpmlhcb01.ihep.ac.cn:/storage/lhcb01_05",
      "lhcb:dpmlhcb01.ihep.ac.cn:/storage/lhcb01_06",
      ],
    groupmap => {
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
    },
    dpm_xrootd_fedredirs   => {"atlas" => $atlas_fed}, 
  }
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
  # publishing json file for storage accounting
  cron {
      'dpm-storage-summary':
          command         => '/usr/bin/dpm-storage-summary.py --path /dpm/ihep.ac.cn/home/SRR --log-level=DEBUG --log-file=/var/log/dpm-srr.log',
          user            => 'root',
          minute          => '*/15';
  }

  class { 'limits':
    purge_limits_d_dir => false,
  }
   limits::limits { 'user_nofile':
    ensure     => present,
    user       => '*',
    limit_type => 'nofile',
    soft       => '65535',
    hard       => '65535',
  }
   limits::limits { 'user_nproc':
    ensure     => present,
    user       => '*',
    limit_type => 'nproc',
    soft       => '65535',
    hard       => '65535',
  }
}
