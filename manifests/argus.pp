class emiconfig::argus {
 
  package{ $emi_type_pkg:
    ensure  => "installed",
    require => Yumrepo['site'],
  }
  package {"glite-yaim-core.noarch":
    ensure => 'installed',
    require => Yumrepo['site'],
  }
  package {"ca-policy-egi-core":
    ensure  => 'installed',
    before  =>  Yumrepo['site']
  }
  package {"fetch-crl":
    ensure  => 'installed',
    before  =>  Yumrepo['site']
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

#  exec{ 'yaim-config':
#    command      => "/opt/glite/yaim/bin/yaim -c -s /opt/glite/yaim/etc/site-info.def -n $emi_type",
#    subscribe    => File['/opt/glite/yaim/etc/site-info.def'],
#    refreshonly  => true,
#    timeout      => 3600
#   }
}
