#!/bin/bash

# prebuild
echo "Installing curl and NodeJS"
/usr/bin/apt install -y curl git
/usr/bin/curl -sL https://deb.nodesource.com/setup_8.x | /bin/bash -
/usr/bin/apt install -y nodejs

echo "Installing litecore-node"
/usr/bin/npm install -g litecore-node@latest --unsafe-perm=true
echo "Installing bower and grunt"
/usr/bin/npm install -g bower --unsafe-perm=true
/usr/bin/npm install -g grunt --unsafe-perm=true

echo "prebuild done"
