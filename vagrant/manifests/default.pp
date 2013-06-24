
exec { 'apt-get update':
  command => 'apt-get update',
  path    => '/usr/bin/',
  timeout => 60,
  tries   => 3,
}

class { 'apt':
  always_apt_update => true,
}

package { ['python-software-properties']:
  ensure  => 'installed',
  require => Exec['apt-get update'],
}

file { '/home/vagrant/.bash_aliases':
  ensure => 'present',
  source => 'puppet:///modules/puphpet/dot/.bash_aliases',
}

package { ['build-essential', 'vim', 'curl', 'git', 'htop', 'libicu-dev', 'redis-server']:
  ensure  => 'installed',
  require => Exec['apt-get update'],
}

class { 'apache': }

apache::dotconf { 'custom':
  content => 'EnableSendfile Off',
}

apache::module { 'rewrite': }

apache::vhost { 'dev.bluecadet.com':
  server_name   => 'dev.bluecadet.com',
  serveraliases => ['dev.bluecadet.com'],
  docroot       => '/var/www/web/',
  port          => '80',
  env_variables => [],
  priority      => '1',
}

apache::vhost { 'xhprof.bluecadet.com':
  server_name   => 'xhprof.bluecadet.com',
  serveraliases => ['xhprof.bluecadet.com'],
  docroot       => '/var/www/xhprof/',
  port          => '80',
  env_variables => [],
  priority      => '1',
}

apt::ppa { 'ppa:ondrej/php5':
  before  => Class['php'],
}

class { 'php':
  service => 'apache',
  require => Package['apache'],
}

php::module { 'php5-mysql': }
php::module { 'php5-cli': }
php::module { 'php5-curl': }
php::module { 'php5-gd': }
php::module { 'php5-intl': }
php::module { 'php5-mcrypt': }
php::module { 'php5-xsl': }
php::module { 'php-apc': }
php::module { 'php-codesniffer': }

class { 'php::devel':
  require => Class['php'],
}

class { 'php::pear':
  require => Class['php'],
}


php::pecl::module { 'APC':
  use_package => false,
}
php::pecl::module { 'PDO_MYSQL':
  use_package => false,
}
php::pecl::module { 'zip':
  use_package => false,
}

class { 'xdebug':
  service => 'apache',
}

xdebug::config { 'cgi':
  remote_autostart => '1',
  remote_port      => '9000',
}
xdebug::config { 'cli':
  remote_autostart => '1',
  remote_port      => '9000',
}

php::pecl::module { 'xhprof':
  use_package => false,
}

apache::vhost { 'xhprof':
  server_name => 'xhprof',
  docroot     => '/var/www/xhprof/xhprof_html',
  port        => 80,
  priority    => '1',
  require     => Php::Pecl::Module['xhprof']
}


class { 'php::composer': }

php::ini { 'php':
  value   => ['date.timezone = "America/New_York"'],
  target  => 'php.ini',
  service => 'apache',
}
php::ini { 'custom':
  value   => ['display_errors = On', 'error_reporting = -1', 'short_open_tag = Off', 'session.auto_start = Off', 'session.save_handler = files', 'upload_max_filesize = "10M"', 'post_max_size = "20M"', 'xdebug.max_nesting_level = "250"'],
  target  => 'custom.ini',
  service => 'apache',
}

class { 'mysql':
  root_password => 'root',
}

mysql::grant { 'symfony':
  mysql_privileges     => 'ALL',
  mysql_db             => 'symfony',
  mysql_user           => 'symfony',
  mysql_password       => 'symfony',
  mysql_host           => '127.0.0.1',
  mysql_grant_filepath => '/home/vagrant/puppet-mysql',
}

class { 'ruby': }

class { 'java': }