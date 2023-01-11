#!/bin/bash

# Obtem a saida de audio atual
outputs=$(pactl list sinks | grep "^[[:space:]]Name:[[:space:]]" | cut -d " " -f 2)
firstOutput=$(echo "$outputs" | sed -n 1p)
secondOutput=$(echo "$outputs" | sed -n 2p)
thirdOutput=$(echo "$outputs" | sed -n 3p)
currentOutput=$(pactl info | grep "^Default Sink:" | cut -d " " -f 3-)
index=0
echo "current output : 
$currentOutput"
echo "---------------------------"
echo "available outputs : 
$outputs"
echo "---------------------------"

stereoLength=42
corsairLength=99

if [[ ${#firstOutput} == ${stereoLength} ]]; then
  stereoOutput="$firstOutput"
elif [[ ${#secondOutput} == ${stereoLength} ]]; then
  stereoOutput="$secondOutput"
elif [[ ${#thirdOutput} == ${stereoLength} ]]; then
  stereoOutput="$thirdOutput"
fi

if [[ ${#firstOutput} == ${corsairLength} ]]; then
  corsairOutput="$firstOutput"
elif [[ ${#secondOutput} == ${corsairLength} ]]; then
  corsairOutput="$secondOutput"
elif [[ ${#thirdOutput} == ${corsairLength} ]]; then
  corsairOutput="$thirdOutput"
fi

# Verifica se ha mais de uma saida de audio disponivel
if [ $(echo "$outputs" | wc -l) -gt 1 ]; then

  if [[ "$currentOutput" == "$stereoOutput" ]]; then
    next="$corsairOutput"
  else 
    next="$stereoOutput"
  fi

  echo "muda pra $next"
  pactl set-default-sink "$next"
else
  # Se houver apenas uma saida de audio disponivel, muda para a primeira
  echo "muda pra primeira"
  pactl set-default-sink "$outputs"
fi
