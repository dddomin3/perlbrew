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
  
  $http_proxy          = $perlbrew::params::http_proxy,
  $http_proxy_url      = $perlbrew::params::http_proxy_url,
  $http_proxy_username = $perlbrew::params::http_proxy_username,
  $http_proxy_password = $perlbrew::params::http_proxy_password,
  $http_proxy_port     = $perlbrew::params::http_proxy_port,


) inherits perlbrew::params {

  # param validation

  class { 'perlbrew::install': } ->
  class { 'perlbrew::config': }
  
}
