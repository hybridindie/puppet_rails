class ssh {
  package {
    "ssh":
      ensure => present,
      before => File["/etc/ssh/sshd_config"],
  }
  file {
    "/etc/ssh/sshd_config":
      owner   => root,
      group   => root,
      mode    => 644,
      source  => "puppet:///modules/ssh/sshd_config"
  }
  file {
    ["/home/deploy/.ssh"]:
      ensure  => directory,
      owner   => deploy,
      group   => deploy,
      mode    => 700,
  }
  file {
    "/home/deploy/.ssh/authorized_keys":
      owner => deploy,
      group => deploy,
      mode => 544,
      source  => "puppet:///modules/ssh/authorized_keys"
  }
  file {
    "/home/deploy/.ssh/known_hosts":
      owner => deploy,
      group => deploy,
      mode => 544,
      source  => "puppet:///modules/ssh/known_hosts"
  }
  file {
    "/home/deploy/.ssh/config":
      owner => deploy,
      group => deploy,
      mode => 544,
      source  => "puppet:///modules/ssh/config"
  }
  service {
    "ssh":
      ensure    => true,
      enable    => true,
      subscribe => File["/etc/ssh/sshd_config"]
  }
}

