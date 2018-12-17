#!/bin/bash

echo "" > /tmp/trie/result-img


find $PWD -type f -name *.jpg >> /tmp/trie/result-img
find $PWD -type f -name *.png >> /tmp/trie/result-img
find $PWD -type f -name *.bmp >> /tmp/trie/result-img
find $PWD -type f -name *.gif >> /tmp/trie/result-img
find $PWD -type f -name *.svg >> /tmp/trie/result-img
find $PWD -type f -name *.tif >> /tmp/trie/result-img


mv `cat /tmp/trie/result-img` subdir/tmp/trie/
