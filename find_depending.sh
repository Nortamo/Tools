#!/bin/bash -l
# Prints the names of the dynamic libraries which depend
# directly on the arguments
for filename in $PWD/*.so*; do
	out=`readelf -d $filename 2> /dev/null | grep "Shared library: \[$1"`
	if [ ${#out} -gt 0 ]; then echo $filename;
	fi
done
