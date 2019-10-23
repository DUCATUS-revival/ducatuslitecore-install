#!/bin/bash

script_directory=$PWD
cd ..
current_directory=$PWD
echo "current direcory $current_directory"
echo "creating ducatus node"
/usr/bin/litecore-node create ducatuslitecore
cd ducatuslitecore
workdir=$PWD
echo "installing insight api"
/usr/bin/npm install
/usr/bin/litecore-node install insight-lite-api
/usr/bin/litecore-node install insight-lite-ui
cd node_modules/insight-lite-api
/usr/bin/npm install request@2.81.0 --save
cd $workdir

echo "copying ducatuscoind to $workdir"
cp /usr/local/bin/ducatuscoind $workdir/node_modules/litecore-node/bin/litecoind
cp /usr/local/bin/ducatuscoind $workdir/node_modules/litecore-node/bin/litecoin-0.13.2/bin/litecoind
cp /usr/local/bin/ducatuscoind $workdir/node_modules/.bin/litecoind
cp /usr/local/bin/ducatuscoind /usr/bin/litecoind
cp /usr/local/bin/ducatuscoind /usr/lib/node_modules/litecore-node/bin/litecoind
cp /usr/local/bin/ducatuscoind /usr/lib/node_modules/litecore-node/bin/litecoin-0.13.2/bin/litecoind

echo "applying patches"
/bin/sed -i 's/rpcport: 9332/rpcport: 9690/g' $workdir/node_modules/litecore-node/lib/services/bitcoind.js
node_files=$script_directory/node_files
cp $node_files/network.js $workdir/node_modules/litecore-lib/lib/networks.js
echo "copying config from $node_files"
cp $node_files/bitcoin.conf $workdir/data/bitcoin.conf
cp $node_files/bitcoin.conf $workdir/data/litecoin.conf
cp $node_files/bitcoin.conf $workdir/data/ducatuscoin.conf

echo "installing insight ui"
cd node_modules
rm -rf insight-lite-ui
/usr/bin/git clone https://github.com/DUCATUS-revival/insight-ducatus-ui.git insight-lite-ui
cd insight-lite-ui
/usr/bin/npm install
$workdir/node_modules/insight-lite-ui/node_modules/.bin/bower install --allow-root
$workdir/node_modules/insight-lite-ui/node_modules/.bin/grunt compile

echo "--------------"
echo "build finished"


