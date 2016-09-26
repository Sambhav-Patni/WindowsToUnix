#DESTNPATH='"`cat target.set`"'
[ -f ./sfilelist ] && rm -f ./sfilelist
[ -f ./moveWinfailedEstfileList.bat ] && rm -f ./moveWinfailedEstfileList.bat
sed 's/\/prod\/data\/remote/\\\\prod03nas\\ECDsharePROD/g' $1 | tr '/' '\\' | grep 'Vulcan' | cut -d" " -f1 > sfilelist
awk '{print "move",$0,"\\\\user01nas\\usrtmp\\SIP_Reprocessing\\Reprocessing_December\\13" }' sfilelist > moveWinfailedEstfileList.bat
#echo DESTNPATH = $DESTNPATH
#export $(DESTNPATH)
#awk '{print "move",$0, $DESTNPATH }' sfilelist > moveWinfailedEstfileList.bat
