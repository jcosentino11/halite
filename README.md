# halite
Collection of bots created for the [Halite II](https://halite.io) competition

## Setup
```
vagrant up
vagrant ssh
cd /vagrant
```

Vagrant will take care of installing a python environment, as well as Halite CLI.

## Run the game

To run the game, invoke the `game` task

```
invoke game --bot1 Bot1Name --bot2 Bot2Name
```

See `Task Execution` section for more details on invoking tasks.

## Development

### Task Execution

This project utilizes [Invoke](http://www.pyinvoke.org) for task execution.

#### Game

Run the game using two bots

```
invoke game --bot1 Bot1Name --bot2 Bot2Name
```

#### Clean

Remove clutter files (e.g. logs)

```
invoke clean
```


### Package Install

To install a python package, use pipenv:

```
pipenv install  some-package
```

Note that both `Pipfile` and `Pipfile.lock` are checked in.