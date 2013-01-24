class other 
{
    $packages = [
        "curl", 
        "git",
        "libicu-dev",
    ]
    
    package 
    { 
        $packages:
            ensure  => latest,
            require => Exec['apt-get update']
    }
}
