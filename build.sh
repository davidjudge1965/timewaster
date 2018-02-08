#!/bin/bash

for folder in `ls -d build/*/`; do
  pushd ${folder}
  echo "\n\nProcessing $PWD\n\n"
  ./build.sh
  popd
done
