TAG = rvannauker/checkmarx
VERSION = 1.0.0
FILE_NAME = checkmarx.dockerfile
DESTINATION = .
DEBUG_COMMAND = /bin/bash
MICROBADGE_HOOK_URL = https://hooks.microbadger.com/images/rvannauker/checkmarx/o8CNLYKJ5uDAVbKWF6rcBqmeKeI=
SERVER =
PROJECT_NAME =
USERNAME =
PASSWORD =
LOCATION_TYPE =
LOCATION_PATH =
EXCLUDE_PATHS =

default: build

build:
	docker build \
	       --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
	       --build-arg VCS_REF="$(git rev-parse --short HEAD)" \
	       --build-arg VERSION="$(VERSION)" \
	       --no-cache=true \
	       --force-rm=true \
	       --pull=true \
	       --tag "$(TAG):$(VERSION)" \
	       --file $(FILE_NAME) \
	       $$PWD

build_latest:
	docker build \
	       --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
	       --build-arg VCS_REF="$(git rev-parse --short HEAD)" \
	       --build-arg VERSION="latest" \
	       --no-cache=true \
	       --force-rm=true \
	       --pull=true \
	       --tag "$(TAG):latest" \
	       --file $(FILE_NAME) \
	       $$PWD

push:
	docker push $(TAG)

debug:
	docker run \
	       --rm \
	       --interactive \
	       "$(TAG)$(VERSION)" $(DEBUG_COMMAND)

run:
	@docker run \
	        --rm \
            --volume $$PWD:/usr/src \
            --net=host \
            --name "checkmarx" \
            "$(TAG):$(VERSION)" \
            Scan \
            -CxServer $(SERVER) \
            -ProjectName $(PROJECT_NAME) \
            -CxUser $(USERNAME) \
            -CxPassword $(PASSWORD) \
            -Incremental \
            -LocationType $(LOCATION_TYPE) \
            -LocationPath $(LOCATION_PATH) \
            -LocationPathExclude "$(EXCLUDE_PATHS)" \
            -v

microbadge_hook:
	curl -X POST $(MICROBADGE_HOOK_URL)

release: build build_latest push microbadge_hook