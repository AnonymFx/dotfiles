# dotfiles
This is a project for my personally used dotfiles.
Use at own risk.

## Installation
There is an install script which links all configuration files to their proper places.  
**Warning**: The linking currently is only available in force mode, so if the files already exist, they will be overwritten. This will probably change in the future though, so stay tuned ;)

## VIM
For the given vim configuration to work, the YouCompleteMe autocomplete plugin has to be built and properly installed. See the [documentation](https://github.com/Valloric/YouCompleteMe/) for further reference.
Note that submodules have to be pulled with `git submodule update --init --recursive`.

For autoformat, global formatting programs have to be installed. For available options see its Github [page](https://github.com/Chiel92/vim-autoformat).
