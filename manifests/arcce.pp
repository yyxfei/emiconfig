class emiconfig::arcce {
  file { "/opt/exp_soft":
    ensure   => link,
    target   => "/ihepbatch/exp_soft",
    force    => true,
  }
}
