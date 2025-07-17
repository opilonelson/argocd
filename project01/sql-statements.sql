Database changes
Run this SQL statments:
7 (?<!\\d)((\\+|00)?258)?(84|85)\\d{7}(?!\\d);\
8 (?<!\\d)((\\+|00)?255)?[678]\\d{8}(?!\\d);\
9 (?<!\\d)((\\+|00)?266)?[256][1-9]\\d{6}(?!\\d);\
10 (?<!\\d)((\\+|00)?243)?(81|82|84|85|99)\\d{7}(?!\\d)
11
12 service.manager.logging.salt.value=HzeBcQLk2tlua1RFJ74K
13
1 storage.service.logging.hash.regex.pattern=msisdn=(.*?)[,)];Name=(.*?)
[,)];E-mail=(.*?)[,)];"UserName"\s*:\s*"(.*?)";"token"\s*:\s*"
(.*?)";"msisdn"\s*:\s*"(.*?)";"customerNames"\s*:\s*"(.*?)";\
<[^/]*?:KYCValue\>(.*?)\</
2 storage.service.logging.mask.regex.pattern=SecurityCredential=(.*?)
[,)];Password=(.*?)[,)];"identifier"\s*:\s*"(.*?)";"Password"\s*:\s*"
(.*?)";\<[^/]*?:SecurityCredential\>(.*?)\</;\<[^/]*?:Password\>(.*?)\
</;\<[^/]*?:Identifier\>(.*?)\</
3
4 storage.service.logging.sensitive.regex.pattern=\
5 (?<!\\d)((\\+|00)?258)?(84|85)\\d{7}(?!\\d);\
6 (?<!\\d)((\\+|00)?255)?[678]\\d{8}(?!\\d);\
7 (?<!\\d)((\\+|00)?266)?[256][1-9]\\d{6}(?!\\d);\
8 (?<!\\d)((\\+|00)?243)?(81|82|84|85|99)\\d{7}(?!\\d)
9
10 storage.service.logging.salt.value=HzeBcQLk2tlua1RFJ74K


delete from network_receiver where section = 'PAY_MERCHANT';
update PROPERTIES set PROPERTY_VALUE = '01009' where PROPERTY_NAME = 'sdk.g2.pre.validation.service.pay.merchant.mno.short.code.BOA';
update PROPERTIES set PROPERTY_VALUE = '01013' where PROPERTY_NAME = 'sdk.g2.pre.validation.service.pay.merchant.mno.short.code.EXIM';
update PROPERTIES set PROPERTY_VALUE = '01048' where PROPERTY_NAME = 'sdk.g2.pre.validation.service.pay.merchant.mno.short.code.TCB';
insert into network_receiver (id, editable, network_type, section, status)
values ((select max(id) + 1 from network_receiver), 0, 'VODACOM', 'PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section, status) values ((select max(id) + 1 from network_receiver), 0,
'AIRTEL','PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section,
status)
values ((select max(id) + 1 from network_receiver), 0, 'TIGOPESA',
'PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section,
status)
values ((select max(id) + 1 from network_receiver), 0, 'HALOPESA',
'PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section,
status)
values ((select max(id) + 1 from network_receiver), 0, 'TPESA',
'PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section,
status)
values ((select max(id) + 1 from network_receiver), 0, 'SELCOM',
'PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section,
status)
values ((select max(id) + 1 from network_receiver), 0, 'AZAM_PAY',
'PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section,
status)
values ((select max(id) + 1 from network_receiver), 0, 'NMB',
'PAY_MERCHANT', 'LIVE');
24 insert into network_receiver (id, editable, network_type, section,
status)
25 values ((select max(id) + 1 from network_receiver), 0, 'CRDB',
'PAY_MERCHANT', 'LIVE');
26 insert into network_receiver (id, editable, network_type, section,
status)
27 values ((select max(id) + 1 from network_receiver), 0, 'BOA',
'PAY_MERCHANT', 'LIVE');
28 insert into network_receiver (id, editable, network_type, section,
status)
29 values ((select max(id) + 1 from network_receiver), 0, 'EXIM',
'PAY_MERCHANT', 'LIVE');
30 insert into network_receiver (id, editable, network_type, section,
status)
31 values ((select max(id) + 1 from network_receiver), 0, 'TCB',
'PAY_MERCHANT', 'LIVE');
32 insert into network_receiver (id, editable, network_type, section,
status)
33 values ((select max(id) + 1 from network_receiver), 0, 'ECOBANK',
'PAY_MERCHANT', 'LIVE');
insert into network_receiver (id, editable, network_type, section,
status)
values ((select max(id) + 1 from network_receiver), 0, 'AZANIA',
'PAY_MERCHANT', 'LIVE');
update versioningset version = (select max(version) + 1 from versioning where category_type = 'NETWORK_RECEIVER') where category_type = 'NETWORK_RECEIVER'; 