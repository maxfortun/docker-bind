#!/bin/bash -ex

pushd "$(dirname $0)"
SWD=$(pwd)

. $SWD/setenv.sh

if [ -f ~/.ssh/id_rsa.pub ]; then
	echo "Adding ssh key."
	docker exec $NAME bash -c "[ -d /root/.ssh ] || mkdir /root/.ssh && chown -R root:root /root/.ssh"
	docker cp ~/.ssh/id_rsa.pub $NAME:/root/.ssh/authorized_keys
	docker exec $NAME bash -c "chown -R root:root /root/.ssh/authorized_keys; chmod -R og-rwx /root/.ssh/authorized_keys"
fi

