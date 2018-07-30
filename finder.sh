# search for $2 in all dynamic libraries
# under $1 in directories named lib or lib64
for dire in $(find $1 -name "lib"); do
	echo -e "\n In directory $dire"
	echo "--------------------------"
	echo $(ldd $dire/*.so* | grep $2)
	echo "--------------------------"
done
for dire in $(find $1 -name "lib64"); do
	echo -e "\n In directory $dire"
	echo "--------------------------"
	echo $(ldd $dire/*.so* | grep $2)
	echo "--------------------------"
done
