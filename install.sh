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
				redshift
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

function get_packager_cmd() {
	echo ""
	return 1
}

function get_package_list() {
	TARGET="$1"
	case $TARGET in
	esac

	echo ""
	return 1
}

function install_packages() {
	local TARGET="$1"

	PACKAGER_COMMAND=$(get_packager_cmd)
	PACKAGES=$(get_package_list $TARGET)

	echo "Installing $PACKAGES with $PACKAGER_COMMAND"

	if [[ ! -z $PACKAGER_COMMAND ]] && [[ ! -z $PACKAGES ]]; then
		eval $PACKAGER_COMMAND $PACKAGES
	fi
}

function post_install() {
	local TARGET="$1"

	case $TARGET in
	esac

	echo ""
	return 1
}

function link_config() {
	local TARGET="$1"

	echo "Linking config files for $TARGET"

	case "$TARGET" in
		autorandr )
			mkdir -p $HOME/.config/autorandr
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
			ln -snf $PWD/git/gitconfig $HOME/.gitconfig
			git config --global core.excludesfile $HOME/.gitignore_global
			;;
		gtk )
			mkdir -p $HOME/.config/gtk-3.0
			ln -snf $PWD/gtk/gtkrc-2.0 $HOME/.gtkrc-2.0
			ln -snf $PWD/gtk/gtk-3.0-settings.ini $HOME/.config/gtk-3.0/settings.ini
			;;
		i3-gaps )
			mkdir -p $HOME/.config/i3
			mkdir -p $HOME/Pictures
			ln -snf $PWD/i3-gaps/config $HOME/.config/i3/config
			ln -snf $PWD/i3-gaps/background.png $HOME/Pictures/i3-bg.png
			;;
		ideavim )
			ln -snf $PWD/ideavim/ideavimrc $HOME/.ideavimrc
			;;
		polybar )
			mkdir -p $HOME/.config/polybar
			ln -snf $PWD/polybar/config $HOME/.config/polybar/config
			ln -snf $PWD/polybar/launch.sh $HOME/.config/polybar/launch.sh
			;;
		ranger )
			mkdir -p $HOME/.config/ranger
			ln -snf $PWD/ranger/rifle.conf $HOME/.config/ranger/rifle.conf
			;;
		readline )
			ln -snf $PWD/readline/inputrc $HOME/.inputrc
			;;
		redshift )
			ln -snf $PWD/redshift/redshift.conf $HOME/.config/redshift.conf
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
			mkdir -p $HOME/.config/nvim
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
			mkdir -p $HOME/.config/zathura
			ln -snf $PWD/zathura/zathurarc $HOME/.config/zathura/zathurarc
			;;
		zsh )
			ln -snf $PWD/zsh/zshrc $HOME/.zshrc
			;;
		X )
			mkdir -p $HOME/.config
			ln -snf $PWD/X/Xresources $HOME/.Xresources
			ln -snf $PWD/X/mimeapps.list $HOME/.config/mimeapps.list
			;;
	esac
}

function install_additional() {
	local TARGET="$1"

	case "$TARGET" in
		zsh )
			# Oh-My-Zsh
			echo "Installing oh-my-zsh"
			sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
			# Zsh autosuggestions plugin
			if [[ -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
				echo "Updating zsh-autosuggestions"
				pushd $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
				git pull
				popd
			else
				echo "Installing zsh-autosuggestions"
				git clone git://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
			fi
			# Zsh syntax highlighting
			if [[ -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
				echo "Updating zsh-syntax-highlighting"
				pushd $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
				git pull
				popd
			else
				echo "Installing zsh-syntax-highlighting"
				git clone git://github.com/zsh-users/zsh-syntax-highlighting $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
			fi
			# spaceship theme
			echo "Installing/Updating spaceship theme"
			curl https://raw.githubusercontent.com/denysdovhan/spaceship-zsh-theme/master/spaceship.zsh -o $HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme
			;;
	esac
}

function install() {
	local TARGET="$1"
	echo -e "Do you want to install \033[1;33m$TARGET\033[0m [(Y)es/(n)o]:"
	read line
	if [[ "$line" == Y* ]] || [[ "$line" == y* ]] || [ -z "$line" ]; then
		install_packages $TARGET
		install_additional $TARGET
		post_install $TARGET
		link_config $TARGET
	fi
}

echo "This is a template script, use the ones in the distro branches"
echo "Aborting!"
exit 1

# Check if script is called from the dotfiles folder
# If not, link creation will not work
if [[ $0 != "./install.sh" ]]; then
	echo "Please execute the install script in the dotfiles folder"
	exit 1
fi

echo "Trying to find git repository to merge master branch..."
if git_loc="$(type -p git)" && [ -n "$git_loc" ]; then
	if git_dir="$(git rev-parse --git-dir > /dev/null 2>&1)" && [ -d git_dir ]; then
		echo "Starting merge..."
		if ! "$(git merge master)"; then
			echo "There were some merge conflicts, please resolve them and run the script again."
			return 1
		else
			echo "Success!"
		fi
	else
		echo "Git repository not found, continuing without merging"
	fi
else
	echo "Git command not found, continuing without merging"
fi

echo "Starting installation..."
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
		install redshift
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
	elif [[ $1 = redshift ]]; then
		install redshift
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
