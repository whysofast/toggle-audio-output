#!/bin/bash

# Obtem as saidas de audio disponiveis
outputs=$(pactl list sinks | grep "^[[:space:]]Name:[[:space:]]" | cut -d " " -f 2)
firstOutput=$(echo "$outputs" | sed -n 1p)
secondOutput=$(echo "$outputs" | sed -n 2p)
thirdOutput=$(echo "$outputs" | sed -n 3p)

# Obtem a saida de audio atual
currentOutput=$(pactl info | grep "^Default Sink:" | cut -d " " -f 3-)

echo "current output : 
$currentOutput"
echo "---------------------------"

echo "available outputs : 
$outputs"
echo "---------------------------"

# Verifica se ha mais de uma saida de audio disponivel
if [ $(echo "$outputs" | wc -l) -gt 1 ]; then

  if [[ "$currentOutput" == "$secondOutput" ]]; then
    next="$thirdOutput"
  else 
    next="$secondOutput"
  fi

  echo "muda pra $next"
  pactl set-default-sink "$next"
else
  # Se houver apenas uma saida de audio disponivel, muda para a primeira
  echo "muda pra $outputs"
  pactl set-default-sink "$outputs"
fi
