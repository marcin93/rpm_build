#!/usr/bin/bash
# build.sh — builds the hello-world RPM inside a Rocky Linux container
# and copies the resulting .rpm to ./dist/

set -euo pipefail

IMAGE_NAME="hello-world-rpm-builder"
OUTPUT_DIR="$(pwd)/dist"

echo "==> Building Docker image..."
docker build -t "$IMAGE_NAME" .

echo "==> Extracting RPM from container..."
mkdir -p "$OUTPUT_DIR"

# Run the container, copy out the RPM
CONTAINER_ID=$(docker create "$IMAGE_NAME")
docker cp "$CONTAINER_ID":/root/rpmbuild/RPMS/noarch/. "$OUTPUT_DIR/"
docker rm "$CONTAINER_ID"

echo ""
echo "==> Done. RPM available in: $OUTPUT_DIR"
ls -lh "$OUTPUT_DIR"/*.rpm
echo ""
echo "==> To install on a Rocky Linux system:"
echo "    sudo rpm -ivh $OUTPUT_DIR/hello-world-*.rpm"
echo ""
echo "==> To verify service after install:"
echo "    sudo systemctl status hello-world"
echo "    sudo journalctl -u hello-world -f"
