#!/bin/bash
set -e

# check for mandatory environment variables and exit if not defined
[[ -z "$SSH_ROOT" ]] && { echo "Please specify SSH_ROOT." ; exit 1; }
[[ -z "$SSH_PRIVATE_KEY" ]] && { echo "Please specify SSH_PRIVATE_KEY." ; exit 1; }
[[ -z "$SSH_PUBLIC_KEY" ]] && { echo "Please specify SSH_PUBLIC_KEY." ; exit 1; }
[[ -z "$SSH_TUNNEL_CMD" ]] && { echo "Please specify SSH_TUNNEL_CMD." ; exit 1; }

# install a SSH client
apk update
apk --no-cache add openssh-client

# move SSH public and private keys (defined in environment variables) into default folders with appropriate permissions
mkdir -p "$SSH_ROOT"
echo "$SSH_PRIVATE_KEY" > $SSH_ROOT/id_rsa
echo "$SSH_PUBLIC_KEY" > $SSH_ROOT/id_rsa.pub
chmod 400 $SSH_ROOT/id_rsa

# actually create the tunnel defined in an environment variable
eval $SSH_TUNNEL_CMD
