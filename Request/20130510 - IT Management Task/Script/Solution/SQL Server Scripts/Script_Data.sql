USE [USOFT_UAT]
GO

BEGIN TRAN ScriptData123

--** MsMenu
DELETE FROM MsMenu
WHERE MenuId IN (
	'888100',
	'888101',
	'888102',
	'888200',
	'888201',
	'888202'
)
GO

INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (116000,'IT Management',116000,NULL,'TRUE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (116001,'Activity Task',116000,'Modules/IT/ActivityTask.aspx','TRUE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (116002,'Schedule Task',116000,'Modules/IT/ScheduleTask.aspx','TRUE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (116004,'Domain Users',116000,'Modules/IT/DomainUsers.aspx','TRUE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (116100,'Item',116000,NULL,'TRUE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (116101,'Item List',116100,'Modules/IT/Item/ItemList.aspx','TRUE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (116102,'Item Receive',116100,'Modules/IT/Item/ItemIn.aspx','TRUE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (116103,'Item Receive Detail',116100,NULL,'FALSE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (116104,'Item Transfer',116100,'Modules/IT/Item/ItemTrans.aspx','TRUE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (116105,'Item Transfer Detail',116100,NULL,'FALSE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (116106,'Item Out',116100,'Modules/IT/Item/ItemOut.aspx','TRUE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (888001,'Users',888000,'Modules/Master/Users.aspx','TRUE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (888002,'Privilege',888000,'Modules/Master/Privilege.aspx','TRUE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (888003,'Departement',888000,'Modules/Master/Departement.aspx','TRUE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (888004,'Mapping Approval',888000,'Modules/Master/MappingApproval.aspx','TRUE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (888005,'Branch',888000,'Modules/Master/Branch.aspx','TRUE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (888006,'Currency',888000,'Modules/Master/Currency.aspx','TRUE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (888007,'Measurements',888000,'Modules/Master/Measurement.aspx','TRUE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (888008,'Item Group',888000,'Modules/Master/ItemGroup.aspx','TRUE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (888009,'Item Type',888000,'Modules/Master/ItemType.aspx','TRUE',NULL,NULL)
INSERT INTO MsMenu (MenuId,MenuName,MenuParent,MenuLink,IsActive,ReportId,Parameter) VALUES (888010,'Condition',888000,'Modules/Master/Condition.aspx','TRUE',NULL,NULL)
GO


--** MsDepartement
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('00','Board of Director',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('01','Accounting',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('02','Audit',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('03','Board of Director',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('04','C2C',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('05','CBD',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('06','Collection',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('07','Compliance',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('08','Credit Risk Mgt',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('09','Finance',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('10','General Affair',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('11','HRM',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('12','IT',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('13','Legal',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('14','Marketing',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('15','Operation',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('16','Remedial',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('17','Sales',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('18','OOP',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('98','Non Departement',1,GETDATE(),'arie')
insert into MsDepartement(DepartementCode,DepartementName,IsActive,created_date,created_by) VALUES ('99','Branch',1,GETDATE(),'arie')


--** MsPrivilege
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0001','President Director','00',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0002','DPD','00',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0003','Corporate SGM','00',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0101','Manager','01',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0102','Assistant Manager','01',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0103','Supervisor','01',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0104','Staff','01',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0105','Admin','01',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0201','Manager','02',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0202','Assistant Manager','02',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0203','Supervisor','02',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0204','Staff','02',1,'40',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0205','Admin','02',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0301','Manager','03',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0302','Assistant Manager','03',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0303','Supervisor','03',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0304','Staff','03',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0305','Admin','03',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0401','Manager','04',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0402','Assistant Manager','04',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0403','Supervisor','04',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0404','Staff','04',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0405','Admin','04',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0501','Manager','05',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0502','Assistant Manager','05',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0503','Supervisor','05',1,'14',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0504','Staff','05',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0505','Admin','05',1,'16',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0601','Manager','06',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0602','Assistant Manager','06',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0603','Supervisor','06',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0604','Staff','06',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0605','Admin','06',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0701','Manager','07',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0702','Assistant Manager','07',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0703','Supervisor','07',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0704','Staff','07',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0705','Admin','07',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0801','Senior Manager','08',1,'68',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0802','Manager','08',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0803','Assistant Manager','08',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0804','Supervisor','08',1,'130',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0805','Banking Supervisor','08',1,'84',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0806','Staff','08',1,'129',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0807','Admin','08',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0901','Manager','09',1,'1001',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0902','Assistant Manager','09',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0903','Supervisor','09',1,'1005',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0904','Staff','09',1,'1003',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('0905','Admin','09',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1001','Manager','10',1,'1002',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1002','Assistant Manager','10',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1003','Supervisor','10',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1004','Staff','10',1,'1004',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1005','Admin','10',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1101','Manager','11',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1102','Assistant Manager','11',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1103','Supervisor','11',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1104','Staff','11',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1105','Admin','11',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1201','Manager','12',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1202','Assistant Manager','12',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1203','Supervisor','12',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1204','Staff','12',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1205','Admin','12',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1301','Manager','13',1,'85',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1302','Assistant Manager','13',1,'86',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1303','Supervisor','13',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1304','Staff','13',1,'90',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1305','Admin','13',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1306','Assistant Sales','13',1,'122',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1401','Manager','14',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1402','Assistant Manager','14',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1403','Supervisor','14',1,'96',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1404','Planning Staff','14',1,'144',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1405','Staff','14',1,'95',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1406','Admin','14',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1407','Opr Staff Sb Pl','14',1,'148',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1408','AP Payment Officer','14',1,'6',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1409','Service SPV','14',1,'7',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1410','CSO & Insurance Custodian','14',1,'89',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1501','Manager','15',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1502','Assistant Manager','15',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1503','Supervisor','15',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1504','Staff','15',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1505','Admin','15',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1601','Manager','16',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1602','Assistant Manager','16',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1603','Supervisor','16',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1604','Staff','16',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1605','Admin','16',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1701','Manager','17',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1702','Assistant Manager','17',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1703','Supervisor','17',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1704','Staff','17',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1705','Admin','17',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1801','Manager','18',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1802','Assistant Manager','18',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1803','Supervisor','18',1,'4',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1804','Staff','18',1,'5',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1805','Admin','18',1,'131',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('1806','Admin Staff (Only DAP)','18',1,'143',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('9801','Compliance','98',1,'COMP',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('9901','Branch Manager','99',1,'20',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('9902','Deputy Branch Manager','99',1,'49',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('9903','Supervisor','99',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('9904','CMO','99',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('9905','Admin','99',1,NULL,GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('9906','Cashier','99',1,'56',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('9907','Admin SPV','99',1,'4',GETDATE(),'arie')
INSERT INTO MsPrivilege(PrivilegeCode,PrivilegeName,DepartementCode,IsActive,OldCode,created_date,created_by) VALUES ('9999','Guest','99',1,'33',GETDATE(),'arie')
Go


UPDATE a
SET
	a.PrivilegeName = b.DepartementName + ' - ' + a.PrivilegeName
FROM
	MsPrivilege AS a WITH(NOLOCK)
	INNER JOIN MsDepartement AS b WITH(NOLOCK) ON
		a.DepartementCode = b.DepartementCode
GO


--** MsPrivilegeDt
INSERT INTO MsPrivilegeDt(PrivilegeCode,MenuId,InsertDt,UpdateDt,DeleteDt,ViewDt) VALUES ('1103',888000,1,1,1,1)
INSERT INTO MsPrivilegeDt(PrivilegeCode,MenuId,InsertDt,UpdateDt,DeleteDt,ViewDt) VALUES ('1103',888001,1,1,1,1)
INSERT INTO MsPrivilegeDt(PrivilegeCode,MenuId,InsertDt,UpdateDt,DeleteDt,ViewDt) VALUES ('1103',888002,1,1,1,1)
INSERT INTO MsPrivilegeDt(PrivilegeCode,MenuId,InsertDt,UpdateDt,DeleteDt,ViewDt) VALUES ('1103',888003,1,1,1,1)
INSERT INTO MsPrivilegeDt(PrivilegeCode,MenuId,InsertDt,UpdateDt,DeleteDt,ViewDt) VALUES ('1103',888004,1,1,1,1)
INSERT INTO MsPrivilegeDt(PrivilegeCode,MenuId,InsertDt,UpdateDt,DeleteDt,ViewDt) VALUES ('1103',888005,1,1,1,1)
INSERT INTO MsPrivilegeDt(PrivilegeCode,MenuId,InsertDt,UpdateDt,DeleteDt,ViewDt) VALUES ('1103',888006,1,1,1,1)
INSERT INTO MsPrivilegeDt(PrivilegeCode,MenuId,InsertDt,UpdateDt,DeleteDt,ViewDt) VALUES ('1103',888007,1,1,1,1)
INSERT INTO MsPrivilegeDt(PrivilegeCode,MenuId,InsertDt,UpdateDt,DeleteDt,ViewDt) VALUES ('1103',888008,1,1,1,1)
INSERT INTO MsPrivilegeDt(PrivilegeCode,MenuId,InsertDt,UpdateDt,DeleteDt,ViewDt) VALUES ('1103',888009,1,1,1,1)
INSERT INTO MsPrivilegeDt(PrivilegeCode,MenuId,InsertDt,UpdateDt,DeleteDt,ViewDt) VALUES ('1103',888010,1,1,1,1)

--** MsUsers
UPDATE
	MsUsers
SET
	PrivilegeCode = '1103'
WHERE
	UserId = 'arie'


UPDATE a
SET
	a.PrivilegeCode = b.PrivilegeCode
FROM
	MsUsers AS a WITH(NOLOCK)
	INNER JOIN USOFT_DEMO.dbo.MsPrivilege AS b WITH(NOLOCK) ON
		a.PriviledgeCode = b.OldCode


--** MsCurrency
INSERT INTO MsCurrency(currency_code,description,IsActive,created_date,created_by) VALUES ('IDR','INDEX DALAM RUPIAH',1,GETDATE(),'arie')
INSERT INTO MsCurrency(currency_code,description,IsActive,created_date,created_by) VALUES ('SGD','SINGAPORE DOLLAR',1,GETDATE(),'arie')
INSERT INTO MsCurrency(currency_code,description,IsActive,created_date,created_by) VALUES ('USD','US DOLLAR',1,GETDATE(),'arie')
INSERT INTO MsCurrency(currency_code,description,IsActive,created_date,created_by) VALUES ('YEN','JAPAN YEN',1,GETDATE(),'arie')


--** MsMeasurement
INSERT INTO MsMeasurement(measurement_code,description,IsActive,created_date,created_by) VALUES ('kg','Kilo Gram',1,GETDATE(),'arie')
INSERT INTO MsMeasurement(measurement_code,description,IsActive,created_date,created_by) VALUES ('ons','ONS',1,GETDATE(),'arie')
INSERT INTO MsMeasurement(measurement_code,description,IsActive,created_date,created_by) VALUES ('pcs','Pieces',1,GETDATE(),'arie')


--** MsItemGroup
INSERT INTO MsItemGroup(item_group_code,item_group_name,IsActive,created_date,created_by) VALUES ('001','IT',1,GETDATE(),'arie')


--** MsItemType
INSERT INTO MsItemType (item_type_code,item_type_name,item_group_code,price,IsActive,created_date,created_by) VALUES ('IT001','PC','001',0,1,GETDATE(),'arie')
INSERT INTO MsItemType (item_type_code,item_type_name,item_group_code,price,IsActive,created_date,created_by) VALUES ('IT002','Laptop','001',0,1,GETDATE(),'arie')
INSERT INTO MsItemType (item_type_code,item_type_name,item_group_code,price,IsActive,created_date,created_by) VALUES ('IT003','Keyboard','001',0,1,GETDATE(),'arie')
INSERT INTO MsItemType (item_type_code,item_type_name,item_group_code,price,IsActive,created_date,created_by) VALUES ('IT004','Mouse','001',0,1,GETDATE(),'arie')
INSERT INTO MsItemType (item_type_code,item_type_name,item_group_code,price,IsActive,created_date,created_by) VALUES ('IT005','Monitor','001',0,1,GETDATE(),'arie')
INSERT INTO MsItemType (item_type_code,item_type_name,item_group_code,price,IsActive,created_date,created_by) VALUES ('IT006','Scanner','001',0,1,GETDATE(),'arie')
INSERT INTO MsItemType (item_type_code,item_type_name,item_group_code,price,IsActive,created_date,created_by) VALUES ('IT007','Stabilisator','001',0,1,GETDATE(),'arie')
INSERT INTO MsItemType (item_type_code,item_type_name,item_group_code,price,IsActive,created_date,created_by) VALUES ('IT008','UPS','001',0,1,GETDATE(),'arie')


--** MsCondition
INSERT INTO MsCondition(ConditionCode,ConditionName,IsActive,created_date,created_by) VALUES (1,'Normal',1,GETDATE(),'arie')
INSERT INTO MsCondition(ConditionCode,ConditionName,IsActive,created_date,created_by) VALUES (2,'Damaged',1,GETDATE(),'arie')
INSERT INTO MsCondition(ConditionCode,ConditionName,IsActive,created_date,created_by) VALUES (3,'Incomplete',1,GETDATE(),'arie')


--** MsMenuSearch
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116001,1,'Activity No','a.ActivityNo','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116001,2,'User','a.RequestBy','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116002,1,'Schedule No','a.ScheduleNo','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116002,2,'ScheduleTitle','a.ScheduleTitle','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116002,3,'Created By','a.created_by','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116101,1,'Item  Code','A.ITItemCode','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116101,2,'Serial No','A.SerialNo','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116101,3,'Barcode','A.Barcode','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116101,4,'Used By','A.UsedBy','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116102,1,'Item In Code','a.ITItemInCode','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116102,2,'Receive from','a.ReceiveFrom','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116102,3,'PIC','c.UserName','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116103,1,'Item-In Detail Code','a.ITItemInDtlCode','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116103,2,'Type','b.item_type_name','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116103,3,'Serial No','a.SerialNo','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116103,4,'Barcode','a.Barcode','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116103,5,'Condition','c.ConditionName','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116104,1,'Item Transfer Code','a.ITItemTransCode','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116105,1,'Item Trf Detail Code','a.ITItemTransDtlCode','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116105,2,'Item Code','a.ITItemCode','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116105,3,'Type','c.item_type_name','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116105,4,'Serial No','b.SerialNo','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116105,5,'Barcode','b.Barcode','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116105,6,'Condition','d.ConditionName','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116105,7,'Used by','a.UsedBy','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116106,1,'Item Out Code','a.ITItemOutCode','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116106,2,'Item Code','a.ITItemCode','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116106,3,'Serial No','d.SerialNo','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (116106,4,'Vendor Name','a.VendorName','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888001,1,'User ID','UserId','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888001,2,'User Name','UserName','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888002,1,'Privilege Code','a.PrivilegeCode','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888002,2,'Privilege Name','a.PrivilegeName','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888002,3,'Departement Code','b.DepartementCode','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888002,4,'Departement Name','b.DepartementName','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888003,1,'Departement Code','DepartementCode','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888003,2,'Departement Name','DepartementName','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888003,3,'Active State','IsActive','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888004,1,'Menu Name','MenuName','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888004,2,'Privilege Name','PriviledgeName','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888004,3,'Parent Privilege Name','ParentPriviledgeName','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888004,5,'Active State','IsActive','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888005,1,'Branch Id','a.BranchId','int',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888005,2,'Branch Code','a.BranchCode','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888005,3,'Branch Name','a.BranchName','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888005,4,'Branch Type','BranchType','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888005,5,'Branch Parent','b.BranchName','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888005,6,'Active State','IsActive','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888006,1,'Currency code','currency_code','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888006,2,'Description','description','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888006,3,'Active State','IsActive','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888007,1,'Measurement Code','measurement_code','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888007,2,'Description','description','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888008,1,'Group Code','item_group_code','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888008,2,'Group Name','item_group_name','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888009,1,'Type Code','a.item_type_code','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888009,2,'Type Name','a.item_type_name','vch',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888010,1,'Condition Code','ConditionCode','int',1)
INSERT INTO MsMenuSearch (MenuId,SequenceNo,ParamName,ParamField,ParamType,IsActive) VALUES (888010,2,'Condition Name','ConditionName','vch',1)

ROLLBACK TRAN ScriptData123