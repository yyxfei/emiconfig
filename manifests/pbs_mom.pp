class emiconfig::pbs_mom(
  $torque_server = "ce02.ihep.ac.cn"
) {
  
  $pbspkg=[
    "torque-mom",
    "torque-client"
  ]
  package{ $pbspkg:
    ensure  => "installed",
    require => Yumrepo['site'],
  }->
  file{ "/etc/munge/munge.key":
    mode         =>  '400',
    owner        =>  'munge',
    group        =>  'munge',
    source       =>  "puppet:///modules/emiconfig/munge.key",
  }->
  file {"/etc/torque/server_name":
    mode         => '644',
    owner        =>  'root',
    group        =>  'root',
    content      =>  "$torque_server",
  }~>
  file {"/etc/torque/mom/config":
    mode         => '644',
    owner        =>  'root',
    group        =>  'root',
    content      =>  template("${module_name}/pbs_config.erb"),
    notify       =>  Service['pbs_mom'],
  }~>
  service{ 'trqauthd':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }~>
  service{ 'munge':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }~>
  service{ 'pbs_mom':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }

  cron { clean-scratch:
    command => 'find /scratch/*.ihep.ac.cn -maxdepth 0 -ctime +3 -exec rm -rf {} \;',
    user    => 'root',
    hour    => 3,
    minute  => 44
  }
}
