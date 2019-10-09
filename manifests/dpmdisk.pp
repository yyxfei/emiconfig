class emiconfig::dpmdisk {

class{'dpm::disknode':
  headnode_fqdn                 => "ccsrm.ihep.ac.cn",
  disk_nodes                    => ['dpmds01.ihep.ac.cn','dpmds02.ihep.ac.cn','dpmds03.ihep.ac.cn','dpmlhcb01.ihep.ac.cn'],
  localdomain                   => 'ihep.ac.cn',
  token_password                => 'kwpoMyvcusgdbyyws6gfcxhntkLoh8jilwivniveasdfasdfl',
  xrootd_sharedkey              => 'DXjgDTkK55fnyFr8gW1RcYv0pV7vkcWmZyHr9f4aocasdfa8=',
  configure_dpm_xrootd_checksum => true,
  volist                        => ["atlas", "lhcb", "biomed", "dteam", "ops"],
  dpmmgr_uid                    => 500,
  dpmmgr_gid                    => 500,
  configure_dome                => true,
  configure_domeadapter         => true,
  host_dn                       => "/C=CN/O=HEP/O=IHEP/OU=CC/CN=${::fqdn}",
  configure_legacy              => true,
  gridftp_redirect              => true,
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
}

#  class{"voms::atlas":}
#  class{"voms::lhcb":}
#  class{"voms::dteam":}
#  class{"voms::ops":}

 # voms::client{'biomed':
 #       servers  => [{server => 'cclcgvomsli01.in2p3.fr',
 #                  port   => '15000',
 #                  dn    => '/O=GRID-FR/C=FR/O=CNRS/OU=CC-IN2P3/CN=cclcgvomsli01.in2p3.fr',
 #                  ca_dn => '/C=FR/O=MENESR/OU=GRID-FR/CN=AC GRID-FR Services',
 #                 }]
 #  }


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
