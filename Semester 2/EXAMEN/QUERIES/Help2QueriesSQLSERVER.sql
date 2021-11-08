select top 100 PERCENT * from medewerkers;

select getdate() 'DATE';

select count(naam) 'COUNT(naam)' from medewerkers;

select sum(mnr) 'SUM(mnr)' from medewerkers;

select min(maandsal) 'MIN(maandsal)' from medewerkers;

select max(maandsal) 'MAX(maandsal)' from medewerkers;

select avg(maandsal) 'AVG(maandsal)' from medewerkers;

select stdev(mnr) from medewerkers;

select ISNULL(chef,1) from medewerkers; 

--Geeft de eerste 2 inschrijvingen en geeft overeenkomend alle 
--rijen die overeenkomen met de laatste rij in de top
SELECT TOP 2 WITH TIES
 cursist, cursus
FROM inschrijvingen
order by cursist