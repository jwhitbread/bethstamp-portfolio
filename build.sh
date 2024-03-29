#!/bin/bash

# Get environment
read -p 'Environment? (dev/prod): ' envvar

if [ "${envvar,,}" = "dev" ];
then
	setenvvar=dev
	setgitcommitvar=dev
fi

if [ "${envvar,,}" = "prod" ];
then
  git checkout main
  git pull
	setenvvar=latest
fi

if [ "${envvar,,}" = "dev" ];
then
        read -p 'Git commit message?: ' gitcommitvar

	# Checkout dev and push to github
	git checkout $setgitcommitvar
	git commit -am "$gitcommitvar"
	git push
fi

# Build docker image
docker build -t jwhitbread/bethstamp-portfolio:$setenvvar .

# Push docker image to Dockerhub
docker push jwhitbread/bethstamp-portfolio:$setenvvar
