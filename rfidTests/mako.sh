#!/bin/sh


export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
g++ -Wno-deprecated -bind_at_load `pkg-config --cflags opencv` $1  -g -o run  `pkg-config --libs opencv`  


