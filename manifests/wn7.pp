class emiconfig::wn7 {
 
  $wn_pkgs=[
      "wn",
      "ca-policy-egi-core",
      "HEP_OSlibs",
      "mjf-torque",
      "singularity-runtime",
      "singularity"
  ]
  package{ $wn_pkgs:
    ensure     => "installed",
    require    => Yumrepo['site'],
  }
  file {"/scratch":
    ensure   => "directory",
    owner    => "root",
    group    => "root",
    mode     => '1777'
  }

  #file {'/etc/machinefeatures':
  #  ensure     => directory,
  #  owner      => 'root',
  #  group      => 'root',
  #  mode       => '0644',
  #} ->
  #file {'/etc/jobfeatures':
  #  ensure     => directory,
  #  owner      => 'root',
  #  group      => 'root',
  #  mode       => '0644',
  #}

}
