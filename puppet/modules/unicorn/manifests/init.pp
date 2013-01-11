class unicorn::install {
  rbenv::gem {"rbenv::unicorn deploy 1.9.3-p286":
    user   => 'deploy',
    ruby   => '1.9.3-p286',
    gem    => 'unicorn',
  }
}

class unicorn::files {
  file {
    "/etc/init.d/unicorn":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/unicorn/unicorn"
  }
}

class unicorn::service {
  service { "unicorn":
    ensure     => running,
    enable     => true,
    hasrestart => true,
  }
}


class unicorn {
  include unicorn::install
}