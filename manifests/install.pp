# == Class: perlbrew::install
#
# This class installs Perlbrew and is meant to be called from perlbrew
#
class perlbrew::install {

  if !defined(Package['curl']) {
    package {'curl':
      ensure => present,
    }
  }

  file { $perlbrew::perlbrew_root:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  
  $curl_http_proxy_string = ''
  if($perlbrew::http_proxy) {
    $curl_http_proxy_string = "-x ${perlbrew::http_proxy}"
  }
  
  exec {'install_perlbrew':
    environment => 'PERLBREW_ROOT=/opt/perl5',
    command     => "/usr/bin/curl ${curl_http_proxy_string} -L http://install.perlbrew.pl | /bin/bash",
    creates     => "${perlbrew::perlbrew_root}/bin/perlbrew",
    require     => Package['curl'],
  }

}
