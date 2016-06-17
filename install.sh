#!/bin/sh

echo "Installing thoughtbot's laptop config"
curl --remote-name https://raw.githubusercontent.com/thoughtbot/laptop/master/mac
sh mac 2>&1 | tee ~/laptop.log

echo "Installing homefiles"
gem install homesick
homesick clone git://github.com/pitchinvasion/home-files.git
cd home-files
git submodule init
git submodule update
homesick symlink home-files
homesick rc home-files

echo "Running local install scripts"
sh $HOME/.laptop.local

echo "Done!"
