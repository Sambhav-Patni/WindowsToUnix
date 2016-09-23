SET HEADING OFF FEEDBACK OFF ECHO OFF TRIMSPOOL ON PAGESIZE 0 
SPOOL LSDB.txt 
select filename from ief_claim where full_filename like '/prod/mis/iinfo/dat/load/0922/20160922.h07%'; 
SPOOL OFF 
exit 
