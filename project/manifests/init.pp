class project(
				$domainname,
				$host = 'www.project.dev',

				$dbname = 'socialnetwork',
				$dbuser = 'socialnetwork',
				$dbpass = 'socialnetwork_user',

				$sitepath = "/vagrant/src/www",

				$phpmyadmin = true,
	){

	class{"project::setup":
		domainname => $domainname,
		hostname => $host,
		sitepath => $sitepath,
	}

	class{"project::sql":
		dbname => $dbname,
		dbuser => $dbuser,
		dbpass => $dbpass,
	}

	class{"project::web":
		phpmyadmin => $phpmyadmin,
	}

}
