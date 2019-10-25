#!/bin/sh

echo 'Concatenating all pieces...'
cat $(ls -1 ts/*.ts | sort -n ) > all.ts

echo 'Repackaging...'
ffmpeg -i all.ts -acodec copy -vcodec copy -bsf:a aac_adtstoasc $1

