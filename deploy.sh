#!/bin/zsh
cd ../5site/knowledge.zhaoweiguo.com
git pull
rm -rf ./*
cp -r ../../3gitdoc/index.html .
mkdir build
cp -r ../../3gitdoc/build/html ./build
git add .
git commit -m "[github knowledge]Update changes"  -a
git push