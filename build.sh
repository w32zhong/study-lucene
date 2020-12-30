#!/bin/sh
TARGETS=${1-jar-core jar-demo}
set -xe

# java build (compile)
rm -rf build index
ant $TARGETS

# java build (install)
mkdir -p $CLASSPATH && rm -rf $CLASSPATH/*
cp build/*.jar $CLASSPATH
(cd $CLASSPATH && find -name '*.jar' -exec jar -xf {} \;)
