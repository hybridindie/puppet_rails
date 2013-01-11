class nginx::install {
  package { "nginx":
    ensure => 'present',
  }
}

class nginx::files {
  file {
    "/etc/nginx/nginx.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/nginx/nginx.conf"
  }
}

# TODO: add configuration files
class nginx::service {
  service { "nginx":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => Package["nginx"],
  }
}

class nginx {
  include nginx::install, nginx::files, nginx::service
}