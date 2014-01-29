#!/bin/bash
# Current Version 0.0.9

# dont forget to create write permissions on this file

# 2013-12-20: 0.0.9
# - refactored .bowerrc to store in 'lib' instead of components

# 2013-12-16: 0.0.8
# - Updated Gruntfile.js and .jshint gist referece
# - Added lodash install

# 2013-12-15: 0.0.7
# - Added basic .jshintrc file to support jsHint service from Sublime Plugin
# - Updated Gruntfile.js and Package.json for refactored grunt workflow

# 2013-12-14: 0.0.6
# - Updated to work with release version of Laravel 4.1.x (bootstrap/start.php)
# - Updated version of Way/Generators to use 1.1.* instead of dev-master to fix errors with Laravel 4.1 release
# - Updated to use semver versioning
# - Removed clockwork (go head and bring that in if you want to separately)

# 2013-12-08: 0.0.5
# - Added application Todo file($appname.todo)

# 2013-12-08: 0.0.4
# - Added key:generate call (app.php)
# - Added ctags call
# - Added setting timezone (app.php)
# - Added update database password (database.php)
# - Added .bowerrc file (stored public/components)
# - Added bower install bootstrap (pulls in jquery as depedency)
# - Added support for supplying appname as paramater to script

# 2013-12-06: 0.0.3
# - Refactored to use new laravel.phar command, replacing call to composer create-project

# 2013-12-04: 0.0.2
# - Added Faker package
# - Updated to use Laravel 4.1
# - Removed initial question about setting up new Laravel app, why else call the script
# - Add colors ;-)

# 2013-11-28: 0.0.1
# - Initial Release
# - Make sure gsed is installed if using OSX (install via Homebrew)
#   $ brew install gnu-sed


# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_LIGHTGREEN=$ESC_SEQ"92;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"
COL_PURPLE=$ESC_SEQ"35;01m"
YN_PROMPT=$COL_RESET"["$COL_YELLOW"Y,n"$COL_RESET"]?"
appname=''

# Get appname if supplied as parameter
appname=$1

# Intial Setup
echo -e "\n$COL_PURPLE Configuring New Laravel 4.1 Application...\n$COL_RESET"

# Create new laravel Project
if [[ $appname == '' ]]
    then
        echo -e -n "$COL_BLUE What is the name of the app? $COL_RESET"
        read appname
        echo -e "\n"
fi

# --- Laravel 4.0 Support ---
# composer create-project laravel/laravel $appname

# --- Laravel 4.1 Support ---
# use new laravel.phar command to 'craft' new application
# maintained name of 'laravel.phar' to avoid conflict with existing alias named 'laravel'
# stored in '/usr/local/bin/'

laravel.phar new $appname

cd $appname

# update application key (currently not done by laravel.phar)
php artisan key:generate

# create customized .bowerrc file (may be used by dev tools)
echo '{
    "directory": "public/lib",
    "json": "bower.json"
}' > .bowerrc

# create application todo file
echo "$appname Todos:" > $appname.todo

# set local timezone
gsed -i "s/'timezone' => 'UTC',/'timezone' => 'America\/Los_Angeles',/g" app/config/app.php

# Install and Configure Way/Generators Package
echo -e "\n"
echo -e -n "$COL_BLUE Do you want to add Common Development Libraries to $COL_YELLOW$appname$COL_RESET $YN_PROMPT "
read -e devtools
if [[ $devtools == "Y" ]]
    then
        echo -e "-- Adding $COL_GREEN Way/Generators, Darsain/Console, ChromePhp, PHPUnit$COL_RESET and$COL_GREEN Faker$COL_RESET Libraries to $COL_YELLOW$appname$COL_RESET"
        gsed -i '8 a\ \t"require-dev" : { \n \t\t"way/generators": "1.1.*", \n \t\t"phpunit/phpunit": "3.7.*", \n \t\t"darsain/laravel-console": "dev-master", \n \t\t"ccampbell/chromephp": "dev-master", \n \t\t"fzaninotto/faker": "dev-master" \n\t},' composer.json
        gsed -i '22 a\ \t\t\t"vendor/ccampbell/chromephp/ChromePhp.php",' composer.json

        gsed -i "109 a\ \t\t'Way\\\Generators\\\GeneratorsServiceProvider'," app/config/app.php
        gsed -i "110 a\ \t\t'Darsain\\\Console\\\ConsoleServiceProvider'," app/config/app.php
 #       gsed -i "111 a\ \t\t'Clockwork\\\Support\\\Laravel\\\ClockworkServiceProvider'," app/config/app.php

        echo -e "\n$COL_PURPLE Performing Composer Update with new dependencies...\n$COL_RESET"
        composer update

        echo -e "-- Adding $COL_GREEN Twitter Bootstrap and jQuery$COL_RESET"
        bower install bootstrap lodash

        echo -e "-- $COL_GREEN Updating CTags... $COL_RESET"
        ctags -R -f .tags

        echo "\n"
fi

wget https://gist.github.com/mikeerickson/7975294/raw/be46c66f9bcf83c5770f6d59a1b6070ecebf6279/.jshintrc

# publish console assets
php artisan asset:publish

# Update app/bootstrap/start.php with env function
echo -e -n "$COL_BLUE Setup Development Environment $YN_PROMPT "
read -e development
if [[ $development == "Y" ]]
    then
        gsed -i -e'27,31d' bootstrap/start.php
        gsed -i "26 a\ \$env = \$app->detectEnvironment(function() { return getenv('ENV') ?: 'development'; });" bootstrap/start.php
fi

# Pull in grunt workflow
echo -e -n "$COL_BLUE Would you like to use Grunt Workflow (Node.js must be installed) $YN_PROMPT "
read -e useGrunt
if [[ $useGrunt == "Y" ]]
    then
    wget https://gist.github.com/mikeerickson/7921915/raw/05e8c3f41663d3518f7af7f99958b680be0e0a8e/Gruntfile.js
    wget https://gist.github.com/mikeerickson/7921972/raw/7628316347c26ea239067310cb2deb111f747e6c/package.json
    sudo npm install grunt grunt-contrib-less grunt-contrib-watch grunt-contrib-uglify grunt-contrib-cssmin grunt-contrib-jshint grunt-phpunit
    clear
fi

# Create mysql database
echo -e -n "$COL_BLUE Does you app need a database $YN_PROMPT "
read -e needdb
if [[ $needdb == 'Y' ]]
    then
        echo -e -n "$COL_MAGENTA    What is the name of the database for this app?$COL_RESET "
        read -e database

        echo -e -n "$COL_MAGENTA    Would you like to create database in MySQL $YN_PROMPT "
        read -e createdb
        if [[ $createdb == 'Y' ]]
            then
                echo "-- Creating MySQL database"
                mysql -uroot -p -e "CREATE DATABASE \`$DATABASE\`"
        fi

        echo -e "-- Updating database configuration file\n"
        gsed -i "s/'database'  => 'database',/'database'  => '$database',/g" app/config/database.php
        gsed -i "s/'password'  => '',/'password'  => 'root',/g" app/config/database.php

fi

echo -e -n "$COL_BLUE Do you need a users table $YN_PROMPT "
read -e userstable
if [[ $userstable == 'Y' ]]
    then
        echo "-- Creating Users Table"
        php artisan generate:migration create_users_table --fields="username:string:unique, email:string:unique, password:string"

        echo "-- Migrating the database"
        php artisan migrate

fi

echo -e -n "$COL_BLUE Would you like to create a Git Repository $YN_PROMPT "
read -e git
if [[ $git == 'Y' ]]
    then
        echo "-- Initializing Git"
        git init
        git add .
        git commit -m "Initial Commit"

        echo -e -n "$COL_BLUE Would you like to add this Repo to Github $YN_PROMPT "
        read -e github
        if [[ $github == 'Y' ]]
            then
                echo -e -n "$COL_BLUE What is your github username?$COL_RESET "
                read -e githubUsername
                curl -u "$githubUsername" https://api.github.com/user/repos -d "{\"name\":\"$appname\"}"

                git remote add origin git@github.com:$githubUsername/$appname.git
                git push origin master
        fi
fi

echo -e "\n $COL_PURPLE Setup Complete!\n $COL_RESET"