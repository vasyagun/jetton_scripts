#!/bin/bash

apt update && apt install -y curl git screen

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 16

git clone https://github.com/TrueCarry/JettonGramGpuMiner.git
cd JettonGramGpuMiner
echo "SEED=$SEED" > config.txt
echo "TONAPI_TOKEN=$TONAPI_TOKEN" >> config.txt
npm install

screen -dmS mining bash -c "node send_multigpu.js --api $API_TYPE --bin ./pow-miner-cuda --givers 1000 --gpu-count $GPU_COUNT"

