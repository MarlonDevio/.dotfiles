#!/bin/bash

# Stop bij fouten
set -e


# Definieer variabelen
CURRENT_DIR_NAME=$(basename "$PWD")

PROD_DIR="$CURRENT_DIR_NAME-production"
ZIP_FILE="$CURRENT_DIR_NAME.zip"

# Maak productie directory aan
mkdir -p $PROD_DIR

# Install Node.js dependencies en build assets
npm install
npm run build

# Kopieer alle bestanden naar productie directory, behalve de productie directory zelf
rsync -av --exclude="$PROD_DIR" --exclude='node_modules' --exclude='vendor' --exclude='*.config.js' --exclude='*.lock' --exclude='tests/' ./ $PROD_DIR/

# Ga naar productie directory
cd $PROD_DIR

# Verwijder ongewenste bestanden en directories
rm -rf node_modules
rm -rf vendor
rm -rf .prettierrc .stylelintignore .editorconfig eslint.config.mjs vite.config.js .git package.json package-lock.json postcss.config.js tailwind.config.js scratch.md .stylelintrc.js .gitignore .prettierrc.js .prettierrc.json .prettierrc.yml .prettierrc.yaml .prettierrc.toml .prettierrc.cjs .prettierrc.config.js
rm -f package.sh
rm -f tailwind.config.js composer.lock


# Installeer PHP dependencies zonder dev
composer install --no-dev --optimize-autoloader

# Ga terug naar hoofd directory

# Maak zip bestand
zip -r $ZIP_FILE .
cp $ZIP_FILE ../
cd ..

# Optioneel: Verwijder productie directory na het zippen
rm -rf $PROD_DIR

echo "Build compleet. Plugin verpakt als $ZIP_FILE"
