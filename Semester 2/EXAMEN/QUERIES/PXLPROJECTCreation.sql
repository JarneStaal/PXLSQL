
drop table if exists PROJECT
drop table if exists AFDELING
drop table if exists MEDEWERKER
drop table if exists PROJECTLIJN

create table PROJECT
( 
projectnr int constraint pr_pn_pk primary key, 
projectomschrijving nvarchar(30) constraint pr_omschr_nn not null,
budget numeric (7,2) default 5000.00 constraint pr_budget_nn not null 
)

PRINT 'PROJECT table succesfully created'
-- ORACLE USES PROMPT--

create table AFDELING
( 
afdeling nchar(5) constraint afdel_nr_pk primary key,
chef nvarchar(20) not null
)
PRINT 'AFDELING table succesfully created'

create table MEDEWERKER
( 
mednr int identity(1,1) constraint medw_nr_pk primary key,
naam nvarchar(20) not null constraint medw_naam_chk check(naam = upper(naam)),
afdeling nchar(5) constraint med_afd_fk references afdeling
)
PRINT 'MEDEWERKER table succesfully created'


create table PROJECTLIJN
( 
projectnr int constraint prol_nr_fk references PROJECT,
mednr int constraint prol_mednr_fk references MEDEWERKER,
uren numeric(5,2) not null,
constraint prol_nr_pl primary key(projectnr,mednr)
)
PRINT 'PROJECTLIJN table succesfully created'


