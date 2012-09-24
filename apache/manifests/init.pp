class apache($hostname = "localhost", $sitepath = "/var/www") {

	include apache::params

	package { 'apache2' :
		ensure => installed
	}

	service {'apache2' :
		enable    => true,
		ensure    => running,
		subscribe => [Package['apache2']]
	}

	file {"default virtualhost":
		path    => "${apache::params::conf}/sites-available/default",
		ensure  => present,
		content => template("apache/vhost.erb"),
		require => Package["apache2"],
		notify  => Service["apache2"],
		mode    => 644,
	}

}
