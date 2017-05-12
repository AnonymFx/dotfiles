# dotfiles
This is a project for my personally used dotfiles.
Use at own risk.

## Installation
There is an install script which links all configuration files to their proper places.  
**Warning**: The linking currently is only available in force mode, so if the files already exist, they will be overwritten. This will probably change in the future though, so stay tuned ;)

If you have already installed this before 2017-05-12 and want to do an update/reinstallation, delete your .vim folder in your home directory and execute the install script again.
This is due to the switch from pathogen to vim-plug as plugin manager for vim.

## VIM
To install the plugins, exectue `:PlugInstall` once you've executed the install script in this repo.

For autoformat, global formatting programs have to be installed. For available options see its Github [page](https://github.com/Chiel92/vim-autoformat).
