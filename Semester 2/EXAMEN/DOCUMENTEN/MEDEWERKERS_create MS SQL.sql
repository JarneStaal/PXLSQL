


--CREATE TABLE MEDEWERKERS TABLE
		create table  medewerkers
		(mnr          INT    constraint M2_PK        primary key
								   constraint M2_MNR_CHK   check (mnr > 7000)
		,naam         VARCHAR(15) constraint M2_NAAM_NN   not null
		,voorn        VARCHAR(12)  constraint M2_VOORL_NN  not null
		,functie      VARCHAR(10)
		,chef         INT    constraint M2_CHEF_FK   references medewerkers
		,gbdatum      DATETIME        constraint M2_GEBDAT_NN not null
		,maandsal     DECIMAL(6,2)  constraint M2_MNDSAL_NN not null
		,comm         DECIMAL(6,2)
		,afd          INT    default 10
		,constraint   M2_VERK_CHK   check (case functie when 'VERKOPER' then 0 else 1 end +
						  case   when comm IS NULL      then 0 else 1 end = 1)
		)


--CREATE TABLE AFDELINGEN
		create table afdelingen
		(anr     INT    constraint A2_PK       primary key
							  constraint A2_ANR_CHK  check ( (anr %10) = 0 )
		,naam    VARCHAR(20) constraint A2_NAAM_NN  not null
							  constraint A2_NAAM_UN  unique
							  constraint A2_NAAM_CHK check (naam    = upper(naam)   )
		,locatie VARCHAR(20) constraint A2_LOC_NN   not null
							  constraint A2_LOC_CHK  check (locatie = upper(locatie))
		,hoofd   INT    constraint A2_HOOFD_FK references medewerkers
		)


-- CREATE REFERENCE MEDEWERKERS.AFD --> AFDELINGEN.ANR
		alter table medewerkers
		add   constraint M2_AFD_FK foreign key (afd) references afdelingen;


-- CRATE TABLE SCHALEN
		create table schalen
		(snr          INT    constraint S2_PK         primary key
		,ondergrens   DECIMAL(6,2)  constraint S2_ONDER_NN   not null
								   constraint S2_ONDER_CHK  check (ondergrens >= 0)
		,bovengrens   DECIMAL(6,2)  constraint S2_BOVEN_NN   not null
		,toelage      DECIMAL(6,2)  constraint S2_TOELG_NN   not null
		,constraint   S2_OND_BOV    check ( ondergrens  <=  bovengrens )
		)


-- CREATE TABLE CURSUSSEN
		create table  cursussen
		(code         VARCHAR(4)  constraint C2_PK        primary key
		,omschrijving VARCHAR(50) constraint C2_OMSCHR_NN not null
		,type         CHAR(3)      constraint C2_TYPE_NN   not null
		,lengte       INT    constraint C2_LENGTE_NN not null
		,constraint   C2_CODE_CHK   check (code  =  upper(code)       )
		,constraint   C2_TYPE_CHK   check (type in ('ALG','BLD','DSG'))
		)

		
-- CREATE TABLE UITVOERINGEN
		create table  uitvoeringen
		(cursus       VARCHAR(4)  constraint U2_CURSUS_NN not null
								   constraint U2_CURSUS_FK references cursussen
		,begindatum   DATETIME         constraint U2_BEGIN_NN  not null
		,docent       INT    constraint U2_DOCENT_FK references medewerkers
		,locatie      VARCHAR(20)
		,constraint   U2_PK         primary key (cursus,begindatum)
		)


-- CREATE TABLE INSCHRIJVINGEN
		create table  inschrijvingen
		(cursist      INT    constraint  I2_CURSIST_NN not null
								   constraint  I2_CURSIST_FK references medewerkers
		,cursus       VARCHAR(4)  constraint  I2_CURSUS_NN  not null
		,begindatum   DATETIME         constraint  I2_BEGIN_NN   not null
		,evaluatie    INT    constraint  I2_EVAL_CHK
								   check       (evaluatie in (1,2,3,4,5) )
		,constraint   I2_PK         primary key (cursist,cursus,begindatum)
		,constraint   I2_UITV_FK    foreign key (cursus,begindatum)
								   references  uitvoeringen
		)