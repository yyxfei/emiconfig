class emiconfig::jce {
  file{ "/usr/java/latest/jre/lib/security/local_policy.jar":
    mode         =>  '644',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/local_policy.jar",
  }
  file{ "/usr/java/latest/jre/lib/security/US_export_policy.jar":
    mode         =>  '644',
    owner        =>  'root',
    group        =>  'root',
    source       =>  "puppet:///modules/emiconfig/US_export_policy.jar",
  }
}
