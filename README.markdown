# Home dotfiles

This contains all my home file configurations (in particular my vim setup) so that I can share it across computers.

> Feel free to fork this but don't forget to change your `.gitconfig` so you don't start accidentally creating Git commits as me (you'll need to change the email and name)

It is designed to work with [homesick](https://github.com/technicalpickles/homesick) which handles all my symlinking for me automatically. Much of the configuration is inspired by [Thoughtbot's dotfiles](https://github.com/thoughtbot/dotfiles).

To install run

```
curl https://raw.githubusercontent.com/pitchinvasion/home-files/master/install.sh | sh

and restart your terminal.

You can now use the `hup` command to update your home files and install your vim bundles automatically.
