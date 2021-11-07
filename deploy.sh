#!/bin/bash

docker build -t golubev89/multi-client:latest -t golubev89/multi-client:$SHA -f ./client/Dockerfile ./client

docker build -t golubev89/multi-server:latest -t golubev89/multi-server:$SHA -f ./server/Dockerfile ./server

docker build -t golubev89/multi-worker:latest -t golubev89/multi-worker:$SHA -f ./worker/Dockerfile ./worker


docker push golubev89/multi-client:latest
docker push golubev89/multi-client:$SHA

docker push golubev89/multi-server:latest
docker push golubev89/multi-server:$SHA

docker push golubev89/multi-worker:latest
docker push golubev89/multi-worker:$SHA


kubectl apply -f k8s

kubectl set image deployments/client-deployment client=golubev89/multi-client:$SHA
kubectl set image deployments/server-deployment server=golubev89/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=golubev89/multi-worker:$SHA
