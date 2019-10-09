class emiconfig::creamce {

  service { 'munge':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Package['munge'],
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
