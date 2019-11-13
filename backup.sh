#!/bin/bash

tar cvf one-col-blog.tar --exclude='./node_modules' --exclude='./tmp' --exclude='./log' --exclude='./public/packs' .
gzip one-col-blog.tar

