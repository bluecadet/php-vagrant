class nodejs {

    exec { 
        'node-repo':
            command => '/usr/bin/add-apt-repository ppa:chris-lea/node.js',
            creates => '/etc/apt/sources.list.d/chris-lea-node.js-precise.list',
            require => Package['python-software-properties'] 
    }

    exec { 
        'libpgm-repo':
            command => '/usr/bin/add-apt-repository ppa:chris-lea/libpgm',
            creates => '/etc/apt/sources.list.d/chris-lea-libpgm-precise.list',
            require => Package['python-software-properties'] 
    }

    $required_execs = [ 'node-repo', 'libpgm-repo' ]

    exec { 
        'node-apt-ready':
            command => '/usr/bin/apt-get update',
            require => Exec[$required_execs],
            onlyif => '/usr/bin/test ! -x /usr/bin/node'
    }

    package { 
        ['nodejs', 'nodejs-dev', 'npm']:
            require => Exec['node-apt-ready']
    }

    # Once npm and node.js are installed, install packages

    # Handlebars
    exec {
        'handlebars-global':
            command => '/usr/bin/npm install -g handlebars',
            require => Package['npm'],
            onlyif => '/usr/bin/test ! -x /usr/bin/handlebars'
    }

    # For testing
    exec { 
        'mocha-global':
            command => '/usr/bin/npm install -g mocha',
            require => Package['npm'],
            onlyif => '/usr/bin/test ! -x /usr/bin/mocha'
    }
}