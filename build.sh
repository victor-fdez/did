#!/usr/bin/env bash

set -e

echo "Building victor755555/did:build"

docker build -t victor755555/did:build . -f Dockerfile.build

docker create --name extract victor755555/did:build  
docker cp extract:/_build/prod/rel/did/releases/0.0.1/did.tar.gz ./did.tar.gz  
docker rm -f extract

echo "Building victor755555/did:latest"

docker build --no-cache -t victor755555/did:latest .
#rm ./kube-traefik
