from invoke import task

@task
def clean(ctx):
	patterns = ['*.log', '*.hlt']
	for pattern in patterns:
		ctx.run("rm -rf {}".format(pattern))

@task
def game(ctx, bot1='', bot2='', width=240, height=160):
	ctx.run("./halite -d '{} {}' 'python bots/{}.py' 'python bots/{}.py'".format(width, height, bot1, bot2))