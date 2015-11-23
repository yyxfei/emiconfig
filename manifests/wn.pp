class emiconfig::wn {
  yumrepo { "torque-emi":
    baseurl => "http://202.122.33.67/yum/torque/6",
    descr => "torque-emi",
    enabled => 1,
    gpgcheck => 0,
    priority => 9,
    before   => Yumrepo['site']
  }
 
  $wn_pkgs=[
    "glexec-wn",
    "yaim-glexec-wn",
    "emi-wn",
    "emi-torque-client",
    "ca-policy-egi-core",
    "munge",
    "HEP_OSlibs_SL6",
  ]
  package{ $wn_pkgs:
    ensure  => "installed",
    require => Yumrepo['site'],
  }
  file{ "/opt/glite/yaim/etc/site-info.def":
    mode         =>  '400',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/cream_site-info.def",
    require      =>  [Package["emi-wn"],
                      Package["yaim-glexec-wn"],
                      Package["glexec-wn"],
                      Package["emi-torque-client"],
                      Package["ca-policy-egi-core"]
                     ]
  }
  file{ "/opt/glite/yaim/etc/users.conf":
    mode         =>  '644',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/users.conf",
    before      =>  File['/opt/glite/yaim/etc/site-info.def']
  }
  file{ "/opt/glite/yaim/etc/groups.conf":
    mode         =>  '644',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/groups.conf",
    before      =>  File['/opt/glite/yaim/etc/site-info.def']
  }
  file{ "/opt/glite/yaim/etc/wn-list.conf":
    mode         =>  '644',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/wn-list.conf",
    before      =>  File['/opt/glite/yaim/etc/site-info.def']
  }
  file{ "/etc/munge/munge.key":
    mode         =>  '400',
    owner        =>  'munge',
    group        =>  'munge',
    source       =>  "puppet:///modules/emiconfig/munge.key",
    require      =>  Package['munge']
  }
  file{ "/opt/glite/yaim/etc/edgusers.conf":
    mode         =>  '400',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/edgusers.conf",
    before      =>  File['/opt/glite/yaim/etc/site-info.def']
  }
  file { "/opt/exp_soft":
    ensure   => link,
    target   => "/ihepbatch/exp_soft",
    force    => true,
  }
  file {"/scratch":
    ensure   => "directory",
    owner    => "root",
    group    => "root",
    mode     => '1777'
  }
  file {"/var/torque/mom_priv/config":
    mode         => '644',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/mom_config",
    require      => Package["emi-torque-client"],
    notify       => Service['pbs_mom'],
  }


  exec{ 'yaim-config':
    command      => "/opt/glite/yaim/bin/yaim -c -s /opt/glite/yaim/etc/site-info.def -n WN -n GLEXEC_wn -n TORQUE_client",
    subscribe    => File['/opt/glite/yaim/etc/site-info.def'],
    refreshonly  => true,
    timeout      => 1900
   }
   service { 'pbs_mom':
   ensure     => 'running',
   enable     => true,
   hasrestart => true,
   hasstatus  => true,
   require    => Package['emi-torque-client'],
   }
   service{"rpcidmapd":
      ensure     =>  'running',
      enable     =>  true,
      hasstatus  =>  true,
      hasrestart =>  true,
      require     => Package['emi-wn'],
   }

# mount cream_sandbos
  file {"/var/cream_sandbox":
    ensure   => link,
    target   => "/ihepbatch/cream_sandbox",
    force    => true
  }
  file {"/root/watchCMSGlidein.py":
    mode         =>  '755',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/watchCMSGlidein.py",
  }
  cron { clean-cmslog:
    command => '/root/watchCMSGlidein.py 2>& 1 | tee -a /var/log/watchCMSGlidein.log',
    user    => 'root',
    hour    => "*/1",
    minute  => 44
  }
  cron { clean-scratch:
    command => 'find /scratch/*.ihep.ac.cn -maxdepth 0 -ctime +3 -exec rm -rf {} \;',
    user    => 'root',
    hour    => 3,
    minute  => 44
  }

}
