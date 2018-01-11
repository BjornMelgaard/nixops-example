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

nixops_create:
	nixops create ./base.nix

nixops_purge:
	nixops destroy --all
	nixops delete --all
