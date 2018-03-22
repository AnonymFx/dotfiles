#!/bin/bash
function print_help_msg() {
	cat <<-EOF
	Usage: install.sh TARGET
	TARGET := { all,
				nogui
				android_studio_canary
				android_studio_release
				autorandr
				compton
				dconf
				dunst
				bash
				gdb
				git
				gtk
				i3-gaps
				ideavim
				intellij_idea
				polybar
				qt
				ranger
				readline
				redshift
				rofi
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
		android_studio_canary )
			mkdir -p $HOME/.AndroidStudioCanary/config/{colors,fileTemplates,keymaps,options}
			rm -r $HOME/.AndroidStudioCanary/config/fileTemplates/*
			ln -snf $PWD/intellij_idea/config/colors/* $HOME/.AndroidStudioCanary/config/colors
			ln -snf $PWD/intellij_idea/config/fileTemplates/* $HOME/.AndroidStudioCanary/config/fileTemplates
			ln -snf $PWD/intellij_idea/config/keymaps/* $HOME/.AndroidStudioCanary/config/keymaps
			ln -snf $PWD/intellij_idea/config/options/* $HOME/.AndroidStudioCanary/config/options
			;;
		android_studio_release )
			mkdir -p $HOME/.AndroidStudioRelease/config/{colors,fileTemplates,keymaps,options}
			rm -r $HOME/.AndroidStudioRelease/config/fileTemplates/*
			ln -snf $PWD/intellij_idea/config/colors/* $HOME/.AndroidStudioRelease/config/colors
			ln -snf $PWD/intellij_idea/config/fileTemplates/* $HOME/.AndroidStudioRelease/config/fileTemplates
			ln -snf $PWD/intellij_idea/config/keymaps/* $HOME/.AndroidStudioRelease/config/keymaps
			ln -snf $PWD/intellij_idea/config/options/* $HOME/.AndroidStudioRelease/config/options
			;;
		autorandr )
			mkdir -p $HOME/.config/autorandr
			ln -snf $PWD/autorandr/postswitch $HOME/.config/autorandr/postswitch
			;;
		compton )
			ln -snf $PWD/compton/compton.conf $HOME/.config/compton.conf
			;;
		bash )
			ln -snf $PWD/bash/bashrc $HOME/.bashrc
			;;
		dconf )
			dconf load / < $PWD/dconf/keybindings
			;;
		dunst )
			mkdir -p $HOME/.config/dunst
			ln -snf $PWD/dunst/dunstrc $HOME/.config/dunst
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
			ln -snf $PWD/i3-gaps/lock.sh $HOME/.config/i3/lock.sh
			ln -snf $PWD/i3-gaps/autostart.sh $HOME/.config/i3/autostart.sh
			ln -snf $PWD/i3-gaps/background $HOME/.config/i3/background
			ln -snf $PWD/i3-gaps/lockscreen $HOME/.config/i3/lockscreen
			;;
		ideavim )
			ln -snf $PWD/ideavim/ideavimrc $HOME/.ideavimrc
			;;
		intellij_idea)
			mkdir -p $HOME/.IntelliJIdea/config/{colors,fileTemplates,keymaps,options}
			rm -r $HOME/.IntelliJIdea/config/fileTemplates/*
			ln -snf $PWD/intellij_idea/config/colors/* $HOME/.IntelliJIdea/config/colors
			ln -snf $PWD/intellij_idea/config/fileTemplates/* $HOME/.IntelliJIdea/config/fileTemplates
			ln -snf $PWD/intellij_idea/config/keymaps/* $HOME/.IntelliJIdea/config/keymaps
			ln -snf $PWD/intellij_idea/config/options/* $HOME/.IntelliJIdea/config/options
			;;
		polybar )
			mkdir -p $HOME/.config/polybar
			ln -snf $PWD/polybar/config $HOME/.config/polybar/config
			ln -snf $PWD/polybar/launch.sh $HOME/.config/polybar/launch.sh
			ln -snf $PWD/polybar/playerctl.sh $HOME/.config/polybar/playerctl.sh
			;;
		qt )
			mkdir -p $HOME/.config/qt5ct
			ln -snf $PWD/qt/qt5ct.conf $HOME/.config/qt5ct/qt5ct.conf
			ln -snf $PWD/qt/qt4.conf $HOME/.config/Trolltech.conf
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
		rofi )
			mkdir -p $HOME/.config/rofi
			ln -snf $PWD/rofi/config.rasi $HOME/.config/rofi/config.rasi
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
			mkdir -p $HOME/bin
			ln -snf $PWD/zsh/zshrc $HOME/.zshrc
			ln -snf $PWD/zsh/system-update-prompt.sh $HOME/bin/system-update-prompt
			;;
		X )
			mkdir -p $HOME/.config
			ln -snf $PWD/X/Xresources $HOME/.Xresources
			ln -snf $PWD/X/mimeapps.list $HOME/.config/mimeapps.list
			ln -snf $PWD/X/xprofile $HOME/.xprofile
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
			if [ -e $HOME/.zshrc ]; then
				source $HOME/.zshrc
			fi

			# Zsh autosuggestions plugin
			if [[ -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]]; then
				echo "Updating zsh-autosuggestions"
				pushd $ZSH_CUSTOM/plugins/zsh-autosuggestions
				git pull
				popd
			else
				echo "Installing zsh-autosuggestions"
				git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
			fi
			# Zsh syntax highlighting
			if [[ -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]]; then
				echo "Updating zsh-syntax-highlighting"
				pushd $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
				git pull
				popd
			else
				echo "Installing zsh-syntax-highlighting"
				git clone git://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
			fi
			# spaceship theme
			echo "Installing/Updating spaceship theme"
			SPACESHIP_TARGET="$ZSH_CUSTOM/themes/spaceship-prompt"
			if [ ! -e "$SPACESHIP_TARGET" ]; then
				git clone https://github.com/denysdovhan/spaceship-prompt.git "$SPACESHIP_TARGET"
				ln -sf "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
			else
				git pull $SPACESHIP_TARGET
			fi
			;;

		polybar | vim )
			# Install powerline fonts
			# clone
			git clone https://github.com/powerline/fonts.git --depth=1
			# install
			cd fonts
			./install.sh
			# clean-up a bit
			cd ..
			rm -rf fonts
			;;
	esac
}

function install() {
	local TARGET="$1"
	echo -e "Do you want to install \033[1;33m$TARGET\033[0m [(Y)es/(n)o]:"
	read line
	if [[ "$line" == Y* ]] || [[ "$line" == y* ]] || [ -z "$line" ]; then
		echo -e "Do you want to install the packages for \033[1;33m$TARGET\033[0m [(Y)es/(n)o]:"
		read line
		if [[ "$line" == Y* ]] || [[ "$line" == y* ]] || [ -z "$line" ]; then
			install_packages $TARGET
		fi
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
	if git_dir="$(git rev-parse --git-dir 2>/dev/null)" && [ -d "$git_dir" ]; then
		echo "Starting merge..."
		if ! git merge master; then
			echo "There were some merge conflicts, please resolve them and run the script again."
			exit 1
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
		install android_studio_canary
		install android_studio_release
		install autorandr
		install compton
		install dconf
		install dunst
		install bash
		install gdb
		install git
		install gtk
		install i3-gaps
		install ideavim
		install intellij_idea
		install polybar
		install qt
		install ranger
		install readline
		install redshift
		install rofi
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
	elif [[ $1 = android_studio_canary ]]; then
		install android_studio_canary
	elif [[ $1 = android_studio_release ]]; then
		install android_studio_release
	elif [[ $1 = autorandr ]]; then
		install autorandr
	elif [[ $1 = compton ]]; then
		install compton
	elif [[ $1 = dconf ]]; then
		install dconf
	elif [[ $1 = dunst ]]; then
		install dunst
	elif [[ $1 = bash ]]; then
		install bash
	elif [[ $1 = gdb ]]; then
		install gdb
	elif [[ $1 = git ]]; then
		install git
	elif [[ $1 = gtk ]]; then
		install gtk
	elif [[ $1 = i3-gaps ]]; then
		install i3-gaps
	elif [[ $1 = ideavim ]]; then
		install ideavim
	elif [[ $1 = intellij_idea ]]; then
		install intellij_idea
	elif [[ $1 = polybar ]]; then
		install polybar
	elif [[ $1 = qt ]]; then
		install qt
	elif [[ $1 = ranger ]]; then
		install ranger
	elif [[ $1 = readline ]]; then
		install readline
	elif [[ $1 = redshift ]]; then
		install redshift
	elif [[ $1 = rofi ]]; then
		install rofi
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
