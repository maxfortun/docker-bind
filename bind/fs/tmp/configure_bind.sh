#!/bin/bash -ex
SWD=$(dirname $0)

while read pkg; do
	yum install -y $pkg
done <<_EOT_
	epel-release
_EOT_

echo "Installing packages"
while read pkg; do
	yum install -y $pkg
done <<_EOT_
	bind
	bind-utils
_EOT_

systemctl enable named

