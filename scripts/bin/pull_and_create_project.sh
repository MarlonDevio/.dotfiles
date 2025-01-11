#!/bin/bash

# company name
industria="industria"

# root
root="${industria}2"

# dir to app
app_dir="./$root/web/app"
plugins_dir="$app_dir/plugins"
theme_dir="$app_dir/themes"

# plugin/theme name(s)
theme="$industria-theme"
activities="$industria-activities"
br="$industria-br"
dashboards="$industria-dashboards"

# full dirs
full_theme_dir="$theme_dir/$theme"
full_activities_dir="$plugins_dir/$activities"
full_br_dir="$plugins_dir/$br"
full_dashboards_dir="$plugins_dir/$dashboards"

create_directory() {
  mkdir -p "$1"
}

clone_repo_in_dir(){
  git clone "https://github.com/MarlonDevio/$1" "$2/."
}

# directory creation

create_directory $root
clone_repo_in_dir $root $root

create_directory $full_theme_dir
clone_repo_in_dir $theme $full_theme_dir

create_directory $full_activities_dir
clone_repo_in_dir "industria-plugin" $full_activities_dir

create_directory $full_br_dir
clone_repo_in_dir $br $full_br_dir

create_directory $full_dashboards_dir
clone_repo_in_dir $dashboards $full_dashboards_dir

cd "./$root" || exit
cd "./mysql" || exit
unzip "wp.sql.zip" 
rm "wp.sql.zip"
cd "../" || exit

docker-compose build
docker-compose up -d
