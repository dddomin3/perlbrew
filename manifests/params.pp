# == Class: perlbrew::params
#
# This class includes the default parameters for the Perlbrew class.
#
# === Parameters
#
# Document parameters here.
#
# [*perlbrew_root*]
#   Specify the root of your perlbew installation. Defaults to '/opt/perl5'.
#
class perlbrew::params {

  case $::osfamily {
    'RedHat': {
      $perlbrew_root      = '/opt/perl5'
      $perlbrew_init_file = '/etc/profile.d/perlbrew.sh'
      
      $http_proxy          = false
      $http_proxy_url      = ''
      $http_proxy_username = ''
      $http_proxy_password = ''
      $http_proxy_port     = ''
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

}
