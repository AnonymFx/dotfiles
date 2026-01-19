#!/usr/bin/env zsh
function print_help_msg() {
	cat <<-EOF
	Usage: install.sh TARGET
	TARGET := { all,
				git
				ideavim
				ranger
				vim
				neovim
				scripts
				zsh
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
				git )
					echo "git"
					return 0
					;;
				ideavim )
					echo ""
					return 1
					;;
				ranger )
					echo "ranger"
					return 0
					;;
				scripts )
					echo "jq"
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
				zsh )
					echo "zsh curl fzf the_silver_searcher exa lua z.lua fd bat"
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


	if [[ ! -z $PACKAGER_COMMAND ]] && [[ ! -z $PACKAGES ]]; then
		echo "Installing $PACKAGES with $PACKAGER_COMMAND"

		eval $PACKAGER_COMMAND $PACKAGES
	else
		echo "Platform not supported for installing packages, please install manually"
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
		git )
			ln -snf $PWD/git/global_gitignore $HOME/.gitignore_global
			ln -snf $PWD/git/gitconfig $HOME/.gitconfig
			git config --global core.excludesfile $HOME/.gitignore_global
			;;
		ideavim )
			ln -snf $PWD/ideavim/ideavimrc $HOME/.ideavimrc
			;;
		ranger )
			mkdir -p $HOME/.config/ranger
			ln -snf $PWD/ranger/rifle.conf $HOME/.config/ranger/rifle.conf
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
		zsh )
			mkdir -p $HOME/bin
			ln -snf $PWD/zsh/zshrc $HOME/.zshrc
			ln -snf $PWD/zsh/system-update-prompt.sh $HOME/bin/system-update-prompt
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

		vim )
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
			install_additional $TARGET
			post_install $TARGET
		fi
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
		install git
		install ideavim
		install ranger
		install vim
		install neovim
		install scripts
		install zsh
	elif [[ $1 = git ]]; then
		install git
	elif [[ $1 = ideavim ]]; then
		install ideavim
	elif [[ $1 = ranger ]]; then
		install ranger
	elif [[ $1 = vim ]]; then
		install vim
	elif [[ $1 = neovim ]]; then
		install neovim
	elif [[ $1 = scripts ]]; then
		install scripts
	elif [[ $1 = zsh ]]; then
		install zsh
	else
		echo "$1 is not a valid Target"
		print_help_msg
	fi
fi
