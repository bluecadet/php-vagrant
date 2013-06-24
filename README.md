## Requirements

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](https://www.vagrantup.com)
* [Git](http://git-scm.com/downloads)

## VM Specifications

* Ubuntu
* Apache
* PHP
* MySQL

## Project Architecture
```
Root
 -- vagrant/
 -- www/
```

 * `vagrant/` contains the vagrant vm
 * `www/`     Project root and Apache DocumentRoot. The server points here.

## How to Use

* Go to your project root directory
* Clone this repository into vagrant/ directory with `git clone git@github.com:bluecadet/php-vagrant.git vagrant/`. 
This will create a sub directory for Vagrant that is ignored by your project's repository. Alternatively you could 
include a reference to this repository by including it as a submodule,
`git submodule add git@github.com:bluecadet/php-vagrant.git vagrant/`.

* Go to vagrant directory (with `cd vagrant`) and start the VM with `vagrant up` (first start can download the Ubuntu box and can take some time to be ready)
* Access your web project from [http://11.11.11.11/](http://11.11.11.11/) in your browser (you can add your specific host to your local `/etc/hosts`)
* You can modify the virual host at line 36 of `vagrant/manifests/default.pp`. See the default implementation below.

```puppet
apache::vhost { 'dev.bluecadet.com':
  server_name   => 'dev.bluecadet.com',
  serveraliases => ['dev.bluecadet.com'],
  docroot       => '/var/www/web/',
  port          => '80',
  env_variables => [],
  priority      => '1',
}
```