#! /usr/bin/env bash

set -eux

pushd loofah-activerecord

  bundle install
  bundle exec rake test:rails:$TEST_RAILS_VERSION-xss_foliate
  bundle exec rake test:rails:$TEST_RAILS_VERSION-active_record

popd
