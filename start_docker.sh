#!/bin/bash
#build docker iamge using the Dockerfile base image + litecoind app called litecoind:krakentest and start the cointainer without any parameters ( console output )
docker build -t litecoind:krakentest . && docker run --name litecoind litecoind:krakentest
