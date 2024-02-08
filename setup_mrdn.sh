#!/bin/bash

# Переменные, передаваемые пользователем
SEED="${SEED}"
TOKEN="${TOKEN}"
GPU_COUNT="${GPU_COUNT}"
API="${API}"
GIVERS="${GIVERS}"

# Установка необходимых пакетов
apt update && apt install -y curl git screen

# Установка Node.js
curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt-get install -y nodejs

# Клонирование и настройка майнера
git clone https://github.com/TrueCarry/JettonGramGpuMiner.git
cd JettonGramGpuMiner

# Создание конфигурационного файла
echo "SEED=$SEED" > config.txt
echo "TONAPI_TOKEN=$TOKEN" >> config.txt

npm install

# Создание скриптов майнинга для каждого GPU
for ((i=0; i<$GPU_COUNT; i++))
do
    echo "Запуск майнера для GPU $i"
    screen -dmS miner_$i bash -c "while true; do node send_universal.js --api $API --bin ./pow-miner-cuda --givers $GIVERS --gpu $i; sleep 1; done"
done

