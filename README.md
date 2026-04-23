# dotfiles
This is a project for my personally used dotfiles.
Use at own risk.

## Installation
The install script links configuration files to your home directory and installs additional components (oh-my-zsh, zsh plugins, powerline fonts).

**Warning**: The linking is done in force mode, so if the files already exist, they will be overwritten.

To install a specific tool:
```bash
./install.sh <target>
```

To install all tools:
```bash
./install.sh all
```

Available targets: `all`, `claude`, `git`, `ideavim`, `ranger`, `vim`, `scripts`, `zsh`

## VIM
To install the plugins, exectue `:PlugInstall` once you've executed the install script in this repo.

For autoformat, global formatting programs have to be installed. For available options see its Github [page](https://github.com/Chiel92/vim-autoformat).
