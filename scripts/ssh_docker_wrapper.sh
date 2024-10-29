#!/bin/bash

LEVEL=$(whoami)

HOST=linux
CONTAINER_NAME="$LEVEL"_"$(date | sha1sum | awk '{print $1}' | cut -c 1-7)"

docker run --rm --name $CONTAINER_NAME \
	-v "/home/davesaah/codes/linux-ctf/scripts/levels/$LEVEL:/home/$HOST/ctf" \
	--hostname $LEVEL \
	--user $HOST -it level
