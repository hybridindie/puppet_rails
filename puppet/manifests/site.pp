Exec {
  path => "/usr/bin:/usr/local/bin:/bin"
}
# Message Of The Day
file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine! Managed by Puppet.\n",
  group => 0,
  owner   => 0,
  mode => 644,
}

# Issue an apt-get udpate
Package {
  require => Exec["apt-get update"]
}
if ! defined(Exec["apt-get update"]) {
  exec { "apt-get update":
    path => "/usr/bin:/bin/:/sbin/:/usr/sbin"
  }
}

package {['imagemagick'] : ensure => "installed",}

group {"puppet":
  ensure => "present",
}

user { "puppet":
  ensure => "present",
  gid => "puppet",
  managehome => false,
  require => Group["puppet"],
}

group { "deploy":
  ensure => 'present',
}

user { "deploy":
  ensure => 'present',
  gid => "deploy",
  managehome => true,
  shell => '/bin/bash',
  home => "/home/deploy",
  # Generate the password with openssl passwd -1
  # B!gW@ll$
  password => "$1$PA14Q5bC$sSA7lCyO6KDXTrR3Mvsk1/",
  require => Group["deploy"],
}

include ssh
include curl
include htop
include rubyenv
include nginx
#include memcached
#include base_app
include mysql
include nodejs
include unicorn
#include nagios::client
#include ganglia::client
