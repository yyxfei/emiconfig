class emiconfig::creamce {

     yumrepo { "torque-emi":
        baseurl => "http://202.122.33.67/yum/torque/6",
        descr => "torque-emi",
        enabled => 1,
        gpgcheck => 0,
        before   => Yumrepo['site']
     }

  $creampkg=[
   "ca-policy-egi-core",
   "emi-torque-server",
   "dynsched-generic",
   "lcg-info-dynamic-scheduler-pbs",
   "emi-version",
   "glite-yaim-torque-utils",
   "lcg-pbs-utils",
   "torque",
   "maui",
   "torque-client",
   "emi-cream-ce",
   "munge",
  ]
  package { $creampkg :
    ensure   => 'installed',
    require   => Yumrepo['site'],
  }
  package {"glite-yaim-core.noarch":
    ensure => 'installed',
    require => Yumrepo['site'],
  }
  file{ "/opt/glite/yaim/etc/site-info.def":
    mode         =>  '400',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/cream_site-info.def",
    require      =>  Package['glite-yaim-core.noarch']
  }
  file{ "/opt/glite/yaim/etc/users.conf":
    mode         =>  '400',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/users.conf",
    before      =>  File['/opt/glite/yaim/etc/site-info.def']
  }
  file{ "/opt/glite/yaim/etc/groups.conf":
    mode         =>  '400',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/groups.conf",
    before      =>  File['/opt/glite/yaim/etc/site-info.def']
  }
  file{ "/opt/glite/yaim/etc/wn-list.conf":
    mode         =>  '400',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/wn-list.conf",
    before      =>  File['/opt/glite/yaim/etc/site-info.def']
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
  service { 'munge':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Package['munge'],
  }

 # APELParser
  class { 'apelparser::install': }
  ->
  class { 'apelparser::config': 
    mysql_hostname => 'lcg008.ihep.ac.cn',
    mysql_port     => '3306',
    mysql_database => 'apelclient',
    mysql_user     => 'apel',
    mysql_password => 'asdfasdfasfasfdasfdasdf',
    site_name      => 'BEIJING-LCG2',
  }
  ->
  class { 'apelparser::cron': }
  # for sudo config
  sudo::conf { 'cream':
    priority => 15,
    source => 'puppet:///modules/emiconfig/sudoers.forcream',
  }

 # PBS account
  cron { 'qstatFile':
    command   => '/root/shijy/qstatFile.sh',
    user      => 'root',
    minute    => '*/3',
    hour      => '*'
  }

  cron { 'pbs-bak':
    command   => '/root/shijy/pbs-bak.sh',
    user      => 'root',
    minute    => '0',
    hour      => '0'
  }



  #exec{ 'yaim-config':
  #  command      => "/opt/glite/yaim/bin/yaim -c -s /opt/glite/yaim/etc/site-info.def -n creamCE -n TORQUE_utils",
  #  #command      => "/opt/glite/yaim/bin/yaim -c -s /opt/glite/yaim/etc/site-info.def -n creamCE -n TORQUE_server -n TORQUE_utils",
  #  subscribe    => File['/opt/glite/yaim/etc/site-info.def'],
  #  refreshonly  => true,
  #  timeout      => 3600
  # }



}
 # ensure package version  glite-lb-client-java-2.0.5-1.el6.x86_64
