## Requirements

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](https://www.vagrantup.com)
* [Git](http://git-scm.com/downloads)

## VM Specifications

* OS     - Ubuntu 12.04
* Apache - 2.2.22
* PHP    - 5.4.9
* MySQL  - 5.5.28

## Project Architecture
```
Root
 -- vagrant/
 -- web/
```

 * `vagrant/` contains this repository which is the VM configuration
 * `web/`     Project root and Apache DocumentRoot. The server will point here.

## How to Use

* Go to your project root directory
* Clone this repository into vagrant/ directory with `git clone git@github.com:bluecadet/php-vagrant.git vagrant/`. 
This will create a sub directory for Vagrant that is ignored by your project's repository. Alternatively you could 
include a reference to this repository by including it as a submodule,
`git submodule add git@github.com:bluecadet/php-vagrant.git vagrant/`.

* Go to vagrant directory (with `cd vagrant`) and start the VM with `vagrant up` (first start can download the Ubuntu box and can take some time to be ready)
* Access your web project from [http://11.11.11.11/](http://11.11.11.11/) in your browser (you can add your specific host to your local `/etc/hosts`)
