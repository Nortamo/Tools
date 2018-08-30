

mkl_path=/appl/opt/cluster_studio_xe2016/compilers_and_libraries_2016.0.109/linux/mkl/lib/intel64_lin/




for filename in $mkl_path*; do
		output=`file $filename | grep shared`
		[[ ! -z $output ]] && MY_LIST="$filename:$MY_LIST"
done

echo $MY_LIST
echo "Done"
