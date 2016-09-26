cd /home/sp10228/fasdir
INPUTCCFILE=/home/sp10228/fasdir/config
OUTPUTDIR=/home/sp10228/fasdir/outdir
FILECOUNT=`ls outdir | wc -l`

echo START TIME `date` > timelogs
#[ -f $OUTPUTDIR/* ] && ( rm -f $OUTPUTDIR/* )
test "$FILECOUNT" -gt "0" && rm -f $OUTPUTDIR/*
[ -f /home/sp10228/fasdir/temp2 ] && rm -f /home/sp10228/fasdir/temp2
LIST=`cat $INPUTCCFILE`
#echo $LIST

[ ! -d $OUTPUTDIR ] && mkdir $OUTPUTDIR

for I in $LIST
        do
#        echo $I
        ls $I > temp1
        LISTUSER=`cat temp1`
#        echo $LISTUSER
        for J in $LISTUSER
                do
 #               echo $J
  #             find $I$J -cmin +60 -cmin -10080 -type f -name "*.MCF" >> temp2
                if [ -d $I$J/filecapture_outgoing ]
                then
                        find $I$J/filecapture_outgoing -cmin +60 -cmin -10080 -type f -name "est_*.MCF" >> temp2
                fi
                done
        done

 find /prod/data/remote/prod/mitchell/Vulcan/E-Claim/Userdata/mcmserver/mcfupload -cmin +60 -cmin -10080 -type f -name "est_*.MCF" >> temp2
 find /prod/data/remote/prod/mitchell/Vulcan/E-Claim/Userdata/httpiosubmit/droparchive -cmin +60 -cmin -10080 -type f -name "est_*.MCF" >> temp2
 find /prod/data/remote/prod/mitchell/Vulcan/E-Claim/Userdata/httpiosubmit/drop -cmin +60 -cmin -10080 -type f -name "est_*.MCF" >> temp2
 find /prod/data/remote/prod/mitchell/Vulcan/E-Claim/Userdata/httpiosubmit/jboss/droparchive -cmin +60 -cmin -10080 -type f -name "est_*.MCF" >> temp2
 find /prod/data/remote/prod/mitchell/Vulcan/E-Claim/Userdata/httpiosubmit/jboss/drop -cmin +60 -cmin -10080 -type f -name "est_*.MCF" >> temp2

tnow=`date +%s`
LISTEST=`cat temp2`
for J in $LISTEST
        do
        basename $J > tmpfile
        cut -d"." -f1 tmpfile > tmpfile1
        FILE=`cat tmpfile1`
        echo $J > $OUTPUTDIR/$FILE.txt
        tfile=`date +%s -r $J`
        agesecs=`expr $tnow - $tfile`
        agedays=`expr $agesecs / 86400`
        echo  $J   $agedays days >> timelogs
        done
echo END TIME `date` >> timelogs

