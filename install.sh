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
				kitty
				polybar
				pycharm
				qt
				ranger
				readline
				redshift
				rider
				rofi
				terminator
				tmux
				vim
				neovim
				scripts
				vimiv
				vrapper
				webstorm
				zathura
				zsh
				X
			}
EOF
}

function get_distribution_name() {
	IFS="="
	read -a test < /etc/os-release
	echo "${test[1]:1:-1}"
}

function get_packager_cmd() {
	case "$(get_distribution_name)" in
		"Arch Linux" )
			if yay_location="$(type -p yay)" && [ -n "$yay_location" ]; then
				echo "yay -S"
				return 0
			elif trizen_location="$(type -p trizen)" && [ -n "$trizen_location" ]; then
				echo "trizen -S"
				return 0
			elif yaourt_location="$(type -p yaourt)" && [ -n "$yaourt_location" ]; then
				echo "yaourt -S"
				return 0
			elif pacman_location="$(type -p pacman)" && [ -n "$pacman_location" ]; then
				echo "sudo pacman -S"
				return 0
			fi
			;;
	esac
	echo ""
	return 1
}

function get_package_list() {
	TARGET="$1"
	case "$(get_distribution_name)" in
		"Arch Linux")
			case $TARGET in
				autorandr )
					echo "autorandr-git"
					return 0
					;;
				compton )
					echo "compton"
					return 0
					;;
				dconf )
					echo "dconf"
					return 0
					;;
				dunst )
					echo "dunst"
					return 0
					;;
				bash )
					echo "bash"
					return 0
					;;
				gdb )
					echo "gdb"
					return 0
					;;
				git )
					echo "git"
					return 0
					;;
				gtk )
					echo "gtk3 gtk2 arc-gtk-theme papirus-icon-theme"
					return 0
					;;
				i3-gaps )
					echo "i3-gaps light-locker dmenu rofi compton feh autorandr-git udevil gnome-keyring libnotify xdotool imagemagick playerctl network-manager-applet insync polkit polkit-gnome xdg-user-dirs python python-rofi i3ipc-python rofimoji-git"
					return 0
					;;
				ideavim )
					echo ""
					return 1
					;;
				kitty )
					echo "kitty"
					;;
				polybar )
					echo "polybar xorg-xbacklight jq nerd-fonts-complete ttf-material-icons playerctl wireless_tools"
					return 0
					;;
				qt )
					echo "qt4 qt5-base qt5ct"
					;;
				ranger )
					echo "ranger"
					return 0
					;;
				readline )
					echo "readline"
					return 0
					;;
				redshift )
					echo "redshift"
					return 0
					;;
				rofi )
					echo "rofi ttf-dejavu"
					return 0
					;;
				terminator )
					echo "terminator ttf-inconsolata"
					return 0
					;;
				tmux )
					echo "tmux"
					return 0
					;;
				vim )
					echo "gvim ack fzf the_silver_searcher universal-ctags-git vim-spell-de"
					return 0
					;;
				neovim )
					echo "neovim"
					return 0
					;;
				vimiv )
					echo "vimiv"
					return 0
					;;
				zathura )
					echo "zathura zathura-pdf-mupdf"
					return 0
					;;
				zsh )
					echo "zsh curl fzf the_silver_searcher exa lua z.lua fd"
					return 0
					;;
				X )
					echo "xorg-server xmodmap"
					return 0
					;;
			esac
			;;
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

function link_idea_files () {
	mkdir -p $HOME/"$1"/config/{colors,fileTemplates,keymaps,options}
	rm -r $HOME/"$1"/config/fileTemplates/*
	rm -r $HOME/"$1"/config/colors
	ln -snf $PWD/intellij_idea/config/colors $HOME/"$1"/config
	ln -snf $PWD/intellij_idea/config/fileTemplates/* $HOME/"$1"/config/fileTemplates
	ln -snf $PWD/intellij_idea/config/keymaps/* $HOME/"$1"/config/keymaps
	ln -snf $PWD/intellij_idea/config/options/* $HOME/"$1"/config/options
}

function link_config() {
	local TARGET="$1"

	echo "Linking config files for $TARGET"

	case "$TARGET" in
		android_studio_canary )
			link_idea_files ".AndroidStudioCanary"
			;;
		android_studio_release )
			link_idea_files ".AndroidStudioRelease"
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
			ln -snf $PWD/i3-gaps/config $HOME/.config/i3/config
			ln -snf $PWD/i3-gaps/autostart.sh $HOME/.config/i3/autostart.sh
			ln -snf $PWD/i3-gaps/background $HOME/.config/i3/background
			ln -snf $PWD/i3-gaps/lockscreen $HOME/.config/i3/lockscreen
			ln -snf $PWD/i3-gaps/scratchpad.py $HOME/.config/i3/scratchpad.py
			ln -snf $PWD/i3-gaps/layouts $HOME/.config/i3/layouts
			mkdir -p $HOME/bin
			ln -snf $PWD/i3-gaps/screensaver.sh $HOME/bin/screensaver
			;;
		ideavim )
			ln -snf $PWD/ideavim/ideavimrc $HOME/.ideavimrc
			;;
		intellij_idea)
			link_idea_files ".IntelliJIdea"
			;;
		kitty )
			mkdir -p $HOME/.config/
			ln -snf $PWD/kitty $HOME/.config/
			;;
		polybar )
			mkdir -p $HOME/.config/polybar
			ln -snf $PWD/polybar/config $HOME/.config/polybar/config
			ln -snf $PWD/polybar/launch.sh $HOME/.config/polybar/launch.sh
			ln -snf $PWD/polybar/playerctl.sh $HOME/.config/polybar/playerctl.sh
			ln -snf $PWD/polybar/window_title.sh $HOME/.config/polybar/window_title.sh
			ln -snf $PWD/polybar/num_updates.sh $HOME/.config/polybar/num_updates.sh
			;;
		pycharm )
			link_idea_files ".PyCharm"
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
		rider )
			link_idea_files ".Rider"
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
			ln -snf $PWD/tmux/tmux_launch_default.sh $HOME/.tmux_launch_default.sh
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
		scripts )
			# Link actual scripts
			mkdir -p $HOME/bin
			for scriptfile in $(ls $PWD/scripts/bin); do
				script="${scriptfile%.*}"
				ln -snf "$PWD/scripts/bin/$scriptfile" "$HOME/bin/$script"
			done
			# Link zsh completions
			mkdir -p $HOME/.zsh-completions
			for zshcomp in $(ls $PWD/scripts/zsh-completions); do
				ln -snf "$PWD/scripts/zsh-completions/$zshcomp" "$HOME/.zsh-completions/$zshcomp"
			done
			;;
		vimiv )
			ln -snf $PWD/vimiv $HOME/.vimiv
			;;
		vrapper )
			ln -snf $PWD/vrapper/vrapperrc $HOME/.vrapperrc
			;;
		webstorm )
			link_idea_files ".WebStorm"
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
			ln -snf $PWD/X/Xmodmap $HOME/.Xmodmap
			# Desktop entries
			mkdir -p $HOME/.local/share/applications $HOME/.icons
			ln -snf $PWD/X/desktop_entries/*.desktop $HOME/.local/share/applications
			curl https://www.iconfinder.com/icons/3146791/download/png/64 -o $HOME/.icons/whatsapp.png
			curl https://www.iconfinder.com/icons/1688848/download/png/64 -o $HOME/.icons/messaging.png
			curl https://www.iconfinder.com/icons/299092/download/png/64 -o $HOME/.icons/organization.png
			curl https://www.iconfinder.com/icons/1298720/download/png/64 -o $HOME/.icons/facebook_messenger.png
			curl http://icons.iconarchive.com/icons/blackvariant/button-ui-requests-15/64/YNAB-icon.png -o $HOME/.icons/ynab.png
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
				git clone git@github.com:zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
			fi
			# Zsh syntax highlighting
			if [[ -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]]; then
				echo "Updating zsh-syntax-highlighting"
				pushd $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
				git pull
				popd
			else
				echo "Installing zsh-syntax-highlighting"
				git clone git@github.com:zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
			fi
			# spaceship theme
			echo "Installing/Updating spaceship theme"
			SPACESHIP_TARGET="$ZSH_CUSTOM/themes/spaceship-prompt"
			if [ ! -e "$SPACESHIP_TARGET" ]; then
				git clone git@github.com:denysdovhan/spaceship-prompt.git "$SPACESHIP_TARGET"
				ln -sf "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
			else
				pushd "$SPACESHIP_TARGET"
				git pull
				popd
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

echo "Detected distribution $(get_distribution_name)"

# Check if script is called from the dotfiles folder
# If not, link creation will not work
if [[ $0 != "./install.sh" ]]; then
	echo "Please execute the install script in the dotfiles folder"
	exit 1
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
		install kitty
		install polybar
		install pycharm
		install qt
		install ranger
		install readline
		install redshift
		install rider
		install rofi
		install terminator
		install tmux
		install vim
		install neovim
		install scripts
		install vimiv
		install vrapper
		install webstorm
		install zathura
		install zsh
		install X
	elif [[ $1 == nogui ]]; then
		install bash
		install gdb
		install git
		install ranger
		install readline
		install scripts
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
	elif [[ $1 = kitty ]]; then
		install kitty
	elif [[ $1 = polybar ]]; then
		install polybar
	elif [[ $1 = pycharm ]]; then
		install pycharm
	elif [[ $1 = qt ]]; then
		install qt
	elif [[ $1 = ranger ]]; then
		install ranger
	elif [[ $1 = readline ]]; then
		install readline
	elif [[ $1 = redshift ]]; then
		install redshift
	elif [[ $1 = rider ]]; then
		install rider
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
	elif [[ $1 = scripts ]]; then
		install scripts
	elif [[ $1 = vimiv ]]; then
		install vimiv
	elif [[ $1 = vrapper ]]; then
		install vrapper
	elif [[ $1 = webstorm ]]; then
		install webstorm
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
