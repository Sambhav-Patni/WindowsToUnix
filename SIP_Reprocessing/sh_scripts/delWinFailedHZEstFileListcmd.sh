cd /home/sp10228/fasdir
[ -f ./sfilelist ] && rm -f ./sfilelist
[ -f ./delFailedHZEstfile.bat ] && rm -f ./delFailedHZEstfile.bat
sed 's/\/prod\/data\/remote/\\\\prod03nas\\ECDsharePROD/g' /home/sp10228/fasdir/timelogs | tr '/' '\\' | grep "A_~0" | cut -d" " -f1 > sfilelist
awk '{print "del",$0}' sfilelist > delFailedHZEstfile.bat

