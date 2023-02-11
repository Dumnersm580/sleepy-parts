Nerdy Parts
============

Nerdy Parts is a web-based system for tracking parts through the design and manufacture cycle. It assigns part numbers with which CAD files can be saved to version control and stores information about parts' current manufacturing status.

Nerdy Parts is written in Ruby using the [Sinatra](http://sinatrarb.com) framework and uses MySQL as the backing datastore. Development and production are run on UNIX (OS X and Ubuntu), so there are no guarantees it'll work on Windows, sorry.

Nerdy Parts is forked from [Cheesy Parts by Team254](https://github.com/Team254/cheesy-parts).

## Development

Prerequisites:

* Ubuntu (production = Ubuntu 18.04.01 LTS)
* Ruby 2.3 (production = ruby 2.3.0p0 (2015-12-25 revision 53290))
* [Bundler](http://gembundler.com)
* MySQL

To run Nerdy Parts locally:
1. Install RVM (https://github.com/rvm/ubuntu_rvm)
1. Install Ruby `rvm install ruby-2.3.0`
1. Install MySQL
    1. `sudo apt install mysql-server libmysqlclient-dev`
    1. `mysql --version`
    1. `sudo /etc/init.d/mysql start`
    1. `sudo mysql_secure_installation`
1. Create empty MySQL database and user account with full permissions on it.
    1. `sudo mysql`
    1. `CREATE DATABASE IF NOT EXISTS nerdy_parts;`
    1. `CREATE USER ‘team2337’@’localhost’ IDENTIFIED BY ‘correcthorsebatterystaple’;`
    1. `GRANT ALL ON nerdy_parts.* TO 'team2337'@'localhost';`
1. Populate `config.json` with the parameters for the development and production environments. Set `enable_wordpress_auth` to false and `members_url` to blank; they are used for a single sign-on (SSO) mechanism specific to Team 254.
1. Run `bundle install`. This will download and install the gems that Nerdy Parts depends on.
1. Run `bundle exec rake db:migrate`. This will run the database migrations to create the necessary tables in MySQL.
1. Run `ruby parts_server_control.rb <command>` to control the running of the Nerdy Parts server, where `<command>` can be one of `start`|`stop`|`run`|`restart`.

The database migration will create an admin account (username "deleteme@team254.com", password "chezypofs") that you can use to first get into the system and create other accounts. It is highly recommended that you delete this account after having created your own admin account.

## Deployment

Nerdy Parts deploys by checking out from Git on the production server. If you don't plan on making any changes, you can simply put a copy of the code on your server and edit the config in place. If you do plan on making periodic changes to the code, you can follow this procedure:

1. Fork nerdy-parts on Github, make your initial code/config changes, and commit them.
1. On the production server, clone your fork and start it up the first time.
1. Fill in your server-specific information in the `deploy` script.
1. Make any incremental changes in your development machine, test them locally, commit and push them, then run the `deploy` script.

The deploy script uses SSH to log into the production server, discard any local changes in the checked-out version of Nerdy Parts, pull from the origin, and restart the server.

## Contributing

If you have a suggestion for a new feature, create an issue on GitHub or shoot an e-mail to [rhys.barrie@gmail.com](mailto:rhys.barrie@gmail.com). Or if you have some Ruby-fu and are feeling adventurous, fork this project and send a pull request.
