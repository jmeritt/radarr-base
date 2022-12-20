#!/bin/bash
docker buildx build --platform linux/amd64 -t jmeritt/radarr . && docker push jmeritt/radarr && kubectl rollout restart deployment radarr