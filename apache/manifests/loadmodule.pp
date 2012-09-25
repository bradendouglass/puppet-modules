class apache::loadmodule () {

	package { 'apache2.2-common' :
		ensure => installed,
		require => Package['apache2']
	}

    exec { "/usr/sbin/a2enmod $name" :
		unless => "/bin/readlink -e /etc/apache2/mods-enabled/${name}.load",
		require => Package['apache2.2-common'],
		notify => Service["apache2"]
    }
}
