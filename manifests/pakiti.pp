class emiconfig::pakiti {
  package { 'pakiti-client':
    ensure => 'present',
    require => Yumrepo['site'],
  }->
  file { '/etc/egi-package-reporter.conf':
    mode         =>  '0644',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/egi-package-reporter.conf",
  }->
  cron { 'pakiti-egi':
    ensure  => 'present',
    command => 'pakiti-client --conf /etc/egi-package-reporter.conf --site BEIJING-LCG2',
    user    => 'nobody',
    hour    => fqdn_rand(24),
    minute  => fqdn_rand(60),
  }
}
