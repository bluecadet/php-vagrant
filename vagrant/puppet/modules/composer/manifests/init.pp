class composer 
{
    $tmpDir     = '/home/vagrant'
    $tmp        = '/home/vagrant/composer.phar'
    $targetDir  = '/usr/local/bin'
    $target     = '/usr/local/bin/composer'
    
    package 
    { 
        "composer":
            ensure  => present,
            require => Package["php5-cli", "curl"]
    }
    
    exec
    {
        "download_composer":
            command => 'curl -s http://getcomposer.org/installer | php',
            cwd     => "$tmpDir",
            require => Package["php5-cli", "curl"],
            creates => "$tmp",
    }
    
    file
    {
        "$target":
            ensure  => present,
            source  => "$tmp",
            require => Exec['download_composer'],
            group   => 'staff',
            mode    => '0755',
    }
    
    exec {
        'update_composer':
            command => "$target self-update",
            require => File["$target"]
    }
}