-- Rollback for network_receiver (restore deleted and remove inserted rows)
delete from network_receiver where section = 'PAY_MERCHANT';
insert into network_receiver
select * from network_receiver_bkp;
-- Rollback for PROPERTIES table (restore previous values)
update PROPERTIES p
set PROPERTY_VALUE = (select b.PROPERTY_VALUE from properties_bkp b where b.PROPERTY_NAME = p.PROPERTY_NAME)
where PROPERTY_NAME in (
    'sdk.g2.pre.validation.service.pay.merchant.mno.short.code.BOA',
    'sdk.g2.pre.validation.service.pay.merchant.mno.short.code.EXIM',
    'sdk.g2.pre.validation.service.pay.merchant.mno.short.code.TCB'
);
-- Rollback for versioning table
update versioning v
set version = (select b.version from versioning_bkp b where b.category_type = v.category_type)
where category_type = 'NETWORK_RECEIVER';




-- etc delete_backup.sql
drop table network_receiver_bkp;
drop table properties_bkp;
drop table versioning_bkp;