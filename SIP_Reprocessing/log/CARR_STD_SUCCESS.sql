select count(1) from app_log a where a.transaction_type='20504' and a.mitchell_company_code='BS' and a.reviewer_company_code='HZ' and a.process_dt > sysdate -3 and a.work_item_id in ( 
exit