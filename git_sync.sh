#!/bin/bash

read -p "Your name: " name
read -p "Your Email: " email
read -p "Write out commit: " commit

git config --global user.email "$email"
git config --global user.name "$name"

git add .
git commit -m "$commit"
git push -u origin master
