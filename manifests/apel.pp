class emiconfig::apel {

  $creamhosts = {
    "cce.ihep.ac.cn" =>{}
   }
  class { 'apelpublisher::install': }
  ->
  class { 'apelpublisher::config::mysql': 
    mysql_root_password    => 'asdfasdfasfasfdasfdasdf',
    mysql_apel_password    => 'asdfasdfasfasfdasfdasdf'
  }
  ->
  class { 'apelpublisher::create_database': 
    mysql_root_password        => 'asdfasdfasfasfdasfdasdf',
    mysql_apel_password        => 'asdfasdfasfasfdasfdasdf',
  }
  ->
  class { 'apelpublisher::config':
    mysql_password    => 'asdfasdfasfasfdasfdasdf',
    site_name         => 'BEIJING-LCG2',
    ldap_host         => 'lcg007.ihep.ac.cn',
  }
  ->
  class { 'apelpublisher::ssm::sender':
    destination_queue => '/queue/global.accounting.cpu.central',
    msg_network       => 'PROD'
  }
  ->
  class { 'apelpublisher::cron': 
    cron_minutes     => "35",
    cron_hours      => "3",
  }
  ->
  class { 'fetchcrl::install': }
  ->
  class { 'apelpublisher::service': }
}
