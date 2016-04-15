# Home dotfiles

This contains all my home file configurations (in particular my vim setup) so that I can share it across computers.

> Feel free to fork this but don't forget to change your `.gitconfig` so you don't start accidentally creating Git commits as me (you'll need to change the email and name)

It is designed to work with [homesick](https://github.com/technicalpickles/homesick) which handles all my symlinking for me automatically. Much of the configuration is inspired by [Thoughtbot's dotfiles](https://github.com/thoughtbot/dotfiles).

To install, first install [homesick](https://github.com/technicalpickles/homesick):

    gem install homesick

Next, use the homesick command to clone this repository:

    homesick clone git://github.com/pitchinvasion/home-files.git

And install/update the submodules
   
    cd home-files
    git submodule init
    git submodule update

you can now link its contents into your home dir:

    homesick symlink home-files

run the rc file to get vundler installed:

    homesick rc home-files

and restart your terminal.

You can now use the `hup` command to update your home files and install your vim bundles automatically.
