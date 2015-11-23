class emiconfig::frontier {
  class { 'frontier::squid':
      customize_file => 'puppet:///modules/emiconfig/customize.sh',
      cache_dir      => '/var/cache/squid'
  }
}
