# halite
Collection of bots created for the [Halite II](https://halite.io) competition

## Setup
```
vagrant up
vagrant ssh
cd /vagrant
```

Vagrant will take care of installing a python environment, as well as Halite CLI.

## Usage

Run game with two competing bots
```
./game.sh <bot name> <other bot name>
```

Run game where bot faces itself
```
./game.sh <bot name>
```

See more details at https://halite.io/learn-programming-challenge/halite-cli-and-tools/cli.
