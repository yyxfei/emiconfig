class emiconfig::ace {
  # pre config
  # ntp, yum repos, grid CA certificate
  $ace_pkgs=[
    "nordugrid-arc-compute-element",
    "nordugrid-arc-client",
    "nordugrid-arc-doc",
    "nordugrid-arc-devel"
  ]
  package{ $ace_pkgs:
    ensure  => "installed",
    require => Yumrepo['site'],
  } 
}
