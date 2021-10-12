#!/bin/bash

source ~/.profile

cd "$(dirname "${BASH_SOURCE[0]}")"
mkdir -p results

date=$(date +'%d-%m-%Y')
sudo zmap -M udp -p 853 -r 40000 --seed=$RANDOM -b blacklist.txt --probe-args=file:quic_invalid_version.pkt 0.0.0.0/0 -o results/${date}-853.csv

sudo /home/grandera/go/bin/verify-quic -parallel=60 -port853 results/${date}-853.csv results/${date}-verified.csv

sudo zmap -M udp -p 53 -r 40000 --seed=$RANDOM -b blacklist.txt --probe-args=file:dns_53_queryAwww.google.com.pkt 0.0.0.0/0 -o results/${date}-53.csv