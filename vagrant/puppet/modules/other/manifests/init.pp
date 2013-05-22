class other 
{
    $packages = [
        'build-essential',
        'curl', 
        'git', 
        'htop',
        'libicu-dev',
        'python-software-properties'
    ]
    
    package 
    { 
        $packages:
            ensure  => latest,
            require => Exec['apt-get update']
    }
}
