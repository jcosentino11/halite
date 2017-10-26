#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y git build-essential libssl-dev zlib1g-dev libbz2-dev \
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

pyenv install 3.6.3