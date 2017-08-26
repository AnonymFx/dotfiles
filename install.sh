#!/bin/bash
function print_help_msg() {
    cat <<-EOF
    Usage: install.sh TARGET

    TARGET := { all,
                nogui
                autorandr
                dconf
                bash
                gdb
                git
                gtk
                i3-gaps
                ideavim
                polybar
                ranger
                readline
                terminator
                tmux
                vim
                neovim
                vimiv
                vrapper
                zathura
                zsh
                X
              }
EOF
}

function get_os() {
	echo "$(cat /etc/os-release | head -3 | tail -1 | sed 's/ID=//')"
}

function get_packager_cmd() {
	local OS_VERSION="$1"
	case $OS_VERSION in
		arch )
			if yaourt_location="$(type -p yaourt)" && [ -n "$yaourt_location" ]; then
				echo "yaourt -S"
				return 0
			elif pacman_location="$(type -p pacman)" && [ -n "$pacman_location" ]; then
				echo "sudo pacman -S"
				return 0
			fi
			;;
		* )
			echo ""
			return 1
			;;

	esac
}

function get_package_list() {
	OS_VERSION="$1"
	TARGET="$2"
	case $TARGET in
		autorandr )
			case "$OS_VERSION" in
				arch )
					echo "autorandr-git"
					return 0
					;;
			esac
			;;
		dconf )
			case "$OS_VERSION" in
				arch )
					echo "dconf"
					return 0
					;;
			esac
			;;
		bash )
			case "$OS_VERSION" in
				arch )
					echo "bash"
					return 0
					;;
			esac
			;;
		gdb )
			case "$OS_VERSION" in
				arch )
					echo "gdb"
					return 0
					;;
			esac
			;;
		git )
			case "$OS_VERSION" in
				arch )
					echo "git"
					return 0
					;;
			esac
			;;
		gtk )
			case "$OS_VERSION" in
				arch )
					echo "gtk3 gtk2"
					return 0
					;;
			esac
			;;
		i3-gaps )
			case "$OS_VERSION" in
				arch )
					echo "i3-gaps i3-lock-color-git dmenu rofi compton feh polybar autorandr-git udiskie"
					return 0
					;;
			esac
			;;
		ideavim )
			case "$OS_VERSION" in
				arch )
					echo ""
					return 1
					;;
			esac
			;;
		polybar )
			case "$OS_VERSION" in
				arch )
					echo "polybar-git xbacklight"
					return 0
					;;
			esac
			;;
		ranger )
			case "$OS_VERSION" in
				arch )
					echo "ranger"
					return 0
					;;
			esac
			;;
		readline )
			case "$OS_VERSION" in
				arch )
					echo "readline"
					return 0
					;;
			esac
			;;
		terminator )
			case "$OS_VERSION" in
				arch )
					echo "terminator"
					return 0
					;;
			esac
			;;
		tmux )
			case "$OS_VERSION" in
				arch )
					echo "tmux"
					return 0
					;;
			esac
			;;
		vim )
			case "$OS_VERSION" in
				arch )
					echo "gvim"
					return 0
					;;
			esac
			;;
		neovim )
			case "$OS_VERSION" in
				arch )
					echo "neovim"
					return 0
					;;
			esac
			;;
		vimiv )
			case "$OS_VERSION" in
				arch )
					echo "vimiv"
					return 0
					;;
			esac
			;;
		vrapper )
			case "$OS_VERSION" in
				arch )
					echo ""
					return 1
					;;
			esac
			;;
		zathura )
			case "$OS_VERSION" in
				arch )
					echo "zathura zathura-pdf-mupdf"
					return 0
					;;
			esac
			;;
		zsh )
			case "$OS_VERSION" in
				arch )
					echo "zsh curl"
					return 0
					;;
			esac
			;;
		X )
			case "$OS_VERSION" in
				arch )
					echo "xorg-server"
					return 0
					;;
			esac
			;;
	esac

	echo ""
	return 1
}

function install_dep() {
	local OS_VERSION="$1"
	local TARGET="$2"

	PACKAGER_COMMAND=$(get_packager_cmd $OS_VERSION)
	PACKAGES=$(get_package_list $OS_VERSION $TARGET)

	if [[ ! -z $PACKAGER_COMMAND ]] && [[ ! -z $PACKAGES ]]; then
		eval $PACKAGER_COMMAND $PACKAGES
	fi
}

function link_config() {
    local TARGET="$1"

    case "$TARGET" in
        autorandr )
            ln -snf $PWD/autorandr/postswitch $HOME/.config/autorandr/postswitch
            ;;
        bash )
            ln -snf $PWD/bash/bashrc $HOME/.bashrc
            ;;
        dconf )
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
        gtk )
            ln -snf $PWD/gtk/gtkrc-2.0 $HOME/.gtkrc-2.0
            ln -snf $PWD/gtk/gtk-3.0-settings.ini $HOME/.config/gtk-3.0/settings.ini
            ;;
        i3-gaps )
            ln -snf $PWD/i3-gaps/config $HOME/.config/i3/config
            ln -snf $PWD/i3-gaps/background.png $HOME/Pictures/i3-bg.png
            ;;
        ideavim )
            ln -snf $PWD/ideavim/ideavimrc $HOME/.ideavimrc
            ;;
        polybar )
            ln -snf $PWD/polybar/config $HOME/.config/polybar/config
            ln -snf $PWD/polybar/launch.sh $HOME/.config/polybar/launch.sh
            ;;
        ranger )
            ln -snf $PWD/ranger/rifle.conf $HOME/.config/ranger/rifle.conf
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
            mkdir -p $HOME/.vim
            ln -snf $PWD/vim/vim/autoload $HOME/.vim/autoload
            ln -snf $PWD/vim/vimrc $HOME/.vimrc
            ln -snf $PWD/vim/gvimrc $HOME/.gvimrc
            ;;
        neovim )
            ln -snf $PWD/vim/vim $HOME/.config/nvim
            ln -snf $PWD/vim/vimrc $HOME/.config/nvim/init.vim
            ;;
        vimiv )
            ln -snf $PWD/vimiv $HOME/.vimiv
            ;;
        vrapper )
            ln -snf $PWD/vrapper/vrapperrc $HOME/.vrapperrc
            ;;
        zathura )
            ln -snf $PWD/zathura/zathurarc $HOME/.config/zathura/zathurarc
            ;;
        zsh )
            ln -snf $PWD/zsh/zshrc $HOME/.zshrc
            ;;
        X )
            ln -snf $PWD/X/Xresources $HOME/.Xresources
            ln -snf $PWD/X/mimeapps.list $HOME/.config/mimeapps.list
            ;;
        esac
}

function install_additional() {
    local TARGET="$1"

    case "$TARGET" in
        autorandr )
            ;;
        bash )
            ;;
        dconf )
            ;;
        gdb )
            ;;
        git )
            ;;
        gtk )
            ;;
        i3-gaps )
            ;;
        ideavim )
            ;;
        polybar )
            ;;
        ranger )
            ;;
        readline )
            ;;
        terminator )
            ;;
        tmux )
            ;;
        vim )
            ;;
        neovim )
            ;;
        vimiv )
            ;;
        vrapper )
            ;;
        zathura )
            ;;
        zsh )
			# Oh-My-Zsh
			sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
			# Zsh autosuggestions plugin
			git clone git://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
			# spaceship theme
			curl https://raw.githubusercontent.com/denysdovhan/spaceship-zsh-theme/master/spaceship.zsh -o $HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme
            ;;
        X )
            ;;
        esac
}

function install() {
    local TARGET="$1"
	local OS_VERSION="$(get_os)"
	if [[ -z $(get_packager_cmd $OS_VERSION) ]]; then
		echo "$OS_VERSION not supported"
		exit 1
	fi
	echo -e "Do you want to install \033[1;33m$TARGET\033[0m [(Y)es/(n)o]:"
	read line
	if [[ "$line" == Y* ]] || [[ "$line" == y* ]] || [ -z "$line" ]; then
		install_dep $OS_VERSION $TARGET
		link_config $TARGET
		install_additional $TARGET
	fi
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
        install autorandr
        install dconf
        install bash
        install gdb
        install git
        install gtk
        install i3-gaps
        install ideavim
        install polybar
        install ranger
        install readline
        install terminator
        install tmux
        install vim
        install neovim
        install vimiv
        install vrapper
        install zathura
        install zsh
        install X
	elif [[ $1 == nogui ]]; then
		install bash
		install gdb
		install git
		install ranger
		install readline
		install tmux
		install vim
		install neovim
		install zsh
	elif [[ $1 = autorandr ]]; then
        install autorandr
	elif [[ $1 = dconf ]]; then
        install dconf
	elif [[ $1 = bash ]]; then
        install bash
	elif [[ $1 = gdb ]]; then
        install gdb
	elif [[ $1 = git ]]; then
        install git
	elif [[ $1 = gtk ]]; then
        install gtk
	elif [[ $1 = i3 ]]; then
        install i3-gaps
	elif [[ $1 = ideavim ]]; then
        install ideavim
	elif [[ $1 = polybar ]]; then
        install polybar
	elif [[ $1 = ranger ]]; then
        install ranger
	elif [[ $1 = readline ]]; then
        install readline
	elif [[ $1 = terminator ]]; then
        install terminator
	elif [[ $1 = tmux ]]; then
        install tmux
	elif [[ $1 = vim ]]; then
        install vim
	elif [[ $1 = neovim ]]; then
        install neovim
	elif [[ $1 = vimiv ]]; then
        install vimiv
	elif [[ $1 = vrapper ]]; then
        install vrapper
	elif [[ $1 = zathura ]]; then
        install zathura
	elif [[ $1 = zsh ]]; then
        install zsh
	elif [[ $1 = X ]]; then
        install X
    else
        echo "$1 is not a valid Target"
        print_help_msg
    fi
fi
