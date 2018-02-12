#! /usr/bin/env bash

set -eux

pushd loofah-activerecord

  bundle install
  bundle exec rake test

popd
