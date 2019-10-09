class emiconfig::vomses {
  class{"voms::atlas":}
  class{"voms::cms":}
  class{"voms::dteam":}
  class{"voms::lhcb":}
  class{"voms::ops":}
  class{"voms::biomed":}
  class{"voms::esr":}
  # class{"voms::biomed":}

  voms::client{'enmr.eu':
    servers => [
      {
        server => 'voms-02.pd.infn.it',
          port => '15014',
            dn => '/DC=org/DC=terena/DC=tcs/C=IT/L=Frascati/O=Istituto Nazionale di Fisica Nucleare/CN=voms-02.pd.infn.it',
         ca_dn => '/C=NL/ST=Noord-Holland/L=Amsterdam/O=TERENA/CN=TERENA eScience SSL CA 3',
      },
      {
        server => 'voms2.cnaf.infn.it',
          port => '15014',
            dn => '/C=IT/O=INFN/OU=Host/L=CNAF/CN=voms2.cnaf.infn.it',
         ca_dn => '/C=IT/O=INFN/CN=INFN Certification Authority',
      },
    ]
  }
  voms::client{'vo.france-asia.org':
        servers  => [{server => 'cclcgvomsli01.in2p3.fr',
                   port   => '15019',
                   dn    => '/O=GRID-FR/C=FR/O=CNRS/OU=CC-IN2P3/CN=cclcgvomsli01.in2p3.fr',
                   ca_dn => '/C=FR/O=CNRS/CN=GRID2-FR',
                  }]
  }
  voms::client{'bes':
        servers  => [{server => 'voms.ihep.ac.cn',
                   port   => '15001',
                   dn    => '/C=CN/O=HEP/OU=CC/O=IHEP/CN=voms.ihep.ac.cn',
                   ca_dn => '/C=CN/O=HEP/CN=Institute of High Energy Physics Certification Authority',
                  }]
  }
  voms::client{'cepc':
        servers  => [{server => 'voms.ihep.ac.cn',
                   port   => '15005',
                   dn    => '/C=CN/O=HEP/OU=CC/O=IHEP/CN=voms.ihep.ac.cn',
                   ca_dn => '/C=CN/O=HEP/CN=Institute of High Energy Physics Certification Authority',
                  }]
  }
  voms::client{'juno':
        servers  => [{server => 'voms.ihep.ac.cn',
                   port   => '15008',
                   dn    => '/C=CN/O=HEP/OU=CC/O=IHEP/CN=voms.ihep.ac.cn',
                   ca_dn => '/C=CN/O=HEP/CN=Institute of High Energy Physics Certification Authority',
                  }]
  }


}
