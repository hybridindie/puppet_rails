class base_app {
  file {
    ["/home/deploy/nginx/",
     "/home/deploy/nginx/shared/",
     "/home/deploy/nginx/shared/config/"]:
      ensure => directory,
      owner  => deploy,
      group  => deploy,
      mode   => 775
  }
  file {
    "/home/deploy/nginx/shared/config/unicorn.conf.rb":
      ensure  => present,
      owner   => deploy,
      group   => deploy,
      mode    => 600,
      source  => "puppet:///modules/unicorn/unicorn.conf.rb"
  }
  package {
    "bundler":
      provider => gem
  }
}
