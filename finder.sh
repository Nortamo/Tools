for dire in $(find $1 -name "lib"); do
	echo -e "\n In directory $dire"
	echo "--------------------------"
	echo $(ldd $dire/* | grep plum)
	echo "--------------------------"
done
for dire in $(find $1 -name "lib64"); do
	echo -e "\n In directory $dire"
	echo "--------------------------"
	echo $(ldd $dire/* | grep plum)
	echo "--------------------------"
done
