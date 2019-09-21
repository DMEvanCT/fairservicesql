CREATE database IF NOT EXISTS fw_info ;
USE fw_info;

CREATE TABLE IF NOT EXISTS tbl_work_locations (
    id int auto_increment not null primary key,
    LName varchar(300),
    LType varchar(300),
    LOrg Int,
    LSeats int

);

CREATE TABLE IF NOT EXISTS tbl_organization (
    id int AUTO_INCREMENT not null primary key ,
    Oname varchar(300),
    OTown varchar(300),
    OState varchar(3),
    OType varchar(300)
);

INSERT INTO tbl_organization (Oname, OTown, OState, OType) values ('Durham Fair', 'Durham', 'CT', '501c5');


INSERT INTO tbl_work_locations (LName, LType, LOrg, LSeats) VALUES ('Canfield', 'GATE', (SELECT id FROM tbl_organization WHERE Oname = 'Durham Fair'), 6);
INSERT INTO tbl_work_locations (LName, LType, LOrg, LSeats) VALUES ('Whites Farm', 'GATE', (SELECT id FROM tbl_organization WHERE Oname = 'Durham Fair'), 8);
INSERT INTO tbl_work_locations (LName, LType, LOrg, LSeats) VALUES ('Town Hall', 'GATE', (SELECT id FROM tbl_organization WHERE Oname = 'Durham Fair'), 6);


SELECT * FROM tbl_work_locations;

DROP VIEW vw_wl_to_org;

CREATE VIEW vw_wl_to_org AS
    SELECT LName, LType, LSeats, Oname
FROM tbl_work_locations
LEFT JOIN tbl_organization ON tbl_work_locations.LOrg = tbl_organization.id;


CREATE PROCEDURE proc_addwlocation
(IN FairName CHAR(100), LName CHAR(100),LType CHAR(100), LSeats int )
BEGIN
INSERT INTO tbl_work_locations (LName, LType, LOrg, LSeats) VALUES (LName, LType, (SELECT id FROM tbl_organization WHERE Oname = FairName), LSeats);
end;

call proc_addwlocation('Durham Fair', 'Whites Farm', 'GATE', 8);
call proc_addwlocation('Durham Fair', 'Town Hall', 'GATE', 6);
call proc_addwlocation('Durham Fair', 'Canfield', 'GATE', 6);
call proc_addwlocation('Durham Fair', 'Whites Farm', 'Tickets', 2);


SELECT * FROM tbl_work_locations;
