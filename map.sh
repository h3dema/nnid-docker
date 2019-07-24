#!/bin/bash
sudo umount docker

if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
    echo "$0 <last IP octed>"
    echo "eg, $0 2 to connect to 172.17.0.2"
fi

if [ ! -d "docker" ]; then
	mkdir docker
fi

sudo sshfs -o allow_other root@172.17.0.$1:/root/nni docker

