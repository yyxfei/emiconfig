class emiconfig::env {

  file{"/etc/profile.d/local_env.sh":
    mode         =>  '755',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/local_env.sh",
  }
  file{"/etc/profile.d/local_env.csh":
    mode         =>  '755',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/local_env.csh",
  }
}
