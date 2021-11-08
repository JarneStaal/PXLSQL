create view vw_medewerkers as
select ( substring(naam,1,1))  + '.'+ dbo.InitCap(voorn) 'NAAM', len(naam) 'LENGTE' from medewerkers

select * from vw_medewerkers;

