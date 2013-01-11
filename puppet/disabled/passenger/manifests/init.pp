class passenger {

  package {
    "apache2-prefork-dev":
      ensure => present;
    "libcurl4-openssl-dev":
      ensure => present;
  }

  rbenv::gem {
    "rbenv::passenger deploy 1.9.3-p194":
      user    => 'deploy',
      ruby    => '1.9.3-p194',
      gem     => 'passenger',
      alias   => "install_passenger",
      require => [Package["apache2"],Package["apache2-prefork-dev"]],
      before  => [File["passenger_conf"],Exec["passenger_apache_module"]]
  }

  exec {
  "/home/deploy/.rbenv/versions/1.9.3-p194/lib/ruby/gems/1.9.1/gems/passenger-3.0.17/bin/passenger-install-apache2-module --auto":
    user    => root,
    group   => root,
    path    => "/bin:/usr/bin:/usr/local/apache2/bin/",
    alias   => "passenger_apache_module",
    before  => File["passenger_conf"],
    unless  => "ls /home/deploy/.rbenv/versions/1.9.3-p194/lib/ruby/gems/1.9.1/gems/passenger-3.0.17/ext/apache2/mod_passenger.so"
  }

  file {
    "/etc/apache2/conf.d/passenger.conf":
      mode    => 644,
      owner   => root,
      group   => root,
      alias   => "passenger_conf",
      notify  => Service["apache2"],
      source  => "puppet:///modules/passenger/passenger.conf"
  }
}

