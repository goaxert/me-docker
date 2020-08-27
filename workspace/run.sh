#!/bin/bash

PROJECT_PATH="$1"
PROJECT_NAME="$2"

if [ ! -d "$PROJECT/mnt" ]; then
	echo "sudo ./init.sh [directory]"
	exit 1
fi

docker run \
	-d --rm --name $PROJECT_NAME \
	-p 8023:22 \
	-h $PROJECT_NAME \
	-v $PROJECT_PATH/.zsh_history.d/.zsh_history:/root/.zsh_history.d/.zsh_history \
	-v $PROJECT_PATH/.ssh:/root/.ssh \
	-v $PROJECT_PATH/.gitconfig:/root/.gitconfig \
	-v $PROJECT_PATH/mnt:/root/environment \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-w /root/environment \
	nmops/workspace:1.1
