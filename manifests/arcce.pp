class emiconfig::arcce {
  file { "/opt/exp_soft":
    ensure   => link,
    target   => "/ihepbatch/exp_soft",
    force    => true,
  }
  class { 'arc_ce': 
    manage_repository   =>  false,
    mail                =>  "yanxf@ihep.ac.cn",
    authorized_vos      => [
                              'atlas',
                              'cms',
                              'lhcb',
                              'ops',
                              'dteam'],
    benchmark_results   => [
                              'SPECINT2000 2732',
                              'SPECFP2000 2834',
                              'HEPSPEC2006 16000'],
    cluster_description => {
                              'OSFamily'      => 'linux',
                              'OSName'        => 'ScientificSL',
                              'OSVersion'     => '7.5',
                              'OSVersionName' => 'Carbon',
                              'CPUVendor'     => 'Intel',
                              'CPUClockSpeed' => '2500',
                              'CPUModel'      => 'Intel(R) Xeon(R) CPU E5-2680 v3',
                              'NodeMemory'    => '64000',
                              'totalcpus'     => '888',
    },
    enable_firewall     => false,
    domain_name         => 'BEIJING-LCG2',
    emi_repo_version    => '3',
  }
}
