

# Prints a list of all shared libraries in the directory

echo $1
for filename in $1*; do
		output=`file $filename | grep shared`
		[[ ! -z $output ]] && MY_LIST="$filename:$MY_LIST"
done

echo $MY_LIST
