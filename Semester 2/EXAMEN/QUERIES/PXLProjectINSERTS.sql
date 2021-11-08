insert into project (projectnr, projectomschrijving, budget)
values (1,'VDU',1000),
		(2,'CRT', 800)


insert into AFDELING (afdeling, chef)
values ('ANALY','Johan')

insert into MEDEWERKER (naam, afdeling)
values ('Patricia', 'ANALY')

--insert into PROJECTLIJN (projectnr, mednr, uren)
--values (
--(select projectnr from project where projectomschrijving = 'TTV'),
--(select mednr from medewerker where naam = 'Rudi'),200
--)

--delete from MEDEWERKER where naam = 'Rudi'

PRINT 'INSERT STATEMENTS COMPLETED'