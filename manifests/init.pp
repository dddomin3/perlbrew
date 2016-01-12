# == Class: perlbrew
#
# This class installs and configures perlbrew.
# It does not install any versions of Perl by default.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class perlbrew (

  $perlbrew_root      = $perlbrew::params::perlbrew_root,
  $perlbrew_init_file = $perlbrew::params::perlbrew_init_file,
  $http_proxy         = $perlbrew::params::http_proxy,
  
) inherits perlbrew::params {

  # param validation
  
  if $http_proxy {
    $http_proxy_envstring  = "http_proxy=${perlbrew::http_proxy}"
    $https_proxy_envstring = "https_proxy=${perlbrew::http_proxy}"
  }
  
  class { 'perlbrew::install': } ->
  class { 'perlbrew::config': }
  
}
