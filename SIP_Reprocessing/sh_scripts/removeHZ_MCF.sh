cd /home/sp10228/fasdir
[ -f ./timelogs_HZ_removed ] && rm -f ./timelogs_HZ_removed
grep -v "A_~0" timelogs > timelogs_HZ_removed
