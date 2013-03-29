class nodejs
{
    exec { "install node deps":
        command => "/usr/bin/add-apt-repository ppa:chris-lea/node.js && apt-get update",
    }
    package { "nodejs":
        ensure => installed,
        require => Exec['install node deps'],
    }
    package { "npm":
        ensure => installed,
        require => Exec['install node deps'],
    }

    exec { "install handlebars":
        command => "/usr/bin/npm install -g handlebars",
        require => Package['npm'],
    }
}