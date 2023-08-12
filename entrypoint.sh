#!/bin/bash

# ---- BEGIN OF CONFIG SECTION ---- #

# Target
artifactName=`curl -s -X 'GET' -H 'accept: application/json' 'https://ci.loohpjames.com/job/Limbo/lastSuccessfulBuild/api/json' | jq -r '.artifacts[1].fileName'`

# Mandatory variables
downloadUrl="https://ci.loohpjames.com/job/Limbo/lastSuccessfulBuild/artifact/target/${artifactName}"
allocatedMemorySize="256M"

# Optional variables
additionalJvmArguments=""
additonalScriptPath=""

# ----- END OF CONFIG SECTION ----- #

##### !! DO NOT EDIT BELOW !! #####

echo 'Executing entrypoint...'

# Check necessary variables are defined
if [ -z ${downloadUrl} ]; then
    echo 'You must write script as downloadUrl variable to download server jar file at config section in entrypoint.sh' >&2
    exit 1
elif [ -z ${allocatedMemorySize} ]; then
    echo 'You must specify allocated memory size for server as allocatedMemorySize variable at config section in entrypoint.sh' >&2
    exit 1
fi

# Make sure we are in correct workdir
cd /server

# Download server jar artifact
echo 'Downloading server jar file...'
curl -fsSL -o /server/server.jar ${downloadUrl}

# Run additonal script if defined
if [ ! -z ${additonalScriptPath} ]; then
    echo 'Executing additonal script...'
    bash -c ${additionalScriptPath}
fi

# Run server
echo 'Booting server...'
java -Xmx${allocatedMemorySize} ${additionalJvmArguments} -jar server.jar nogui
