#!/bin/bash
# dont forget to create write permissions on this file

# - Updated version of Way/Generators to use 1.1.* instead of dev-master to fix errors with Laravel 4.1 release
# - Added clockwork 
# - Added readme.md
# - Added key:generate call (app.php)
# - Added ctags call
# - Added setting timezone (app.php)
# - Added update database password (database.php)
# - Added support for supplying appname as paramater to script
# - Added Faker package
# - Make sure sed is installed if using OSX (install via Homebrew)


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

composer create-project laravel/laravel $appname --prefer-dist

cd $appname

# update application key (currently not done by laravel.phar)
php artisan key:generate

# create application todo file
echo "$appname README:" > README.md

# set local timezone
sed -i "s/'timezone' => 'UTC',/'timezone' => 'America\/Los_Angeles',/g" app/config/app.php

# Install and Configure Way/Generators Package
echo -e "\n"
echo -e -n "$COL_BLUE Do you want to add Common Development Libraries to $COL_YELLOW$appname$COL_RESET $YN_PROMPT "
read -e devtools
if [[ $devtools == "Y" ]]
    then
        echo -e "-- Adding $COL_GREEN Way/Generators, itsgoingd/clockwork, PHPUnit$COL_RESET and$COL_GREEN Faker$COL_RESET Libraries to $COL_YELLOW$appname$COL_RESET"
        sed -i '8 a\ \t"require-dev" : { \n \t\t"way/generators": "dev-master", \n \t\t"phpunit/phpunit": "3.7.*", \n \t\t"itsgoingd/clockwork": "dev-master", \n \t\t"fzaninotto/faker": "dev-master" \n\t},' composer.json

        sed -i "109 a\ \t\t'Way\\\Generators\\\GeneratorsServiceProvider'," app/config/app.php
        sed -i "110 a\ \t\t'Clockwork\\\Support\\\Laravel\\\ClockworkServiceProvider'," app/config/app.php

        echo -e "\n$COL_PURPLE Performing Composer Update with new dependencies...\n$COL_RESET"
        composer update

        echo -e "-- $COL_GREEN Updating CTags... $COL_RESET"
        ctags -R

        echo "\n"
fi

# publish console assets
php artisan asset:publish

# Update app/bootstrap/start.php with env function
echo -e -n "$COL_BLUE Setup Development Environment $YN_PROMPT "
read -e development
if [[ $development == "Y" ]]
    then
        sed -i -e'27,31d' bootstrap/start.php
        sed -i "26 a\ \$env = \$app->detectEnvironment(function() { return getenv('LARAVEL_ENV') ?: 'local'; });" bootstrap/start.php
        # sed -i "26 a\ \$env = \$app->detectEnvironment(function() { return isset(\$_ENV['LARAVEL_ENV']) ? \$_ENV['LARAVEL_ENV'] : 'local'; });" bootstrap/start.php

fi

# Pull in grunt workflow
# echo -e -n "$COL_BLUE Would you like to use Grunt Workflow (Node.js must be installed) $YN_PROMPT "
# read -e useGrunt
# if [[ $useGrunt == "Y" ]]
#     then
#     wget https://gist.github.com/mikeerickson/7921915/raw/05e8c3f41663d3518f7af7f99958b680be0e0a8e/Gruntfile.js
#     wget https://gist.github.com/mikeerickson/7921972/raw/7628316347c26ea239067310cb2deb111f747e6c/package.json
#     sudo npm install grunt grunt-contrib-less grunt-contrib-watch grunt-contrib-uglify grunt-contrib-cssmin grunt-contrib-jshint grunt-phpunit
#     clear
# fi

# Bring down Vagrant for laravel
wget https://raw.github.com/branebrvl/laravel4-upload-share-single-page-js-app/master/install.sh
wget https://raw.github.com/branebrvl/laravel4-upload-share-single-page-js-app/master/Vagrantfile

# Set up local database and service providers for way/generators and clockwork
mkdir app/config/local

cat <<'EOF' > app/config/local/app.php
<?php return [
	  
    'debug' => true,
    // specify require-dev aliases, service proveders are specifed in start/local.php
    'aliases' => ['Clockwork' => 'Clockwork\Support\Laravel\Facade'],
];
EOF

cat <<'EOF' > app/start/local.php
<?php

// specify require-dev service providers, aliases are specifed in app/config/local/app.php
App::register( 'Clockwork\Support\Laravel\ClockworkServiceProvider' );
App::register( 'Way\Generators\GeneratorsServiceProvider' );

function l($val)
{
  return Clockwork::info($val);
}

function start($name, $description)
{
  return Clockwork::startEvent($name, $description);
}

function stop($name)
{
  return Clockwork::endEvent($name);
}
EOF

# cat <<'EOF' > app/config/local/database.php
# <?php return [
# 	  
#     'connections' => [
#       'mysql' => [
#         'driver'    => 'mysql',
#         'host'      => 'localhost',
#         'database'  => '',
#         'username'  => 'root',
#         'password'  => '',
#         'charset'   => 'utf8',
#         'collation' => 'utf8_unicode_ci',
#         'prefix'    => '',
#       ],
#     ]
# ];
# EOF


sed -i "s/'debug' => true,/'debug' => false,/g" app/config/app.php

# Create mysql database
echo -e -n "$COL_BLUE Does you app need a database $YN_PROMPT "
read -e needdb
if [[ $needdb == 'Y' ]]
    then
        echo -e -n "$COL_MAGENTA    What is the name of the database for this app?$COL_RESET "
        read -e database

        echo -e -n "$COL_MAGENTA    Would you like to create database in MySQL $YN_PROMPT "
        read -e createdb
        echo -e -n "$COL_MAGENTA    Password:$COL_RESET"
        read -e passworddb
        if [[ $createdb == 'Y' ]]
            then
                echo "-- Creating MySQL database"
                mysql -uroot -p$passworddb -e "CREATE DATABASE \`$database\`"
        fi

        echo -e "-- Updating database configuration file\n"
        sed -i "s/'host'      => 'localhost',/'host'      => getenv('L4_DB_HOST'),/g" app/config/database.php
        sed -i "s/'database'  => 'database',/'database'  => getenv('L4_DB_DATABASE'),/g" app/config/database.php
        sed -i "s/'username'  => 'root',/'username'  => getenv('L4_DB_USERNAME'),/g" app/config/database.php
        sed -i "s/'password'  => '',/'password'  => getenv('L4_DB_PASSWORD'),/g" app/config/database.php

        # sed -i "s/'database'  => '',/'database'  => '$database',/g" app/config/local/database.php
        # sed -i "s/'password'  => '',/'password'  => '$passworddb',/g" app/config/local/database.php

cat <<EOF > .env.local.php
<?php return [
        'L4_DB_HOST'      => 'localhost',     
        'L4_DB_DATABASE'  => '$database',
        'L4_DB_USERNAME'  => 'root', 
        'L4_DB_PASSWORD'  => '$passworddb', 
];
EOF

cat <<EOF > .env.vagrant.php
<?php return [
        'L4_DB_HOST'      => '10.0.2.2',     
        'L4_DB_DATABASE'  => '$database',
        'L4_DB_USERNAME'  => 'root', 
        'L4_DB_PASSWORD'  => '$passworddb', 
];
EOF

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
