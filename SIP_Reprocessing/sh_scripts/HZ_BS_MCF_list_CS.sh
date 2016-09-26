cd /home/sp10228/fasdir
[ -f ./HZ_BodyShop_MCF_list.txt ] && rm -f ./HZ_BodyShop_MCF_list.txt
[ -f ./CARR_STD_SUCCESS.sql ] && rm -f ./CARR_STD_SUCCESS.sql
grep "A_~0" timelogs | cut -d"/" -f14 | cut -d" " -f1 | cut -d"." -f1 | sed -e "s/.*/#'&'/" | paste -sd, > HZ_BodyShop_MCF_list.txt
awk '{print "select count(1) from app_log a where a.transaction_type=\x27" "20504\x27 and a.mitchell_company_code=\x27" "BS\x27 and a.reviewer_company_code=\x27HZ\x27 and a.process_dt > sysdate -3 and a.work_item_id in (",$0,");\nexit" }' HZ_BodyShop_MCF_list.txt | tr -d '\r' | tr '#' "\r" > CARR_STD_SUCCESS.sql
