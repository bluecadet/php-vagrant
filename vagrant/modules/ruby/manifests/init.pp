class ruby {
    # Ensure we have ruby
    package { 'ruby':
        ensure => latest,
        require => Exec['apt-get update']
    }

    # Ensure we can install gems
    package { 'rubygems':
        ensure => 'latest'
    }

    # Install gems
    package { 'compass':
        provider => 'gem',
        ensure => 'latest'
    }
    
    package { 'chunky_png':
        provider => 'gem',
        ensure => 'latest',
    }
    
    package { 'sass-globbing':
        provider => 'gem',
        ensure => 'latest'
    }
}