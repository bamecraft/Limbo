#!/usr/bin/bash

# Make sure working directory is correct
cd /server

# Download latest build
fileName=$(curl -fsSL -X 'GET' -H 'accept: application/json' 'https://ci.loohpjames.com/job/Limbo/lastSuccessfulBuild/api/json' | jq -r '.artifacts[1].fileName')
curl -fsSL -o 'limbo.jar' "https://ci.loohpjames.com/job/Limbo/lastSuccessfulBuild/artifact/target/${fileName}"

# Run
java -Xmx500M -Xms500M -jar limbo.jar --nogui
