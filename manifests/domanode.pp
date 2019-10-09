class emiconfig::domanode {

  class{"dpm::head_disknode":
    localdomain                  => 'ihep.ac.cn',
    db_user                      => 'dpmmgr',
    db_pass                      => 'lcg123',
    db_host                      => 'localhost',
    disk_nodes                   => ['dpmtest.ihep.ac.cn',],
    local_db                     => true,
    mysql_root_pass              => 'lcg123',
    token_password               => 'kwpoMyvcusgdbyyws6gfcxhntkLoh8jilwivnivel',
    xrootd_sharedkey             => 'DXjgDTkK55fnyFr8gW1RcYv0pV7vkcWmZyHr9f4aoc8=',
    site_name                    => 'BEIJING-LCG2',
    volist                       => ["dteam", "ops"],
    new_installation             => true,
    memcached_enabled            => true,
    configure_default_pool       => true,
    configure_default_filesystem => true,
    configure_dome               => true,
    configure_domeadapter        => true,
    #configure_legacy             => false,
    #gridftp_redirect             => true,
    host_dn                      =>  '/C=CN/O=HEP/O=IHEP/OU=CC/CN=dpmtest.ihep.ac.cn',
    pools                        => ['dteam:100M'],
    filesystems                  => [
      "dteam:dpmtest.ihep.ac.cn:/storage/disk01",
      ],
    groupmap => {
      "vomss://voms2.hellasgrid.gr:8443/voms/dteam?/dteam/Role=lcgadmin"   => "dteam",
      "vomss://voms2.hellasgrid.gr:8443/voms/dteam?/dteam/Role=production" => "dteam",
      "vomss://voms2.hellasgrid.gr:8443/voms/dteam?/dteam"                 => "dteam",
      "vomss://voms2.cern.ch:8443/voms/ops?/ops"                           => "ops",
      "vomss://lcg-voms2.cern.ch:8443/voms/ops?/ops"                           => "ops",
    },
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
