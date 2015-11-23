class emiconfig::atlas-frontier {

  class { 'frontier::squid':
      cache_dir      => '/var/squid/cache'
  }

}
