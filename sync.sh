#!/bin/bash

git config --global user.name 'bamecraft[bot]'
git config --global user.email '137437144+bamecraft[bot]@users.noreply.github.com'

cd ./server
git pull origin/main main
git add --all
git commit --message='Sync: local to remote 🔄'
git push origin HEAD:main

cd ../
git pull origin/develop develop
git add --all
git commit --message='Sync: local to remote 🔄'
git push origin HEAD:develop
