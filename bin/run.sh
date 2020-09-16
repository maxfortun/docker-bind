#!/bin/bash -ex

pushd "$(dirname $0)"
SWD=$(pwd)
BWD=$(dirname "$SWD")

. $SWD/setenv.sh

RUN_IMAGE="$REPO/$NAME"

# Publish exposed ports
imageId=$(docker images --format="{{.Repository}} {{.ID}}"|grep "^$RUN_IMAGE "|awk '{ print $2 }')
while read port; do
	hostPort=$DOCKER_PORT_PREFIX${port%%/*}
	[ ${#hostPort} -gt 5 ] && hostPort=${hostPort:${#hostPort}-5}
	DOCKER_RUN_ARGS+=( -p $hostPort:$port )
done < <(docker image inspect -f '{{json .Config.ExposedPorts}}' $imageId|jq -r 'keys[]')

# Mount volumes
#while read mnt; do 
#done < <(ls $BWD/mnt)

DOCKER_RUN_ARGS+=( -v $BWD/mnt/etc/named:/etc/named )
DOCKER_RUN_ARGS+=( -v $BWD/mnt/etc/named.conf:/etc/named.conf )
DOCKER_RUN_ARGS+=( -v $BWD/mnt/etc/named.conf.local:/etc/named.conf.local )

docker stop $NAME || true
docker system prune -f
docker run -d -it --privileged --cap-add=NET_ADMIN --cap-add=MKNOD --tmpfs /run "${DOCKER_RUN_ARGS[@]}" --name $NAME $RUN_IMAGE:$VERSION $*

$SWD/add_ssh_key.sh

echo "Attaching to container. To detach CTRL-P CTRL-Q."
docker attach $NAME
