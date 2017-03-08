#!/bin/bash
function print_help_msg() {
    cat <<-EOF
    Usage: install.sh TARGET

    TARGET := {all}
EOF
}

function install() {
    local TARGET="$1"
    case "$TARGET" in
        bash )
            ln -snf $PWD/bash/bashrc $HOME/.bashrc
            ;;
        dconf)
            dconf load / < $PWD/dconf/keybindings
            ;;
        gdb )
            ln -snf $PWD/gdb/gdbinit $HOME/.gdbinit
            ln -snf $PWD/gdb/gdbinit.d $HOME/.gdbinit.d
            ;;
        git )
            ln -snf $PWD/git/global_gitignore $HOME/.gitignore_global
            git config --global core.excludesfile $HOME/.gitignore_global
            ;;
        i3 )
            ln -snf $PWD/i3/config $HOME/.config/i3/config
            ;;
        intellij )
            ln -snf $PWD/intellij/ideavimrc $HOME/.ideavimrc
            ;;
        polybar )
            ln -snf $PWD/polybar/config $HOME/.config/polybar/config
            ln -snf $PWD/polybar/launch.sh $HOME/.config/polybar/launch.sh
            ;;
        readline )
            ln -snf $PWD/readline/inputrc $HOME/.inputrc
            ;;
        terminator )
            mkdir -p $HOME/.config/terminator
            ln -snf $PWD/terminator/terminator.conf $HOME/.config/terminator/config
            ;;
        tmux )
            ln -snf $PWD/tmux/tmux.conf $HOME/.tmux.conf
            ln -snf $PWD/tmux/tmux.layouts $HOME/.tmux.layouts
            ;;
        vim )
            ln -snf $PWD/vim/vim $HOME/.vim
            ln -snf $PWD/vim/vimrc $HOME/.vimrc
            ln -snf $PWD/vim/gvimrc $HOME/.gvimrc
            ;;
        neovim)
            ln -snf $PWD/vim/vim $HOME/.config/nvim
            ln -snf $PWD/vim/vimrc $HOME/.config/nvim/init.vim
            ;;
        zsh )
            ln -snf $PWD/zsh/zshrc $HOME/.zshrc
            ;;
        esac
}

# Check if script is called from the dotfiles folder
# If not, link creation will not work
if [[ $0 != "./install.sh" ]]; then
    echo "Please execute the install script in the dotfiles folder"
    exit 1
fi

if [[ $# -eq 0 ]]; then
    print_help_msg
    exit 0
elif [[ $# -gt 1 ]]; then
    echo "You can only specify one target"
    exit 1
else
    if [[ $1 = all ]]; then
        install dconf
        install bash
        install gdb
        install git
        install i3
        install intellij
        install polybar
        install readline
        install terminator
        install tmux
        install vim
        install neovim
        install zsh
    else
        echo "$1 is not a valid Target"
        print_help_msg
    fi
fi
