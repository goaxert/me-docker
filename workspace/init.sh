#!/bin/bash

PROJECT_PATH="$1"

if [ "$UID" != "0"  ]; then
    echo "retry with sudo."
    exit 1
fi

if [ ! -d "$PROJECT_PATH/mnt" ]; then
    echo "Create the project directory."
	mkdir -p $PROJECT_PATH

    echo "Create the mnt directory."
	mkdir -p $PROJECT_PATH/mnt

    echo "Create the zsh history."
	mkdir -p $PROJECT_PATH/.zsh_history.d
	touch $PROJECT_PATH/.zsh_history.d/.zsh_history

    echo "Create the .ssh."
	mkdir -p $PROJECT_PATH/.ssh

    echo "Create the .gitconfig file."
	cat << EOF > $PROJECT_PATH/.gitconfig
[user]
  	name = username
  	email = useremail

[alias]
	co = checkout
	st = status
EOF

fi

echo "Complete."
