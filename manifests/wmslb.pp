class emiconfig::wmslb {
  file{ "/opt/glite/yaim/etc/site-info.def":
    mode         =>  '400',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/wms_site-info.def",
    require      =>  [Package['emi-wms'],Package['emi-lb'],Package['ca-policy-egi-core'],]
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
  $creampkg=[
   "ca-policy-egi-core",
   "emi-wms",
   "emi-lb"
  ]
  package { $creampkg :
    ensure   => 'installed',
    require   => Yumrepo['site'],
  }
  #exec{ 'yaim-config':
  #  command      => "/opt/glite/yaim/bin/yaim -c -s /opt/glite/yaim/etc/site-info.def -n WMS -n LB",
  #  subscribe    => File['/opt/glite/yaim/etc/site-info.def'],
  #  refreshonly  => true,
  #  timeout      => 3600
  #}
}

