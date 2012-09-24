class project::sql(
					$dbuser = "puppet",
					$dbpass = "puppet_user",
					$dbname = "puppet",
	) {

	class { "mysql::create":
		dbuser => $dbuser,
		dbpass => $dbpass,
		dbname => $dbname
	}

	class {"mysql::dump":
		dbuser => $dbuser,
		dbpass => $dbpass,
		dbname => $dbname
	}

}
