class emiconfig::gridusers {
   file {'/ihepbatch/gridfs1/home':
     ensure   => directory,
   }

  class {'grid_accounts':
    resources   => {
      accounts      =>  true,
      gridmapdir    =>  true,
      gridmapfile  =>  true,
      groupmapfile  =>  true,
    },
    
    home_path  => '/ihepbatch/gridfs1/home',
    pool_users => {
      #atlas
      '/atlas'  => {
        ensure => 'present',
        group         => 'atlas',
        gid           => '72001',
        vo_group      => 'atlas',
        uid_range     => '72001-72200',
        users_num     => 200,
        comment       => 'grid user'
      },
      '/atlas/ROLE=lcgadmin' => {
        ensure        => 'present',
        group         => 'atlassgm',
        gid           => '72002',
        vo_group      => 'atlas',
        uid_range     => '72201-72210',
        users_num     => 10,
        comment       => 'grid user'
      },
      '/atlas/ROLE=production' => {
        ensure        => 'present',
        group         => 'atlasprd',
        gid           => '72003',
        vo_group      => 'atlas',
        uid_range     => '72211-72260',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/atlas/ROLE=pilot'      => {
        ensure        => 'present',
        group         => 'atlaspil',
        gid           => '72004',
        vo_group      => 'atlas',
        uid_range     => '72301-72350',
        users_num     => 50,
        comment       => 'grid user'
      },
      #cms
      '/cms'  => {
        ensure => 'present',
        group         => 'cms',
        gid           => '75001',
        vo_group      => 'cms',
        uid_range     => '75001-75200',
        users_num     => 200,
        comment       => 'grid user'
      },
      '/cms/ROLE=lcgadmin' => {
        ensure        => 'present',
        group         => 'cmssgm',
        gid           => '75002',
        vo_group      => 'cms',
        uid_range     => '75201-75210',
        users_num     => 10,
        comment       => 'grid user'
      },
      '/cms/ROLE=production' => {
        ensure        => 'present',
        group         => 'cmsprd',
        gid           => '75003',
        vo_group      => 'cms',
        uid_range     => '75211-75260',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/cms/ROLE=pilot'      => {
        ensure        => 'present',
        group         => 'cmspil',
        gid           => '75004',
        vo_group      => 'cms',
        uid_range     => '75301-75350',
        users_num     => 50,
        comment       => 'grid user'
      },
      #lhcb

      '/lhcb'  => {
        ensure => 'present',
	group         => 'lhcb',
	gid           => '80001',
	vo_group      => 'lhcb',
	uid_range     => '80001-80050',
	users_num     => 50,
	comment       => 'grid user'
      },
      '/lhcb/ROLE=lcgadmin' => {
        ensure        => 'present',
        group         => 'lhcbsgm',
        gid           => '80002',
        vo_group      => 'lhcb',
        uid_range     => '80101-80150',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/lhcb/ROLE=production' => {
        ensure        => 'present',
        group         => 'lhcbprd',
        gid           => '80003',
        vo_group      => 'lhcb',
        uid_range     => '80151-80200',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/lhcb/ROLE=pilot'      => {
        ensure        => 'present',
        group         => 'lhcbpil',
        gid           => '80004',
        vo_group      => 'lhcb',
        uid_range     => '80201-80250',
        users_num     => 50,
        comment       => 'grid user'
      },
      # ops
      '/ops'  => {
        ensure => 'present',
        group         => 'ops',
        gid           => '78001',
        vo_group      => 'ops',
        uid_range     => '78001-78150',
        users_num     => 150,
        comment       => 'grid user'
      },
      '/ops/ROLE=lcgadmin' => {
        ensure        => 'present',
        group         => 'opssgm',
        gid           => '78002',
        vo_group      => 'ops',
        uid_range     => '78151-78160',
        users_num     => 5,
        comment       => 'grid user'
      },
      '/ops/ROLE=production' => {
        ensure        => 'present',
        group         => 'opsprd',
        gid           => '78003',
        vo_group      => 'ops',
        uid_range     => '78161-78170',
        users_num     => 5,
        comment       => 'grid user'
      },
      '/ops/ROLE=pilot'      => {
        ensure        => 'present',
        group         => 'opspil',
        gid           => '78004',
        vo_group      => 'ops',
        uid_range     => '78171-78180',
        users_num     => 5,
        comment       => 'grid user'
      },
      #dteam
      '/dteam'  => {
        ensure => 'present',
        group         => 'dteam',
        gid           => '78201',
        vo_group      => 'dteam',
        uid_range     => '78201-78250',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/dteam/ROLE=lcgadmin' => {
        ensure        => 'present',
        group         => 'dteamsgm',
        gid           => '78202',
        vo_group      => 'dteam',
        uid_range     => '78251-78260',
        users_num     => 10,
        comment       => 'grid user'
      },
      '/dteam/ROLE=production' => {
        ensure        => 'present',
        group         => 'dteamprd',
        gid           => '78203',
        vo_group      => 'dteam',
        uid_range     => '78261-78270',
        users_num     => 10,
        comment       => 'grid user'
      },
      '/esr'  => {
        ensure => 'present',
        group         => 'esr',
        gid           => '77001',
        vo_group      => 'esr',
        uid_range     => '77001-77050',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/esr/ROLE=lcgadmin' => {
        ensure        => 'present',
        group         => 'esrsgm',
        gid           => '77002',
        vo_group      => 'esr',
        uid_range     => '77101-77150',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/esr/ROLE=production' => {
        ensure        => 'present',
        group         => 'esrprd',
        gid           => '77003',
        vo_group      => 'esr',
        uid_range     => '77151-77200',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/esr/ROLE=pilot'      => {
        ensure        => 'present',
        group         => 'esrpil',
        gid           => '77004',
        vo_group      => 'esr',
        uid_range     => '77201-77250',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/biomed'  => {
        ensure => 'present',
        group         => 'bio',
        gid           => '74001',
        vo_group      => 'bio',
        uid_range     => '74001-74050',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/biomed/ROLE=lcgadmin' => {
        ensure        => 'present',
        group         => 'biosgm',
        gid           => '74002',
        vo_group      => 'bio',
        uid_range     => '74101-74150',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/biomed/ROLE=production' => {
        ensure        => 'present',
        group         => 'bioprd',
        gid           => '74003',
        vo_group      => 'bio',
        uid_range     => '74151-74200',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/biomed/ROLE=pilot'      => {
        ensure        => 'present',
        group         => 'biopil',
        gid           => '74004',
        vo_group      => 'bio',
        uid_range     => '74201-74250',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/enmr.eu'  => {
        ensure => 'present',
        group         => 'enmr',
        gid           => '71001',
        vo_group      => 'enmr',
        uid_range     => '71001-71050',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/enmr.eu/ROLE=lcgadmin' => {
        ensure        => 'present',
        group         => 'enmrsgm',
        gid           => '71002',
        vo_group      => 'enmr',
        uid_range     => '71101-71150',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/enmr.eu/ROLE=production' => {
        ensure        => 'present',
        group         => 'enmrprd',
        gid           => '71003',
        vo_group      => 'enmr',
        uid_range     => '71151-71200',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/enmr.eu/ROLE=pilot'      => {
        ensure        => 'present',
        group         => 'enmrpil',
        gid           => '71004',
        vo_group      => 'enmr',
        uid_range     => '71201-71250',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/vo.france-asia.org'  => {
        ensure => 'present',
        group         => 'vfa',
        gid           => '71251',
        vo_group      => 'vfa',
        uid_range     => '71251-71300',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/vo.france-asia.org/ROLE=lcgadmin' => {
        ensure        => 'present',
        group         => 'vfasgm',
        gid           => '71252',
        vo_group      => 'vfa',
        uid_range     => '71301-71350',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/vo.france-asia.org/ROLE=production' => {
        ensure        => 'present',
        group         => 'vfaprd',
        gid           => '71253',
        vo_group      => 'vfa',
        uid_range     => '71351-71400',
        users_num     => 50,
        comment       => 'grid user'
      },
      '/vo.france-asia.org/ROLE=pilot'      => {
        ensure        => 'present',
        group         => 'vfapil',
        gid           => '71254',
        vo_group      => 'vfa',
        uid_range     => '71401-71450',
        users_num     => 50,
        comment       => 'grid user'
      },
    }
  }
}
