class ruby {
    # Ensure we have ruby
    package { "ruby1.9.3":
        ensure => latest,
        require => Exec['apt-get update']
    }

    # Update gems
    exec { "gem update":
        command => "gem update",
        require => Package['ruby1.9.3'],
    }

    # Install some useful gems
    exec { "gem.capistrano":
        command => "gem install capistrano",
        unless => "gem list | grep capistrano 2>/dev/null",
        require => Package['ruby1.9.3']
    }

    exec { "gem.chunky_png":
        command => "gem install chunky_png",
        unless => "gem list | grep chunky_png 2>/dev/null",
        require => Package['ruby1.9.3']
    }

    exec { "gem.compass":
        command => "gem install compass",
        unless => "gem list | grep compass 2>/dev/null",
        require => Package['ruby1.9.3']
    }
}