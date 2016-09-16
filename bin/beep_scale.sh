#!/bin/sh

FREQUENCIES="261.6 277.2 293.7 311.1 329.6 349.2 370 392 415 440 466.2 493.9 523.2" 

for freq in $FREQUENCIES
do 
	beep -f $freq -l 50 -D 50
done 
