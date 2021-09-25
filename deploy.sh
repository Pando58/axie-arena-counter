#!/usr/bin/env sh

set -e

npm run build

cd dist

git init
git add -A
git commit -m 'deploy'

git push -f git@github.com:Pando58/axie-arena-counter.git master:gh-pages

cd -
