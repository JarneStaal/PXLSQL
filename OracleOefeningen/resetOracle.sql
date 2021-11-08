REM ======================================================================
REM SQL*Plus script crecase2015.sql: maakt de casustabellen (met constraints)
REM ======================================================================

-- ----------------------------------------------------------------------
-- Opstarten    : @ "C:\oracle\product\10.2.0\db_1\BIN\crecase2015.sql"
--                @ "C:\Documents and Settings\Administrator\Desktop\crecase2015.sql"
-- ----------------------------------------------------------------------


drop   table  medewerkers cascade constraints;


create table  medewerkers
(mnr          NUMBER(4)    constraint M2_PK        primary key
                           constraint M2_MNR_CHK   check (mnr > 7000)
,naam         VARCHAR2(15) constraint M2_NAAM_NN   not null
,voorn        VARCHAR2(12)  constraint M2_VOORL_NN  not null
,functie      VARCHAR2(10)
,chef         NUMBER(4)    constraint M2_CHEF_FK   references medewerkers
,gbdatum      DATE        constraint M2_GEBDAT_NN not null
,maandsal     NUMBER(6,2)  constraint M2_MNDSAL_NN not null
,comm         NUMBER(6,2)
,afd          NUMBER(2)    default 10
,constraint   M2_VERK_CHK   check (decode(functie,'VERKOPER',0,1) +
				  decode(comm   , NULL     ,0,1) = 1)
);

REM ====================================================================
drop   table afdelingen cascade constraints;

create table afdelingen
(anr     NUMBER(2)    constraint A2_PK       primary key
                      constraint A2_ANR_CHK  check ( mod(anr,10) = 0 )
,naam    VARCHAR2(20) constraint A2_NAAM_NN  not null
                      constraint A2_NAAM_UN  unique
                      constraint A2_NAAM_CHK check (naam    = upper(naam)   )
,locatie VARCHAR2(20) constraint A2_LOC_NN   not null
                      constraint A2_LOC_CHK  check (locatie = upper(locatie))
,hoofd   NUMBER(4)    constraint A2_HOOFD_FK references medewerkers
);

REM ====================================================================
alter table medewerkers
add   (constraint M2_AFD_FK foreign key (afd) references afdelingen);

REM ====================================================================
drop   table schalen cascade constraints;

create table schalen
(snr          NUMBER(2)    constraint S2_PK         primary key
,ondergrens   NUMBER(6,2)  constraint S2_ONDER_NN   not null
                           constraint S2_ONDER_CHK  check (ondergrens >= 0)
,bovengrens   NUMBER(6,2)  constraint S2_BOVEN_NN   not null
,toelage      NUMBER(6,2)  constraint S2_TOELG_NN   not null
,constraint   S2_OND_BOV    check ( ondergrens  <=  bovengrens )
);

REM ====================================================================
drop   table  cursussen cascade constraints;

create table  cursussen
(code         VARCHAR2(4)  constraint C2_PK        primary key
,omschrijving VARCHAR2(50) constraint C2_OMSCHR_NN not null
,type         CHAR(3)      constraint C2_TYPE_NN   not null
,lengte       NUMBER(2)    constraint C2_LENGTE_NN not null
,constraint   C2_CODE_CHK   check (code  =  upper(code)       )
,constraint   C2_TYPE_CHK   check (type in ('ALG','BLD','DSG'))
);

REM ====================================================================
drop   table  uitvoeringen cascade constraints;

create table  uitvoeringen
(cursus       VARCHAR2(4)  constraint U2_CURSUS_NN not null
                           constraint U2_CURSUS_FK references cursussen
,begindatum   DATE         constraint U2_BEGIN_NN  not null
,docent       NUMBER(4)    constraint U2_DOCENT_FK references medewerkers
,locatie      VARCHAR2(20)
,constraint   U2_PK         primary key (cursus,begindatum)
);

REM ====================================================================
drop   table  inschrijvingen cascade constraints;

create table  inschrijvingen
(cursist      NUMBER(4)    constraint  I2_CURSIST_NN not null
                           constraint  I2_CURSIST_FK references medewerkers
,cursus       VARCHAR2(4)  constraint  I2_CURSUS_NN  not null
,begindatum   DATE         constraint  I2_BEGIN_NN   not null
,evaluatie    NUMBER(1)    constraint  I2_EVAL_CHK
                           check       (evaluatie in (1,2,3,4,5) )
,constraint   I2_PK         primary key (cursist,cursus,begindatum)
,constraint   I2_UITV_FK    foreign key (cursus,begindatum)
                           references  uitvoeringen
);

Prompt TABELLEN WORDEN EERST VERWIJDERD EN NADIEN OPNIEUW GEMAAKT!


REM =============================================================
REM SQL*Plus script vulcase2015.sql: vult de casustabellen (opnieuw)
REM =============================================================

alter session  set NLS_DATE_FORMAT='DD-MON-RRRR';
alter session set NLS_LANGUAGE = 'DUTCH';
alter    table medewerkers disable primary key cascade;
alter    table medewerkers disable constraint M2_CHEF_FK;
alter    table medewerkers disable constraint M2_AFD_FK;
truncate table medewerkers;

insert into medewerkers values(7369,'CASPERS'       ,'JANA'  ,'TRAINER'   ,7902
                                   ,'17-DEC-1985'  , 1800 , NULL       ,20);
insert into medewerkers values(7499,'ALLARD'     ,'NELE','VERKOPER'  ,7698
                                   ,'20-FEB-1981'  , 1600, 3000        ,30);
insert into medewerkers values(7521,'DEFOUR'   ,'THOMAS' ,'VERKOPER'  ,7698
                                   ,'22-FEB-1982'  , 2250, 5000        ,30);
insert into medewerkers values(7566,'JACOBS'     ,'EMMA' ,'MANAGER'   ,7839
                                   ,'02-APR-1987'  , 4975, NULL       ,20);
insert into medewerkers values(7654,'MARTENS'    ,'RAF'  ,'VERKOPER'  ,7698
                                   ,'28-SEP-1976'  , 2250, 3400       ,30);
insert into medewerkers values(7698,'BRIERS'      ,'ANDREA'  ,'MANAGER'   ,7839
                                   ,'01-NOV-1983'  , 5850, NULL       ,30);
insert into medewerkers values(7782,'CLERCKX'    ,'AN' ,'MANAGER'   ,7839
                                   ,'09-JUN-1985'  , 3450, NULL       ,10);
insert into medewerkers values(7788,'SWINNEN'   ,'CHRIS','TRAINER'   ,7566
                                   ,'26-NOV-1979'  , 4000, NULL       ,20);
insert into medewerkers values(7839,'DE KONING'  ,'LIEVE' ,'DIRECTEUR' ,NULL
                                   ,'17-NOV-1972'  , 7000, NULL       ,10);
insert into medewerkers values(7844,'DEN RUYTER','JOACHIM' ,'VERKOPER'  ,7698
                                   ,'28-SEP-1988'  , 2500, 0          ,30);
insert into medewerkers values(7876,'SLECHTEN'      ,'TOM' ,'TRAINER'   ,7788
                                   ,'30-DEC-1986'  , 2700, NULL       ,20);
insert into medewerkers values(7900,'JACOBS'     ,'SIMON'  ,'BOEKHOUDER',7698
                                   ,'03-DEC-1989'  , 2800 , NULL       ,30);
insert into medewerkers values(7902,'DE COOMAN'    ,'DORIEN' ,'TRAINER'   ,7566
                                   ,'13-FEB-1979'  , 4000, NULL       ,20);
insert into medewerkers values(7934,'WOUTERS'   ,'SVEN','BOEKHOUDER',7782
                                   ,'23-JAN-1982'  , 2300, NULL       ,10);

alter table medewerkers enable primary key;


REM =====================================================================


truncate table afdelingen;

insert into afdelingen values (10,'HOOFDKANTOOR'   ,'MAASMECHELEN'   ,7782);
insert into afdelingen values (20,'OPLEIDINGEN'    ,'HASSELT' ,7566);
insert into afdelingen values (30,'VERKOOP'        ,'GENK'  ,7698);
insert into afdelingen values (40,'PERSONEELSZAKEN','LEUVEN',7839);

alter    table medewerkers enable constraint M2_CHEF_FK;
alter    table medewerkers enable constraint M2_AFD_FK;
alter table afdelingen     enable constraint A2_HOOFD_FK;

REM =====================================================================

truncate table schalen;

insert into schalen    values (1, 1700,2200,  0);
insert into schalen    values (2,2201,2400, 50);
insert into schalen    values (3,2401,4000,100);
insert into schalen    values (4,4001,5000,200);
insert into schalen    values (5,5001,9999,500);

REM =====================================================================

alter    table cursussen disable primary key cascade;
truncate table cursussen;

insert into cursussen  values ('SQL','Introductie SQL en databanken'
                              ,'ALG',4);
insert into cursussen  values ('ORG','IT Organisatie'
                              ,'ALG',1);
insert into cursussen  values ('WEB','Ontwikkeling website'
                              ,'BLD',4);
insert into cursussen  values ('CIS','Cisco CCNA'
                              ,'BLD',1);
insert into cursussen  values ('WIN','Windows Server'
                              ,'BLD',2);
insert into cursussen  values ('LIN','Linux OS'
                              ,'DSG',3);
insert into cursussen  values ('PR2','Programmeren2 in Visual C#'
                              ,'DSG',1);
insert into cursussen  values ('WBA','Web applicaties'
                              ,'DSG',2);
insert into cursussen  values ('PR1','Programmeren1 Visual C#'
                              ,'DSG',5);
insert into cursussen  values ('NET','Netwerkbeheer'
                              ,'DSG',4);

alter table cursussen enable primary key;

REM =====================================================================

alter    table uitvoeringen disable primary key cascade;
truncate table uitvoeringen;

insert into uitvoeringen   values ('SQL','16-APR-2015',7902,'HASSELT'  );
insert into uitvoeringen   values ('SQL','08-OKT-2015',7369,'MAASEIK');
insert into uitvoeringen   values ('SQL','17-DEC-2015',7369,'HASSELT'  );
insert into uitvoeringen   values ('ORG','10-AUG-2015',7566,'GENK'   );
insert into uitvoeringen   values ('ORG','27-SEP-2015',7902,'HASSELT'  );
insert into uitvoeringen   values ('WEB','17-DEC-2015',7566,'MAASEIK');
insert into uitvoeringen   values ('WEB','05-FEB-2016',7876,'HASSELT'  );
insert into uitvoeringen   values ('CIS','11-SEP-2016',7788,'HASSELT'  );
insert into uitvoeringen   values ('WIN','04-FEB-2016',7369,'HASSELT'  );
insert into uitvoeringen   values ('WIN','18-SEP-2016',NULL,'MAASEIK');
insert into uitvoeringen   values ('LIN','13-JAN-2017',NULL, NULL       );
insert into uitvoeringen   values ('PR1','17-FEB-2017',NULL,'HASSELT'  );
insert into uitvoeringen   values ('WBA','24-FEB-2017',7788,'GENK'   );

alter table uitvoeringen enable primary key;
rem alter table uitvoeringen   enable constraint U2_CURSUS_FK;
rem alter table uitvoeringen   enable constraint U2_DOCENT_FK;


REM =====================================================================

truncate table inschrijvingen;

insert into inschrijvingen values (7499,'SQL','16-APR-2015',4   );
insert into inschrijvingen values (7934,'SQL','16-APR-2015',5   );
insert into inschrijvingen values (7698,'SQL','16-APR-2015',4   );
insert into inschrijvingen values (7876,'SQL','16-APR-2015',2   );
insert into inschrijvingen values (7788,'SQL','08-OKT-2015',NULL);
insert into inschrijvingen values (7839,'SQL','08-OKT-2015',3   );
insert into inschrijvingen values (7902,'SQL','08-OKT-2015',4   );
insert into inschrijvingen values (7902,'SQL','17-DEC-2015',NULL);
insert into inschrijvingen values (7698,'SQL','17-DEC-2015',NULL);
insert into inschrijvingen values (7521,'ORG','10-AUG-2015',4   );
insert into inschrijvingen values (7900,'ORG','10-AUG-2015',4   );
insert into inschrijvingen values (7902,'ORG','10-AUG-2015',5   );
insert into inschrijvingen values (7844,'ORG','27-SEP-2016',5   );
insert into inschrijvingen values (7499,'WEB','17-DEC-2015',2   );
insert into inschrijvingen values (7782,'WEB','17-DEC-2015',5   );
insert into inschrijvingen values (7876,'WEB','17-DEC-2015',5   );
insert into inschrijvingen values (7788,'WEB','17-DEC-2015',5   );
insert into inschrijvingen values (7839,'WEB','17-DEC-2015',4   );
insert into inschrijvingen values (7566,'WEB','05-FEB-2016',3   );
insert into inschrijvingen values (7788,'WEB','05-FEB-2016',4   );
insert into inschrijvingen values (7698,'WEB','05-FEB-2016',5   );
insert into inschrijvingen values (7900,'WIN','04-FEB-2016',4   );
insert into inschrijvingen values (7499,'WIN','04-FEB-2016',5   );
insert into inschrijvingen values (7566,'CIS','11-SEP-2016',NULL);
insert into inschrijvingen values (7499,'CIS','11-SEP-2016',NULL);
insert into inschrijvingen values (7876,'CIS','11-SEP-2016',NULL);

REM =====================================================================



alter table inschrijvingen enable constraint I2_CURSIST_FK;

