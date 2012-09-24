class apache($hostname = "localhost", $sitepath = "/var/www") {

	include apache::params

	package { 'apache2' :
		ensure => installed
	}

	package { 'apache2.2-common' :
		ensure => installed,
		require => Package['apache2']
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

	exec{"activate mod rewrite":
		command => "a2enmod rewrite",
		require => Package['apache2.2-common'],
		notify  => Service["apache2"],
	}

}
