class emiconfig::apel {

  #$creamhosts = {
  #  "cce.ihep.ac.cn" =>{}
  # }
  #class { 'apelpublisher::install': }
  #->
  #class { 'apelpublisher::config::mysql': 
  #  mysql_root_password    => 'lcg123',
  #  mysql_apel_password    => 'lcg123'
  #}
  #->
  #class { 'apelpublisher::create_database': 
  #  mysql_root_password        => 'lcg123',
  #  mysql_apel_password        => 'lcg123',
  #}
  #->
  #class { 'apelpublisher::config':
  #  mysql_password    => 'lcg123',
  #  site_name         => 'BEIJING-LCG2',
  #  ldap_host         => 'lcg007.ihep.ac.cn',
  #}
  #->
  #class { 'apelpublisher::ssm::sender':
  #  destination_queue => '/queue/global.accounting.cpu.central',
  #  msg_network       => 'PROD'
  #}
  #->
  #class { 'apelpublisher::cron': 
  #  cron_minutes     => "35",
  #  cron_hours      => "3",
  #}
  #->
  #class { 'fetchcrl': }
  #->
  #class { 'apelpublisher::service': }
  $apelpkg = [
  #"mariadb-server",
  "ca-policy-egi-core",
  "apel-lib",
  "apel-ssm",
  "apel-client",
  ]

  package {$apelpkg:
    ensure =>  installed,
    require => Yumrepo['site'],
  }# ->
  
  #class { '::mysql::server':
  #  root_password           => 'lcg123',
  #  remove_default_accounts => true,
  #  #override_options        => $override_options
  #}
 
  
  # mysql The APEL client database schema is located at /usr/share/apel/client.sql.
  # mysql -p –e "create database apelclient"
  # mysql -p apelclient < /usr/share/apel/client.sql

  # mysql> GRANT ALL PRIVILEGES ON apelclient.* TO 'apel'@'localhost' IDENTIFIED BY '<apel-password>';
  # For each machine on which APEL Parsers are installed:
  # mysql> GRANT ALL PRIVILEGES ON apelclient.* TO 'apel'@'<FQDN>' IDENTIFIED BY '<apel-password>';

}
