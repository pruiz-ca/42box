#!/bin/bash

path=$(pwd)

# Create path directory if it doesn't exist
if [ ! -d "$path" ]; then
	mkdir -p "$path"
	echo "✅ Directory created... "
fi

# If Vagrantfile exists, ask if user wants to overwrite it
if [ -f "$path/Vagrantfile" ]; then
	echo "⚠️ Vagrantfile already exists in this directory. Do you want to overwrite it? (y/n)"
	read -r answer
	if [ "$answer" = "y" ]; then
		echo "✅ Overwriting Vagrantfile..."
		rm "$path/Vagrantfile"
		curl -sL -o "$path/Vagrantfile" https://raw.githubusercontent.com/pruiz-ca/42box/main/Vagrantfile
	fi
else
	curl -sL -o "$path/Vagrantfile" https://raw.githubusercontent.com/pruiz-ca/42box/main/Vagrantfile
fi

# Install homebrew, vagrant and virtualbox
if [ "$(uname)" == "Linux" ]; then
	if ! [ -x "$(command -v vagrant)" ]; then
		sudo apt-get install vagrant
		echo "✅ Installed vagrant..."
	fi
	if ! [ -x "$(command -v virtualbox)" ]; then
		sudo apt-get install virtualbox
		echo "✅ Installed virtualbox..."
	fi
elif [ "$(uname)" == "Darwin" ]; then
	if ! [ -x "$(command -v ruby)" ]; then
		brew install ruby
		echo "✅ Installed ruby..."
	fi
	if ! [ -x "$(command -v brew)" ]; then
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		echo "✅ Installed homebrew..."
	fi
	if ! [ -x "$(command -v vagrant)" ]; then
		brew install vagrant
		echo "✅ Installed vagrant..."
	fi
	if ! [ -x "$(command -v virtualbox)" ]; then
		brew install virtualbox
		echo "✅ Installed virtualbox..."
	fi
fi

# Create or replace aliases if the already exist
if [ -f ~/.zshrc ]; then
	if grep -q "alias 42box" ~/.zshrc; then
		sed -i '' '/alias 42box/d' ~/.zshrc
	fi
	echo "alias 42box='cd $path && vagrant up > /dev/null && vagrant ssh'" >> ~/.zshrc
	echo "✅ Added alias to .zshrc..."
fi

if [ -f ~/.bashrc ]; then
	if grep -q "alias 42box" ~/.bashrc; then
		sed -i '' '/alias 42box/d' ~/.zshrc
	fi
	echo "alias 42box='cd $path && vagrant up > /dev/null && vagrant ssh'" >> ~/.bashrc
	echo "✅ Added alias to .bashrc..."
fi

echo "🎉 42box installation complete! 🎉"
echo "You can now run '42box' to start the 42box VM."
