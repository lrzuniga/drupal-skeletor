#!/usr/bin/env bash

# Build Drupal site
cd $TRAVIS_BUILD_DIR
cat build-*.make | sed "s/develop/$TRAVIS_COMMIT/g" | drush make --prepare-install php://stdin build

# Start serving the site
php -S localhost:8000 -t $TRAVIS_BUILD_DIR/build 2> /dev/null &

cd $TRAVIS_BUILD_DIR/tmp/tests

# Install testing dependencies
composer install
