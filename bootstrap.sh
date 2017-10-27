#!/usr/bin/env bash

PYTHON_VERSION=3.6.3

# Install dependencies
if [ ! -f ~/.bootstrap-lock ]; then
	sudo apt-get update
	sudo apt-get install -y git unzip build-essential libssl-dev zlib1g-dev libbz2-dev \
	libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
	xz-utils tk-dev

	# Setup pyenv via pyenv-installer 
	# References: https://github.com/pyenv/pyenv-installer
	#             https://gist.github.com/cstrap/ed7eaeec0594f8e05abe
	curl -sL https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash &> /dev/null
	chown -R vagrant.vagrant ~/.pyenv/
	echo 'export PATH="~/.pyenv/bin:$PATH"' >> ~/.bashrc
	echo 'eval "$(pyenv init -)"' >> ~/.bashrc

	# Hack: running source does not work as expected
	export PATH="~/.pyenv/bin:$PATH"
	eval "$(pyenv init -)"

  	# Install python make it default python shell
	pyenv install ${PYTHON_VERSION}
	pyenv shell ${PYTHON_VERSION}

	# Install pipenv and initialize it in project dir
	pip install pipenv
	cd /vagrant
	pipenv install 
	cd -

	touch ~/.bootstrap-lock
fi

# Download halite executable if it doesn't exist
if [ ! -f /vagrant/halite ]; then
    curl -s https://halite.io/assets/downloads/Halite2_Linux-x64.zip > /vagrant/halite.zip
    unzip /vagrant/halite.zip -d /vagrant
    chmod +x /vagrant/halite
    rm /vagrant/halite.zip
fi
