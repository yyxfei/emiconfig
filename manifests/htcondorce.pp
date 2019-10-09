class emiconfig::htcondorce {
  package { ['condor','ca-policy-egi-core']: ensure => present, }
  class{'htcondor_ce':
    pool_collectors            => ['ce01.ihep.ac.cn'],
    condor_view_hosts          => ['ce01.ihep.ac.cn'],
    ce_version                 => '3.1.2-3.el7',
    lrms_version               => '8.6.11-1.el7',
    gsi_regex                  => '^\/C\=CN\/O\=HEP\/O\=IHEP\/OU\=CC\/CN\=(host\/)?([A-Za-z0-9.\-]*)$',
    argus_server               => 'argus.ihep.ac.cn',
    argus_resourceid           => 'http://lcg.cscs.ch/xacml/resource/resource-type/creamce',
    supported_vos              => ['atlas','cms','lhcb','ops','dteam'],
    goc_site_name              => 'BEIJING-LCG2',
    benchmark_result           => '10.00-HEP-SPEC06',
    execution_env_cores        => 36,
  }
}
