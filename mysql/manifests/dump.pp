class mysql::dump($dbuser = "user", $dbpass = "secret", $dbname = 'test'){


	file{"/vagrant/db_snapshot":
		ensure => directory
	}

	exec { 'import-db':
		onlyif => "test -e /vagrant/db_snapshot/${dbname}_dev.sql",
		command => "/usr/bin/mysql ${dbname} < /vagrant/db_snapshot/${dbname}_dev.sql",
		require => Exec["create-db"],
	}



	file{"dump-before-shutdown":
		path => "/etc/rc0.d/K01sqldump",
		content => template("mysql/before-shutdown.sh.erb"),
		mode => 0744,
		owner => root,
		group => root,
		ensure => present
	}

	file{"dump-before-reboot":
		path => "/etc/rc6.d/K01sqldump",
		content => template("mysql/before-shutdown.sh.erb"),
		mode => 0744,
		owner => root,
		group => root,
		ensure => present
	}
}
