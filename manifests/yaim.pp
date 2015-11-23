class emiconfig::yaim {
  package{ $emi_type_pkg:
    ensure  => "installed",
    require => Yumrepo['site'],
  }
  package {"glite-yaim-core.noarch":
    ensure => 'installed',
    require => Yumrepo['site'],
  }
  file{ "/opt/glite/yaim/etc/site-info.def":
    mode         =>  '400',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/site-info.def",
    require      =>  Package['glite-yaim-core.noarch']
  }

  exec{ 'yaim-config':
    command      => "/opt/glite/yaim/bin/yaim -c -s /opt/glite/yaim/etc/site-info.def -n $emi_type",
    subscribe    => File['/opt/glite/yaim/etc/site-info.def'],
    refreshonly  => true
   }
}
