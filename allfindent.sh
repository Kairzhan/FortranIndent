#!/bin/bash

TMPDIR=/tmp/$RANDOM

mkdir -p $TMPDIR

echo "using temp dir:" $TMPDIR

for fortranSource in `ls *.f90`
do
  echo "indenting " $fortranSource "..."
  findent < $fortranSource > $TMPDIR/${fortranSource}
  mv $fortranSource ${fortranSource}.bck
  cp $TMPDIR/${fortranSource} .
done
