class emiconfig::apel {

  $apelpkg = [
  "ca-policy-egi-core",
  "apel-lib",
  "apel-ssm",
  "apel-client",
  ]

  package {$apelpkg:
    ensure =>  installed,
    require => Yumrepo['site'],
  }
}
