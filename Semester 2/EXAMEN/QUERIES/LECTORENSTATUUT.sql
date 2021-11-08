drop table LECTOREN
drop table STATUUT

prompt dropped tables

create table LECTOREN
(
	LECTR_ID	number			constraint LECTR_LECTRID_PK	PRIMARY KEY NOT NULL,
	SRT_ID		number(5)		constraint LECTR_SRTID_EXCEEDSVAL
								check (CAST(substr(SRT_ID, 2, 2) AS INT) BETWEEN 10 and 30),
	STAT		number(5)		constraint LECTR_STAT_NN			NOT NULL,
	SALARIS		decimal(5,2)	constraint LECTR_SAL_EXCEEDSVAL	check(SALARIS > 1850.50),
	INDIENST	date,
	EINDDATUM	date,
	AANWERVING	char			constraint LECTR_AW_CHAR			check (AANWERVING = 'J' OR AANWERVING = 'N')
)

prompt LECTOREN created 

create table STATUUT
(
	STAT_ID		numeric(5)		CONSTRAINT STAT_STATID_PK	PRIMARY KEY,
	STATUUT1	nvarchar2(25)	CONSTRAINT STAT_STATUUT1_LEN		check (len(STATUUT1) <= 20),
	STATUUT2 	nvarchar2(15)	CONSTRAINT STAT_STATUUT2_CAP		check (STATUUT2 = UPPER(STATUUT2))
								CONSTRAINT STAT_STATUUT2_STAT	check (STATUUT2 = 'statuut 1' OR STATUUT2 = 'statuut 2')
)

prompt STATUUT created 