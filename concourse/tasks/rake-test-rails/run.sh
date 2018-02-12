#! /usr/bin/env bash

set -eux

pushd loofah-activerecord

  apt-get update
  apt-get install -y rsync

  bundle install
  bundle exec rake test:rails:$TEST_RAILS_VERSION-xss_foliate
  bundle exec rake test:rails:$TEST_RAILS_VERSION-active_record

popd
