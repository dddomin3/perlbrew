# == Class: perlbrew::cpan::install
#
# run cpan command to install modules using a cpanfile.
#
# === Parameters
#
# [*options*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Examples
#
#  class { perlbrew::cpan::install
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
class perlbrew::cpan::install (

  $cpanfile_name = 'cpanfile',
  $cpanfile_dir  = '/tmp',
  $options       = [],

) {

  include perlbrew::perl

  $default_options = [
    '--installdeps',
  ]

  $merged_options = concat($default_options, $options)
  $install_opts = join($merged_options, ' ')

  concat {"${cpanfile_dir}/${cpanfile_name}":
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  $cpan_command = "${perlbrew::perlbrew_root}/perls/perl-${perlbrew::perl::version}/bin/cpanm ${install_opts} ${cpanfile_dir}"

  exec {'install_perl_modules':
    environment => [
      $perlbrew::http_proxy_envstring,
      $perlbrew::https_proxy_envstring,
    ],
    command     => $cpan_command,
    subscribe   => Concat["${cpanfile_dir}/${cpanfile_name}"],
    refreshonly => true,
    timeout     => 0,
  }

}
