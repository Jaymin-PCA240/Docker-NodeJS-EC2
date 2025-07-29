#!/bin/bash

set -e

REGION="ap-south-1"
REPO="127145910156.dkr.ecr.ap-south-1.amazonaws.com/docker/nodejs"

echo "Logging into Amazon ECR..."
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $REPO

# echo "Stopping and removing any existing container..."
# sudo docker stop my-app || true
# sudo docker rm my-app || true

echo "Pulling latest image..."
sudo docker pull $REPO:latest

echo "Running container..."
sudo docker run -d --name my-app -p 3000:3000 $REPO:latest
