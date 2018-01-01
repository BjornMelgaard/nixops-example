BASENAME=$(notdir $(CURDIR:%/=%))

env_build:
	docker build \
		--build-arg APP_DIR="/app" \
		-t="${BASENAME}" \
		.

env_run:
	docker run \
		-it \
		-v ${CURDIR}:/app \
		"${BASENAME}"
