#!/bin/bash

# Go to node directory
mkdir ${name}
cd /root/${name}

# Create config-node.toml file
cat > config-node.toml << EOF
[node]
enable_voting = true
work_threads = 0

[node.websocket]
address = "::ffff:0.0.0.0"
enable = true
port=${WS_PORT}

[rpc]
enable=true
EOF

echo "config-node.toml created successfully with enable_voting=true and rpc enabled and ws enabled on port ${WS_PORT}"

# Create config-rpc.toml file
cat > config-rpc.toml << EOF
port=${RPC_PORT}
address = "::ffff:0.0.0.0"
enable_control = true
EOF

echo "config-rpc.toml created successfully with port=${RPC_PORT} (from RPC_PORT environment variable)"
nan_node --daemon