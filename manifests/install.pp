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

  file {$perlbrew::perlbrew_root:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  
  http_proxy_string = ''
  curl_http_proxy_string = ''
  #build <[protocol://][user:password@]proxyhost[:port]>, prepends -x for curl too
  if($perlbrew::http_proxy&&$perlbrew::http_proxy_url) {
    #TODO: ensure url is valid url?
    #append username and password to proxy string
    if($perlbrew::http_proxy_username) {
      if($perlbrew::http_proxy_password) {
        http_proxy_string += $perlbrew::http_proxy_username +':'+$perlbrew::http_proxy_password + '@'
      }
      else { http_proxy_string += $perlbrew::http_proxy_username + '@' }
    }
    http_proxy_string += $perlbrew::http_proxy_url
    #TODO: curl -x http://proxy_server:proxy_port --proxy-user username:password -L http://url might be better supported
    if($perlbrew::http_proxy_port) { http_proxy_string += ':'+$perlbrew::http_proxy_port }
    curl_http_proxy_string = ' -x '+http_proxy_string 
  }
  
  exec {'install_perlbrew':
    environment => 'PERLBREW_ROOT=/opt/perl5',
    command     => '/usr/bin/curl'+curl_http_proxy_string+' -L http://install.perlbrew.pl | /bin/bash',
    creates     => "${perlbrew::perlbrew_root}/bin/perlbrew",
    require     => Package['curl'],
  }

}
