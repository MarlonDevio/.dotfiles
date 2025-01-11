#!/bin/bash

if [ "$#" -lt 2 ] || [ "$1" != "--app-name" ]; then
    echo "Usage: $0 --app-name [app-name] [optional: base-directory]"
    exit 1
fi

FOLDERNAME=$2

# Bepaal de BASEDIR op basis van het derde argument of gebruik de standaardwaarde
if [ -n "$3" ]; then
  if [ "$3" == "." ]; then
    BASEDIR="."
  else
    BASEDIR="$3"
  fi
else
  BASEDIR="/Users/marlon/Development/webdevelopment/vanilla-js"
fi

mkdir -p "$BASEDIR/$FOLDERNAME"

# Controleer of de directory succesvol is aangemaakt
if [ ! -d "$BASEDIR/$FOLDERNAME" ]; then
    echo "Couldn't create: $BASEDIR/$FOLDERNAME"
    exit 1
fi

# Clone de GitHub repository
git clone https://github.com/MarlonDevio/gsap-project-template.git "$BASEDIR/$FOLDERNAME"

# Controleer of het clonen succesvol was
if [ ! -d "$BASEDIR/$FOLDERNAME/.git" ]; then
    echo "Cloning the repository failed"
    exit 1
fi

# Voer npm install uit in de nieuwe folder
cd "$BASEDIR/$FOLDERNAME"
npm install

# Controleer of npm install succesvol was
if [ $? -ne 0 ]; then
    echo "npm install failed in: $BASEDIR/$FOLDERNAME"
    exit 1
fi

echo "Project successfully created at: $BASEDIR/$FOLDERNAME"

rm -rf .git

echo "gitfolder deleted"
