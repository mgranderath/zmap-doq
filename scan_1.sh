#!/bin/bash

source ~/.profile

cd "$(dirname "${BASH_SOURCE[0]}")"
mkdir -p results

date=$(date +'%d-%m-%Y')
sudo zmap -M udp -p 784 -r 40000 --seed=$RANDOM -b blacklist.txt --probe-args=file:quic_invalid_version.pkt 0.0.0.0/0 -o results/${date}-784.csv
sudo zmap -M udp -p 8853 -r 40000 --seed=$RANDOM -b blacklist.txt --probe-args=file:quic_invalid_version.pkt 0.0.0.0/0 -o results/${date}-8853.csv

python3 merge.py results/${date}-784.csv results/${date}-8853.csv results/${date}-combined.csv
sudo $HOME/go/bin/verify-quic -parallel=60 results/${date}-combined.csv results/${date}-verified.csv