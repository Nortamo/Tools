#!/bin/bash -l
for filename in $PWD/*; do
	out=`readelf -d $filename 2> /dev/null | grep "Shared library: \[libncurses"`
	if [ ${#out} -gt 0 ]; then echo $filename;
	fi
done
