#
# This is an example configuration for the LFC service.
#
# You can check the puppet modules 'lcgdm' and 'dmlite' for any additional options available.
# !! Please replace the placeholders for usernames and passwords !!
#

#
# The standard variables are collected here:
#
class emiconfig::lfc {
  $mysql_root_pass = "asdfasdfasfasfdasfdasdf"
  $db_user = "dpmmgr"
  $db_pass = "asdfasdfasfasfdasfdasdf"
  $localdomain = "ihep.ac.cn"
  $volist = ["dteam", "ops", "bes"]
  $debug = false
  
  
  Class[Mysql::Server] -> Class[Lcgdm::Ns::Service]
  Class[Lcgdm::Ns::Service] -> Class[Lcgdm::Ns::Client]
  Lcgdm::Ns::Domain <| |> -> Lcgdm::Ns::Vo <| |>
  Class[Dmlite::Plugins::Adapter::Install] ~> Class[Dmlite::Dav::Lfc]
  
  #
  # The firewall configuration
  #
  # MySQL server setup - disable if it is not local
  #
  class{"mysql::server":
    service_enabled => true,
    root_password   => "${mysql_root_pass}"
  }
  
  #
  # lcgdm configuration
  #
  #class{"lcgdm::base::config":
  #  cert    => "lfccert.pem",
  #  certkey => "lfckey.pem",
  #  user    => "lfcmgr"
  #}
  
  #
  # Nameserver client and server configuration.
  #
  class{"lcgdm::base":
    user     => "lfcmgr"
  }
  class{"lcgdm::ns":
    flavor   => "lfc",
    dbflavor => "mysql",
    dbuser   => "${db_user}",
    dbpass   => "${db_pass}",
  }

# package emi-verion for publist emi version
  package{'emi-version':
    ensure  => 'installed',
    before  => Yumrepo['site']
  }

  
  #
  # dmlite plugins configuration.
  #
  class{"dmlite::lfc":
    dbflavor        => "mysql",
    dbuser          => "${db_user}",
    dbpass          => "${db_pass}",
  }
  class{"dmlite::plugins::librarian":}
  
  #
  # Create path for domain and VOs to be enabled.
  #
  #lcgdm::ns::domain{"${localdomain}":}
  #lcgdm::ns::vo{$volist:
  #  vopath  =>"/grid/$name",
  #  domain  => "${localdomain}",
  #}
  
  #
  # Frontends based on dmlite.
  #
  class{"dmlite::dav::lfc":}
  
  #
  # VOMS configuration (same VOs as above).
  #
  class{"voms::ops":}
  class{"voms::dteam":}
  voms::client{'bes':
      servers  => [{server => 'voms.ihep.ac.cn',
                    port   => '15001',
                    dn    => '/C=CN/O=HEP/OU=CC/O=IHEP/CN=voms.ihep.ac.cn',
                    ca_dn => '/C=CN/O=HEP/CN=Institute of High Energy Physics Certification Authority'
                   }]
  }

  
  #
  # Gridmapfile configuration.
  #
  class{"lcgdm::mkgridmap::install":}
  $groupmap = {
    "vomss://voms.hellasgrid.gr:8443/voms/dteam?/dteam/Role=lcgadmin"   => "dteam",
    "vomss://voms.hellasgrid.gr:8443/voms/dteam?/dteam/Role=production" => "dteam",
    "vomss://voms.hellasgrid.gr:8443/voms/dteam?/dteam"                 => "dteam",
    "vomss://voms.cern.ch:8443/voms/ops?/ops/Role=lcgadmin"             => "ops",
    "vomss://voms.cern.ch:8443/voms/ops?/ops/Role=pilot"                => "ops",
    "vomss://voms.cern.ch:8443/voms/ops?/ops"                           => "ops",
    "vomss://voms.ihep.ac.cn:8443/voms/bes?/bes/Role=lcgadmin"          => "bes",
    "vomss://voms.ihep.ac.cn:8443/voms/bes?/bes/Role=production"        => "bes",
    "vomss://voms.ihep.ac.cn:8443/voms/bes?/bes/Role=pilot"             => "bes",
    "vomss://voms.ihep.ac.cn:8443/voms/bes?/bes"                        => "bes",
  }
  lcgdm::mkgridmap::file {"lcgdm-mkgridmap":
    configfile   => "/etc/lcgdm-mkgridmap.conf",
    mapfile      => "/etc/lcgdm-mapfile",
    localmapfile => "/etc/lcgdm-mapfile-local",
    logfile      => "/var/log/lcgdm-mkgridmap.log",
    groupmap     => $groupmap,
    localmap     => {"nobody" => "nogroup"}
  }
  
  lcgdm::shift::trust_value{"lfc-localhost":
    component => "LFC",
    host      => "*"
  }
  
#for BDII configure
  class{"bdii::install":
   selinux  => false
  }
   class {'bdii::config':}
   class {'bdii::service':}



  # GIP installation and configuration
  class{"lcgdm::bdii::lfc":
      sitename   => "BEIJING-LCG2",
      localvos   => ['ops','dteam'],
      centralvos => ['bes']
  }

  #
  # dmlite shell configuration.
  #class{"dmlite::shell":}
}
