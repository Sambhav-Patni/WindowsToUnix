cd /home/sp10228/fasdir
CurMonth=`date '+%B'`
CurDay=`date '+%d'`
CurYear=`date '+%Y'`
echo $CurDay
if [ $CurDay -eq "01" ] 
then CurDay=1 
#fi
elif [ $CurDay -eq "02" ] 
then CurDay=2 
#fi
elif [ $CurDay -eq "03" ] 
then CurDay=3 
#fi
elif [ $CurDay -eq "04" ] 
then CurDay=4 
#fi
elif [ $CurDay -eq "05" ] 
then CurDay=5 
#fi

elif [ $CurDay -eq "06" ] 
then CurDay=6 
#fi
elif [ $CurDay -eq "07" ] 
then CurDay=7 
#fi
elif [ $CurDay -eq "08" ] 
then CurDay=8 
#fi
elif [ $CurDay -eq "09" ] 
then CurDay=9 
fi

[ -f ./sfilelist ] && rm -f ./sfilelist
[ -f ./moveFailedEstUser1Nas.bat ] && rm -f ./moveFailedEstUser1Nas.bat
sed 's/\/prod\/data\/remote/\\\\prod03nas\\ECDsharePROD/g' /home/sp10228/fasdir/timelogs_HZ_removed | tr '/' '\\' | grep 'Vulcan' | cut -d" " -f1 > sfilelist
awk '{print "move",$0,"\\\\user01nas\\usrtmp\\SIP_Reprocessing\\'$CurYear'\\'$CurMonth'\\'$CurDay'"}' sfilelist > moveFailedEstUser1Nas.bat

