#!/bin/bash

# Correct permission fix
sudo chown -R ec2-user:ec2-user /home/ec2-user/app

set -e

REGION="ap-south-1"
REPO="127145910156.dkr.ecr.ap-south-1.amazonaws.com/docker/nodejs"

echo "Logging into Amazon ECR..."
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $REPO

echo "Stopping and removing any existing container..."
docker stop my-app || true
docker rm my-app || true

echo "Pulling latest image..."
docker pull $REPO:latest

echo "Running container..."
docker run -d --name my-app -p 3000:3000 $REPO:latest
