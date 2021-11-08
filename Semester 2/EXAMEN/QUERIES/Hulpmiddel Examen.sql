drop table LECTOREN
drop table STATUUT

prompt dropped tables

create table LECTOREN
(
	LECTR_ID	number			constraint LECTR_LECTRID_PK	PRIMARY KEY NOT NULL,
	SRT_ID		nvarchar2(5)		constraint LECTR_SRTID_EXCEEDSVAL
								check (CAST(substr(SRT_ID, 2, 2) AS INT) BETWEEN 10 and 30),
	STAT		number(5)		constraint LECTR_STAT_NN			NOT NULL,
	SALARIS		numeric(7,2)		constraint LECTR_SAL_EXCEEDSVAL	check(SALARIS > 1850.50),
	INDIENST	date,
	EINDDATUM	date,
	AANWERVING	char			constraint LECTR_AW_CHAR			check (AANWERVING = 'J' OR AANWERVING = 'N')
)

prompt LECTOREN created 

create table STATUUT
(
	STAT_ID		numeric(5)		CONSTRAINT STAT_STATID_PK	PRIMARY KEY,
	STATUUT1	nvarchar2(25)	CONSTRAINT STAT_STATUUT1_LEN		check (length(STATUUT1) <= 20),
	STATUUT2 	nvarchar2(15)	CONSTRAINT STAT_STATUUT2_CAP		check (STATUUT2 = UPPER(STATUUT2))
)

prompt STATUUT created 



INSERT INTO STATUUT(STAT_ID,STATUUT1)
values(1238,'vast benoemd')


INSERT INTO LECTOREN(LECTR_ID,SRT_ID,STAT,SALARIS,INDIENST,EINDDATUM)
values((select mnr from medewerkers where naam ='CLERCKX'),'P28NN', 1238, 2355.65, TO_DATE('2019/11/3', 'yyyy/mm/dd'), TO_DATE('2020/06/30', 'yyyy/mm/dd'))


UPDATE LECTOREN
	SET EINDDATUM = TO_DATE('2020/09/01', 'yyyy/mm/dd')
	where LECTR_ID in (select mnr from medewerkers where naam = 'CLERCKX');
	


ALTER TABLE STATUUT
ADD VERPLICHTING varchar(20) CONSTRAINT STAT_VERPL_N NULL

--aanmaken van de sequence:
CREATE SEQUENCE seq_statuut
INCREMENT BY 10
START WITH 1000;
 
--gebruiken van de sequence:
INSERT INTO STATUUT(STAT_ID,STATUUT1,VERPLICHTING)
VALUES (seq_statuut.Nextval,'tijdelijke aanstelling' ,'JA'); 
	
	
































