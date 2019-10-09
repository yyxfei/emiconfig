class emiconfig::ui {
  $ui_pkgs=[
      "ui",
      "ca-policy-egi-core",
      "HEP_OSlibs",
  ]
  package{ $ui_pkgs:
    ensure  => "installed",
    require => Yumrepo['site'],
  }
}
