#!/usr/bin/env bash

set -e

if  [ "$TEST_TYPE" == "build" ]; then
  npm run build:lib
  cat ./packages/meta/package.json | sed s/0.0.0/$(git describe --tag)/g  > ./packages/meta/package.json
  echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" > ~/.npmrc
  lerna publish --skip-git --repo-version=$(git describe --tag) --yes --force-publish=*
fi