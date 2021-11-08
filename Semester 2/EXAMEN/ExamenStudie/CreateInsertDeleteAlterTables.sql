DROP TABLE IF EXISTS medewerkers
-- CREATING DATABASE MEDEWERKERSTWEE 
create table medewerkers
(
	mnr 		NUMBER(4) 		constraint M_PK 			primary key
								constraint M_MNR_CHK 	check (mnr > 7000),
	naam		VARCHAR2(15) 	constraint M_NAAM_NN 	not null,
	voorn 		VARCHAR2(12) 	constraint M_VOORL_NN 	not null,
	functie 	VARCHAR2(10),
	chef 		NUMBER(4) 		constraint M_CHEF_FK 	references medewerkers,
	gbdatum 	DATE 			constraint M_GEBDAT_NN 	not null,
	maandsal 	NUMBER(6,2) 	constraint M_MNDSAL_NN 	not null,
	comm 		NUMBER(6,2),
	afd 		NUMBER(2) 		default 10
								constraint P_AFD_FK 		references afdelingen
);

-- FILLING UP DATABASE MEDEWERKERSTWEE

INSERT INTO medewerkerstwee (mnr, naam,voornaam,functie,chef,gbdatum,maandsal)
VALUES(7001,'STAAL','JARNE','PROGRAMMEUR','7485',date '2021-05-23',5400)

