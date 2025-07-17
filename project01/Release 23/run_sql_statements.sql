delete from network_receiver where section = 'PAY_MERCHANT';

update PROPERTIES set PROPERTY_VALUE = '01009' where  PROPERTY_NAME = 'sdk.g2.pre.validation.service.pay.merchant.mno.short.code.BOA';
update PROPERTIES set PROPERTY_VALUE = '01013' where PROPERTY_NAME = 'sdk.g2.pre.validation.service.pay.merchant.mno.short.code.EXIM';
update PROPERTIES set PROPERTY_VALUE = '01048' where PROPERTY_NAME = 'sdk.g2.pre.validation.service.pay.merchant.mno.short.code.TCB';


insert into network_receiver (id, editable, network_type, section, status)
values ((select max(id) + 1 from network_receiver), 0, 'VODACOM', 'PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section, status)
values ((select max(id) + 1 from network_receiver), 0, 'AIRTEL','PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section, status)
values ((select max(id) + 1 from network_receiver), 0, 'TIGOPESA', 'PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section, status)
values ((select max(id) + 1 from network_receiver), 0, 'HALOPESA', 'PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section, status)
values ((select max(id) + 1 from network_receiver), 0, 'TPESA', 'PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section, status)
values ((select max(id) + 1 from network_receiver), 0, 'SELCOM', 'PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section, status)
values ((select max(id) + 1 from network_receiver), 0, 'AZAM_PAY', 'PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section, status)
values ((select max(id) + 1 from network_receiver), 0, 'NMB', 'PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section, status)
values ((select max(id) + 1 from network_receiver), 0, 'CRDB', 'PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section, status)
values ((select max(id) + 1 from network_receiver), 0, 'BOA', 'PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section, status)
values ((select max(id) + 1 from network_receiver), 0, 'EXIM', 'PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section, status)
values ((select max(id) + 1 from network_receiver), 0, 'TCB', 'PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section, status)
values ((select max(id) + 1 from network_receiver), 0, 'ECOBANK', 'PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section, status)
values ((select max(id) + 1 from network_receiver), 0, 'AZANIA', 'PAY_MERCHANT', 'LIVE');

update versioning
set version = (select max(version) + 1 from versioning where category_type = 'NETWORK_RECEIVER')
where category_type = 'NETWORK_RECEIVER';