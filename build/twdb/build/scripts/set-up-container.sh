#!/bin/bash
# ET_DATABASE_LOCATION=${ET_DATABASE_LOCATION:-'localhost:27017'}

echo "Installing Stuff"
echo "apt-get update"
apt-get update
echo "apt-get install curl and apt-utils"
apt-get install --yes curl apt-utils


