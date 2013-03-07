#!/usr/bin/env bash

sudo tee /etc/default/sauce-connect > /dev/null <<EOH
JAVA=java
SAUCE_CONNECT=$TRAVIS_BUILD_DIR/tmp/tests/vendor/sauce/connect/lib/Sauce-Connect.jar
API_USER=$SAUCE_USERNAME
API_KEY=$SAUCE_ACCESS_KEY
USERNAME=
GROUP=
LOG_DIR=/var/log/sauce-connect
EOH

(cd /etc/init.d && sudo curl -o sauce-connect https://raw.github.com/rtyler/puppet-sauceconnect/master/files/init.d_sauce-connect)
sudo service sauce-connect start
cd $TRAVIS_BUILD_DIR/tmp/tests
vendor/bin/paratest -p 2 -f --phpunit=vendor/bin/phpunit WebDriverDemo.php
sudo service sauce-connect stop
