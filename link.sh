#!/bin/bash

items=(normal architecture protocol newtech cloudnative db devops lang open secure sys testing);
shares=(_static _themes images files plantuml.jar conf.py);

for item in ${items[@]}
do
  echo "===>"$item
  cd source-$item
  for share in ${shares[@]}
  do
    rm $share
    ln -s ../0shares/$share .
  done
  cd ..
done
