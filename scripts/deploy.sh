#!/bin/bash

set -e

IMAGE_NAME="cloud-monitoring-app"
CONTAINER_NAME="cloud-monitoring-app"

echo "=== Building Docker image ==="

docker build -t "$IMAGE_NAME" ./app

echo "=== Removing previous container ==="

docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

echo "=== Starting new container ==="

docker run -d \
    --name "$CONTAINER_NAME" \
    -p 5001:5001 \
    "$IMAGE_NAME"

echo "=== Waiting for application ==="

sleep 3

echo "=== Running health check ==="

if docker exec "$CONTAINER_NAME" \
    python -c "import urllib.request; urllib.request.urlopen('http://localhost:5001/health')" \
    >/dev/null 2>&1; then

    echo "Health check PASSED!"
else
    echo "Health check FAILED!"

    echo "=== Container logs ==="
    docker logs "$CONTAINER_NAME"

    exit 1
fi

echo "=== Deployment successful ==="

docker ps --filter "name=$CONTAINER_NAME"
