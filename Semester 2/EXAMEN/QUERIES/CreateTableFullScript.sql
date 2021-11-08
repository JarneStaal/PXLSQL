USE master
drop database if exists Teams
create database Teams
USE Teams


PRINT'Creating tables..'
PRINT''

create table Spelers 
(
   spelersnr numeric(5)		constraint sp_nummer_pk	Primary Key IDENTITY,
   naam nvarchar(20)		constraint sp_naam_NN	NOT NULL,
   voorletter char(3),
   geslacht char(1)		default 'M' constraint sp_geslacht_nn NOT NULL, 
   gebdatum DateTime		constraint sp_gebdatum_nn NOT NULL,
   ploegnr numeric(3)
)

PRINT'Spelers created succesfully'

create table Teams
(
	teamnr	numeric(3)		constraint teams_nr_pk	Primary Key NOT NULL IDENTITY,
	teamnaam nvarchar(20)	constraint teams_teamnaam_all_capital	check (teamnaam = UPPER(teamnaam)),
	kapitein numeric(5)		constraint teams_kapitein_fk Foreign Key	references Spelers
)


PRINT'Teams created succesfully'

create table Boetes 
(
	boetenr	numeric(3)		constraint bo_nr_pk			Primary Key NOT NULL IDENTITY,
	spelersnr numeric(5)	constraint bo_spnr_fk		Foreign Key references Spelers,
	datum DateTime			constraint bo_datum_nn		NOT NULL,
	bedrag decimal(7,2)		constraint bo_bedrag_nn NOT NULL

)



PRINT'Boetes created succesfully'


DECLARE @cnt INT = 0;


WHILE @cnt < 50
BEGIN
   INSERT INTO Spelers(naam,voorletter,geslacht,gebdatum,ploegnr)
values
('Marc','M','M', ('11/26/1967'),1),
('Jarne','M','M', ('11/26/1968'),1),
('Jaak','M','M', ('11/26/1961'),2),
('Peter','M','M', ('11/26/1962'),1),
('Bob','M','M', ('11/26/1963'),4),
('Jef','M','M', ('11/26/1965'),1)
   SET @cnt = @cnt + 1;
END;


INSERT INTO Boetes(spelersnr,datum,bedrag)
values(1,'11/24/2001',5000),
(2,'11/24/2001',5000),
(3,'11/24/2001',5000),
(4,'11/24/2001',5000),
(5,'11/24/2001',5000);


INSERT INTO Teams(teamnaam, kapitein)
values('TEAM SPIRIT',1),
('TEAM SPaIRIT',2),
('TEAM SPvIRIT',3),
('TEAM SPdIRIT',4),
('TEAM SzPIRIT',5),
('TEAM SPIgRIT',6),
('TEAM SPsIRIT',7)



select * from Boetes
--Turns of constraint


select * from Boetes
select * from spelers
select * from Teams

ALTER TABLE Boetes
NOCHECK CONSTRAINT bo_datum_nn 


--Removes column voorletter
ALTER TABLE Spelers
DROP COLUMN voorletter


--Drops table boetes
--DROP TABLE Boetes


