#!/bin/sh

PROJECT="$1"

# if [ ! -d "$HOME/.docker/workspace" ]; then
# 	mkdir -p $HOME/.docker/workspace
# 	mkdir -p $HOME/.docker/workspace/.zsh_history.d
# 	touch $HOME/.docker/workspace/.zsh_history.d/.zsh_history
# fi

if [ ! -f "$PROJECT/mnt" ]; then
	mkdir -p $PROJECT
	mkdir -p $PROJECT/mnt
	mkdir -p $PROJECT/.zsh_history.d
	mkdir -p $PROJECT/.ssh
	touch $PROJECT/.zsh_history.d/.zsh_history

	cat << EOF > $PROJECT/.gitconfig
[user]
  	name = username
  	email = useremail

[alias]
	co = checkout
	st = status
EOF

fi

docker run \
	-d --rm --name workspace \
	-p 8023:22 \
	-h workspace \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v $PROJECT/.zsh_history.d/.zsh_history:/root/.zsh_history.d/.zsh_history \
	-v $PROJECT/.ssh:/root/.ssh \
	-v $PROJECT/.gitconfig:/root/.gitconfig \
	-v $PROJECT/mnt:/root/environment \
	-w /root/environment \
	nmops/workspace:1.0
