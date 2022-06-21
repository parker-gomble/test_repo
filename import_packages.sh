#!/bin/bash


echo "1. Downloading assets..."


docker run \
  -it \
  --rm \
  -v $PWD/Assets:/root \
  -w /root \
  -e GITHUB_TOKEN=$GITHUB_TOKEN \
  maniator/gh \
  release download -R GombleLab/base_maintainer_client --pattern '*.unitypackage'

docker run \
  -it \
  --rm \
  -v $PWD/Assets:/root \
  -w /root \
  -e GITHUB_TOKEN=$GITHUB_TOKEN \
  maniator/gh \
  release download -R GombleLab/core_client --pattern '*.unitypackage'

docker run \
  -it \
  --rm \
  -v $PWD/Assets:/root \
  -w /root \
  -e GITHUB_TOKEN=$GITHUB_TOKEN \
  maniator/gh \
  release download -R GombleLab/gameflow_client --pattern '*.unitypackage'

docker run \
  -it \
  --rm \
  -v $PWD/Assets:/root \
  -w /root \
  -e GITHUB_TOKEN=$GITHUB_TOKEN \
  maniator/gh \
  release download -R GombleLab/outgame_client --pattern '*.unitypackage'


echo "2. Importing assets..."


/Applications/Unity/Hub/Editor/2020.3.25f1/Unity.app/Contents/MacOS/Unity \
  -quit \
  -noUpm \
  -nographics \
  -silent-crashes \
  -ignorecompilererrors \
  -batchmode \
  -projectPath ./ \
  -logFile ./Assets/import_base_log.txt \
  -importPackage ./Assets/00.BaseMaintainer.unitypackage

/Applications/Unity/Hub/Editor/2020.3.25f1/Unity.app/Contents/MacOS/Unity \
  -noUpm \
  -nographics \
  -silent-crashes \
  -ignorecompilererrors \
  -batchmode \
  -projectPath ./ \
  -logFile ./Assets/import_packages_log.txt \
  -executeMethod ImportPackage.ImportBasePackages


echo "3. Generating project directory..."


mkdir $PWD/Assets/$DIRECTORY_NAME


echo "4. Generating gitignore..."


echo "# Ignore all
/Assets/*
/[Ll]ibrary/
/[Tt]emp/
/[Oo]bj/
/[Bb]uild/
/[Bb]uilds/
/[Pp]ackages/
/[Pp]rojectSettings/
/[Uu]serSettings/
/.vscode
/.vs
/.vsconfig
/Logs
/Untitled.app/Contents
/build-log
/*.csproj
/*.sln
/*.unitypackage


# Contain files
!/Assets/$DIRECTORY_NAME
!/.gitignore
!/.git
!/README.md" > .gitignore


echo "Complete!"