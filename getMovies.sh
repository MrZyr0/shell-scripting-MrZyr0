#!/bin/bash

find $PWD -type f -name *.mov  >> result-movies
find $PWD -type f -name *.mkv  >> result-movies
find $PWD -type f -name *.avi  >> result-movies
find $PWD -type f -name *.vlog >> result-movies
find $PWD -type f -name *.mp4  >> result-movies
find $PWD -type f -name *.3gp  >> result-movies
