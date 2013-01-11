class rubyenv {

  package {
  "rbenv":
  ensure => present
  }

  file { "/home/deploy":
  ensure => 'directory',
  owner => "deploy",
  group => "deploy",
  mode => '700',
  require => User["deploy"],
  }

  rbenv::install { 'deploy':
  home => '/home/deploy',
  require => User['deploy'],
  }

  rbenv::compile { '1.9.3-p286':
  ruby => '1.9.3-p286',
  user => 'deploy',
  global => true,
  require => Rbenv::Install['deploy'],
  }

  rbenv::plugin { "rbenv-bundler":
  user => 'deploy',
  home => '/home/deploy',
  source => 'git://github.com/carsomyr/rbenv-bundler.git',
  require => Rbenv::Install['deploy'],
  }

  rbenv::gem {
  "rbenv::rake deploy 1.9.3-p286":
  user    => 'deploy',
  ruby    => '1.9.3-p286',
  gem     => 'rake',
  alias   => "install_rake",
  require => Rbenv::Install['deploy'],
  }

  rbenv::gem {
  "rbenv::rack deploy 1.9.3-p286":
  user    => 'deploy',
  ruby    => '1.9.3-p286',
  gem     => 'rack',
  alias   => "install_rack",
  require => Rbenv::Install['deploy'],
  }

  file {
  "/home/deploy/.rbenv/global":
  ensure => 'present',
  owner => 'deploy',
  group => 'deploy',
  mode => '664',
  source => "puppet:///modules/rubyenv/global",
  require => Rbenv::Install['deploy'],
  }

  file { '/home/deploy/.bash_profile':
    ensure => 'present',
    owner => 'deploy',
    group => 'deploy',
    mode => '600',
    source => "puppet:///modules/rubyenv/.bash_profile",
    require => Rbenv::Install['deploy'],
  }
}