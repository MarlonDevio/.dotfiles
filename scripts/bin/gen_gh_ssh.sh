#!/bin/bash

ssh-keygen -t ed25519 -C "$1" -f ~/.ssh/"$2"

