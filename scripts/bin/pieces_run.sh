#!/bin/bash

function pieces_run(){
  cd "/Users/marlon/cli-agent/"
  source "/Users/marlon/cli-agent/venv/bin/activate"
  pieces run
}

pieces_run
