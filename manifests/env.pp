class emiconfig::env {

  file{"/etc/profile.d/grid.sh":
    mode         =>  '0755',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/grid.sh",
  }
  file{"/etc/profile.d/grid.csh":
    mode         =>  '0755',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/grid.csh",
  }
}
