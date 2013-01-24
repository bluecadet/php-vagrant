class other 
{
    $packages = [
        "curl", 
        "git",
        "libicu44",
    ]
    
    package 
    { 
        $packages:
            ensure  => latest,
            require => Exec['apt-get update']
    }
}
