#!/bin/bash

# generate secure secret
export SHARED_SECRET=$(openssl rand -hex 48)

for f in /startup/*; do
    echo "[+] running $f"
    bash "$f"
done

tail -f /var/log/ctf/*
