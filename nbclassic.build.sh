#!/bin/bash
chmod +x *.start.sh
podman build -t nbclassic:latest .
podman build -t sshd:latest -f Dockerfile.sshd .
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
podman images