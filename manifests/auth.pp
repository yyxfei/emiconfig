class emiconfig::auth {
  file{ "/root/.ssh/authorized_keys":
    mode         =>  '400',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/authorized_keys",
    require      =>  File['/root/.ssh']
  }
  file{ "/root/.ssh":
    ensure       =>  "directory",
    mode         =>  '700',
    owner        =>  'root',
    group        =>  'root',
  }
}
