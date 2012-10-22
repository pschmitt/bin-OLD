#!/bin/bash

###########################################################
## pdf-shrink
## By: Rampage <rampage 'at' twofo 'dot' co 'dot' uk>
##
## License:
##  pdf-shrink is free software you can redistribute it
##  and/or modify it under the terms of the GNU GPL as
##  published by the Free Software Foundation.
##
##  THE AUTHOR(S) IS(ARE) NOT RESPONSIBLE FOR ANYTHING YOU
##  DO WITH THIS PROGRAM
###########################################################

args=$#
argv=( "$@" )

for i in `seq 1 $#`
do
	i=$((i-1))
	var=${argv[$i]}
	if [ "$var" == "-i" ] ; then
		infile=$((i+1))
		infile=${argv[$infile]}
	fi
	if [ "$var" == "-o" ] ; then
		outfile=$((i+1))
		outfile=${argv[$outfile]}
	fi
done

if [ -a "$infile" -a -n "$outfile" ] ; then
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$outfile $infile
	insize=$(du $infile | awk '{print $1}')
	outsize=$(du $outfile | awk '{print $1}')
	sizediff=$((insize-outsize))
	echo "$infile processed, $outfile successfully created.
	File size reduced by `echo $sizediff`Kb"
else
	echo "Usage: $0 [options]
	Example: $0 -i <inputfile> -o <outputfile>
	-i INPUTFILE	The {pdf} file you want to process/shrink
	-o OUTPUTFILE	The destination of the output once processed
	-h HELP		Display this message"
fi

