class ganglia::server {

  package {
    ["ganglia-monitor", "ganglia-webfrontend","gmetad"]:
      ensure  => installed,
      before  => File["/etc/apache2/conf.d/ganglia.conf"]
  }

  file {
    "/etc/ganglia-webfrontend/apache.conf":
      source  => "puppet:///modules/ganglia/apache.conf",
      owner   => root,
      group   => root,
      mode    => 644,
      notify  => Service["apache2"];
    "/etc/apache2/conf.d/ganglia.conf":
      ensure  => link,
      target  => "/etc/ganglia-webfrontend/apache.conf",
      require => File["/etc/ganglia-webfrontend/apache.conf"],
      notify  => Service["apache2"];
    "/etc/ganglia/gmond.conf":
      source  => "puppet:///modules/ganglia/gmond_server.conf",
      owner   => root,
      group   => root,
      mode    => 644,
      notify  => Service["ganglia-monitor"],
      require => Package["ganglia-monitor"];
    "/etc/ganglia/gmetad.conf":
      source  => "puppet:///modules/ganglia/gmetad.conf",
      owner   => root,
      group   => root,
      mode    => 644,
      notify  => Service["gmetad"],
      require => Package["gmetad"];
    "/etc/ganglia/gmetric":
      ensure  => directory,
      owner   => root,
      group   => root;
    "/etc/ganglia/gmetric/ganglia_mysql_stats.pl":
      source  => "puppet:///modules/ganglia/gmetric/ganglia_mysql_stats.pl",
      owner   => root,
      group   => root,
      mode    => 755,
      require => File["/etc/ganglia/gmetric"];
    "/etc/ganglia/gmetric/gmetric_accounts.rb":
      source  => "puppet:///modules/ganglia/gmetric/gmetric_accounts.rb",
      owner   => root,
      group   => root,
      mode    => 755,
      require => File["/etc/ganglia/gmetric"]
  }

  cron {
    "ganglia_mysql_stats":
      user    => vagrant,
      minute  => "*",
      command => "/etc/ganglia/gmetric/ganglia_mysql_stats.pl",
      require => File["/etc/ganglia/gmetric/ganglia_mysql_stats.pl"];
    "gmetric_accounts":
      user    => vagrant,
      minute  => "*",
      command => "/etc/ganglia/gmetric/gmetric_accounts.rb",
      require => File["/etc/ganglia/gmetric/gmetric_accounts.rb"]
  }

  service {
    ["ganglia-monitor", "gmetad"]:
      hasrestart => true
  }

}
