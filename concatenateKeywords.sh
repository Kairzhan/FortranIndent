#!/bin/bash

for word in PROGRAM MODULE FUNCTION SUBROUTINE IF DO ; do
  for f in *.f90; do
    mv $f $f.old
    sed "s/END ${word}/END${word}/Ig" $f.old > $f
    rm -f $f.old
  done
done
