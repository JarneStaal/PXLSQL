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