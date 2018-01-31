#!/bin/bash

lex c.l

cc -std=c99 lex.yy.c -o findent -ll
