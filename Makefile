.DEFAULT_GOAL := runner_run

######################
# Run outside container
runner_build:
	docker-compose \
		-f runner/docker-compose.yml \
		build

runner_run:
	docker-compose \
		-f runner/docker-compose.yml \
		run runner

######################
# Run inside container

# XXX:
# run command below outside docker after nixops_create
# sudo chown `whoami`:users ./*.nixops

create:
	nixops create ./base.nix

purge:
	nixops destroy --all
	nixops delete --all
