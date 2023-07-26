#!/bin/bash
set -eux

if [ $# != 1 ] && [ $# != 2 ]; then
    echo "usage: ./local_test.sh ThisHostIPAddress [unit|landing]"
    exit
fi

address=$1
echo $address

if [ $# = 1 ]; then
    option="unit"
elif [ $# = 2 ]; then
    if [ $2 == "landing" ]; then
        option="landing"
    elif [ $2 == "unit" ]; then
        option="unit"
    else
        if [ $2 != "landing" ]; then
            echo "usage: ./local_test.sh ThisHostIPAddress [unit|landing]"
            exit
        fi
    fi
fi
echo $option


git checkout ./server/seller/src/url.ts
git checkout ./server/landing/src/create_session.ts
sed -i "s/zeroidentify.com/$address:4433/g" ./server/seller/src/url.ts
sed -i "s/zeroidentify.com/$address/g" ./server/landing/src/create_session.ts
sed -i "s/secure: false,/secure: true,/g" ./server/landing/src/create_session.ts

if [ $option = "landing" ]; then
    git checkout ./server/landing/src/public/index.html
    sed -i "s/zeroidentify.com/$address:4433/g" ./server/landing/src/public/index.html
fi

ps aux | grep webpack| grep -v grep | awk '{ print "kill -9", $2 }' | sh

cd ./client/identify/
    ./run.sh &
cd ../../

cd ./client/identifycore/
    ./run.sh &
cd ../../

cd ./client/secure/
    ./run.sh &
cd ../../

ps aux | grep "node ./src/proxy.js" | grep -v grep | awk '{ print "kill -9", $2 }' | sh

cd ./client/proxy/
    ./run.sh &
cd ../../

echo "proxy start end"

if [ $option = "landing" ]; then
    cd ./server/landing/
    ./run.sh 44300
else
    echo "cd seller"
    cd ./server/seller/
    ./run.sh 44300
fi

echo "allfinish"

