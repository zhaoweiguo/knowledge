#!/bin/sh
cd `dirname $0`
rm ./var/* -rf


# +A 8 \
exec erl \
  +P 10240000 \
  +K true \
  -name {{NAME}} \
  +zdbbl 8192 \
  -pa $PWD/_build/default/lib/*/ebin \
  -config ./config/{{CONFIG}}_octopus.config \
  -boot start_sasl -s reloader -s octopus -setcookie XEXIWPUHUJTYKXFMMTXE