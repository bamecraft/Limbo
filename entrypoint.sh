#!/usr/bin/bash

#cd /server

# Download latest build
fileName=$(curl -s -X 'GET' -H 'accept: application/json' 'https://ci.loohpjames.com/job/Limbo/lastSuccessfulBuild/api/json' | jq '.artifacts[1].fileName')
curl -s -o '/server/limbo.jar' "https://ci.loohpjames.com/job/Limbo/lastSuccessfulBuild/artifacts/${fileName}"

# Run
java -Xmx500M -Xms500M -jar limbo.jar --nogui
