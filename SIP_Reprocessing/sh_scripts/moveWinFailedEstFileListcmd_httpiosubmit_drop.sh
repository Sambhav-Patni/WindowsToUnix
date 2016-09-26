cd /home/sp10228/fasdir
[ -f ./sfilelist ] && rm -f ./sfilelist
[ -f ./moveFailedEstProd3Nas.bat ] && rm -f ./moveFailedEstProd3Nas.bat
sed 's/\/prod\/data\/remote/\\\\prod03nas\\ECDsharePROD/g' /home/sp10228/fasdir/timelogs_HZ_removed | tr '/' '\\' | grep 'Vulcan' | cut -d" " -f1 > sfilelist
awk '{print "move",$0,"\\\\prod03nas\\ECDsharePROD\\prod\\mitchell\\Vulcan\\E-Claim\\Userdata\\httpiosubmit\\jboss\\drop" }' sfilelist > moveFailedEstProd3Nas.bat
