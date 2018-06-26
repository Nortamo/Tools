#!/bin/bash

#SBATCH -t 00:01:00
#SBATCH --mem=100M
#SBATCH --partition=serial
#SBATCH -N 1 
#SBATCH --ntasks-per-node=1
#SBATCH -n 1

# Script to test ssh connectivity
# for outbound and inbound ssh connections


## Assuming ssh keys have been configured

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

RemoteFile=main.m
IdFile=~/.ssh/id_rsa_taito 
User=nortamh2
RemoteHost=lyta.aalto.fi
SshDest=$User@$RemoteHost
HostFile=testing.out
RemoteCommand="test $HostFile"
OutputFile=report.out
let Res=0

echo > $OutputFile


scp -i $IdFile $SshDest:~/$RemoteFile $TMPDIR


action="Copying file from remote host:"

if [ -f $TMPDIR/$RemoteFile ]; then
	echo -e "$action\t${GREEN}[PASSED]${NC}" >> $OutputFile
else
	echo -e "$action\t${RED}[FAILED]${NC}" >> $OutputFile
fi

mv $TMPDIR/$RemoteFile .

action="Moving file internally:"
if [ -f $RemoteFile ]; then
	echo -e "$action\t\t${GREEN}[PASSED]${NC}" >> $OutputFile
else
	echo -e "$action\t\t${RED}[FAILED]${NC}" >> $OutputFile
fi

action="Copying file to remote host:"

cat << EOF > $TMPDIR/$HostFile
This file was copied to lyta
As part of a test 21.6.2018
-Henkkis
EOF

scp -i $IdFile  $TMPDIR/$HostFile $SshDest:~/


if  ssh -i $IdFile $SshDest $RemoteCommand ; then
	echo -e "$action\t${GREEN}[PASSED]${NC}" >> $OutputFile
	ssh -i $IdFile $SshDest rm $HostFile
else
	echo -e "$action\t${RED}[FAILED]${NC}" >> $OutputFile
fi

rm $TMPDIR/$HostFile $RemoteFile

cat << EOF > short.sh
#!/bin/bash
date
sleep 5
date 
EOF

#run two indentical jobs at the same time 
#parallel -n0 --jobs 2 -m "srun bash short.sh -t 00:00:10 --mem=5M -N 1 -n 1" ::: {1..2}



rm short.sh
