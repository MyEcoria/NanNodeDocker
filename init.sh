#!/bin/bash

# Chemin complet du dossier
dir="/root/${name}"

# Vérifie si le dossier existe
if [ ! -d "$dir" ]; then
  mkdir "$dir"
  echo "Directory ${dir} created."
else
  echo "Directory ${dir} already exists."
fi

cd "$dir" || { echo "Unable to access directory ${dir}"; exit 1; }

# Création de config-node.toml si il n'existe pas
if [ ! -f "config-node.toml" ]; then
  cat > config-node.toml << EOF
[node]
enable_voting = true
work_threads = 0
receive_minimum = "10000"

[node.websocket]
address = "::ffff:0.0.0.0"
enable = true
port=${WS_PORT}

[rpc]
enable=true
EOF
  echo "config-node.toml created successfully."
else
  echo "File config-node.toml already exists, creation skipped."
fi

# Création de config-rpc.toml si il n'existe pas
if [ ! -f "config-rpc.toml" ]; then
  cat > config-rpc.toml << EOF
port=${RPC_PORT}
address = "::ffff:0.0.0.0"
enable_control = true
EOF
  echo "config-rpc.toml created successfully."
else
  echo "File config-rpc.toml already exists, creation skipped."
fi

nan_node --daemon
