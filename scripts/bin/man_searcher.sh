#!/bin/bash

man "$1" | col -bx | fzf 
