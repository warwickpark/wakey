#!/bin/bash

# Define the binary name
BINARY_NAME="wakey"

# Detect OS
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
case "$OS" in
  linux)  GOOS="linux" ;;
  darwin) GOOS="darwin" ;;
  *)
    echo "Unsupported OS: $OS"
    exit 1
    ;;
esac

# Detect architecture
ARCH=$(uname -m)
case "$ARCH" in
  x86_64|amd64)  GOARCH="amd64" ;;
  aarch64|arm64)  GOARCH="arm64" ;;
  *)
    echo "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

echo "Building for $GOOS/$GOARCH..."

# Build the Go binary
GOOS=$GOOS GOARCH=$GOARCH go build -o $BINARY_NAME

# Check if the build was successful
if [ $? -ne 0 ]; then
    echo "Build failed. Exiting."
    exit 1
fi

# Move the binary to /usr/local/bin
mv $BINARY_NAME /usr/local/bin/

# Verify if the binary was moved successfully
if [ $? -eq 0 ]; then
    echo "$BINARY_NAME has been successfully installed in /usr/local/bin."
else
    echo "Failed to move $BINARY_NAME to /usr/local/bin."
    exit 1
fi
