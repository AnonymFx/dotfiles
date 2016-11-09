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
        git )
            ln -snf $PWD/git/global_gitignore $HOME/.gitignore_global
            git config --global core.excludesfile $HOME/.gitignore_global
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
            ;;
        vim )
            ln -snf $PWD/vim/vim $HOME/.vim
            ln -snf $PWD/vim/vimrc $HOME/.vimrc
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
        install bash
        install git
        install readline
        install terminator
        install tmux
        install vim
        install zsh
    else
        echo "$1 is not a valid Target"
        print_help_msg
    fi
fi
