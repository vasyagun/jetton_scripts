#!/bin/bash

apt update && apt install -y git curl screen

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 16

git clone https://github.com/vasyagun/jetton_scripts.git && cd jetton_scripts

npm install

for ((i=0; i<$GPU_COUNT; i++))
do
cat <<EOF > start_gpu_$i.sh
#!/bin/bash
while true; do
  node send_multigpu.js --api $API --bin ./pow-miner-cuda --givers $GIVERS --gpu $i
  sleep 1
done
EOF

chmod +x start_gpu_$i.sh
screen -dmS miner_$i ./start_gpu_$i.sh

done

