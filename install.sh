#!/bin/sh

sudo gem install homesick

# You may want to setup your computer using Thoughtbot's laptop
# https://github.com/thoughtbot/laptop
#
# echo "Installing Thoughtbot's laptop setup"
# curl --remote-name https://raw.githubusercontent.com/thoughtbot/laptop/master/mac && sh mac

echo "Installing homefiles"
homesick clone https://github.com/pitchinvasion/home-files.git
cd home-files
homesick symlink -f home-files
homesick rc home-files
echo "Done!"
