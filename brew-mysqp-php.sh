#!/bin/bash

# http://www.createdbypete.com/articles/php-54-development-on-os-x-with-mysql-and-laravel-4/

# install command line tools
# xcode-select --install

# install homegrew
# ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

# Check every is configured properly
# brew doctor
brew update

#instal mysql
brew install mysql

# Add MySQL to launchctl to let OS X manage the process and start when you login
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

# Or if you want to control it yourself
mysql.server start
# Usage: mysql.server {start|stop|restart|reload|force-reload|status}

# "Secure" your MySQL installation, really it's just a handy way to clean up defaults and set a root password
mysql_secure_installation

# Install PHP 5.4 and Composer
# brew search php54

brew tap josegonzalez/php

brew tap homebrew/dupes
brew install php54 php54-xdebug

cat << EOF | tee -a /usr/local/etc/php/5.4/conf.d/ext-xdebug.ini
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

brew install php54-mcrypt






# brew install composer
