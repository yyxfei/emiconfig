class emiconfig::frontier 
(
  $host_monitor = "",
  $customize_lines_local = [
      'setoption("acl NET_LOCAL src", "202.122.33.0/255.255.255.0 192.168.0.0/255.255.0.0 202.114.78.125/32 172.16.52.31/32 159.226.49.0/24 128.142.192.53/32 130.87.106.106/32 202.141.163.195/32 202.122.35.0/255.255.255.0 202.38.140.107/32 124.205.77.0/24")',
      'setoption("acl HOST_MONITOR src", "157.82.112.0/21 131.225.209.5/32  127.0.0.1/32 172.16.52.31/32 159.226.49.0/24 128.142.0.0/16 188.184.128.0/17 188.185.128.0/17 131.225.240.232/32 2001:1458::/31")',
      'setoption("cache_mem", "51200 MB")',
      'setoptionparameter("cache_dir", 3, "55000")',
      'uncomment("acl MAJOR_CVMFS")'
    ],
){
  class { 'frontier::squid':
    cache_dir           => '/var/cache/squid',
    customize_lines     => $customize_lines_local
  }
}
