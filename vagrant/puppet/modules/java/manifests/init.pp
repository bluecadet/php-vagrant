class java
{
    package
    {
        "openjdk-7-jre":
            ensure => latest,
            require => Exec['apt-get update']
    }
}