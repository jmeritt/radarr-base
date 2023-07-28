#!/bin/bash
docker buildx build --platform linux/amd64 -t jmeritt/radarr --no-cache . &&\ 
docker push jmeritt/radarr &&\
kubectl rollout restart deployment radarr