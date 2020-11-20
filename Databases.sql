/* Brysen Allen, Joe Davidson, Grace Crockett, David Pesin
   DB-Project
*/
CREATE TABLE PASSENGER (
	PASS_ID       Numeric(7,0) PRIMARY KEY,
	PASS_NAME     VARCHAR(20) NOT NULL,
	PASS_LNAME    VARCHAR(20) NOT NULL,
	PASS_STREET   VARCHAR(20) NOT NULL,
	PASS_CITY     VARCHAR(20) NOT NULL,
	PASS_STATE    VARCHAR(20) NOT NULL,
	PASS_ZIP      NUMERIC(10,0) NOT NULL,
	PASS_COUNTRY  VARCHAR(20) NOT NULL
  );

CREATE TABLE INVOICE(
  INV_ID      NUMERIC(7,0) PRIMARY KEY,
  PRICE       NUMERIC(5,2) NOT NULL,
  CONF_CODE   VARCHAR(20) NOT NULL,
  FOREIGN KEY(PASS_ID) REFERNCES PASSENGER(PASS_ID)
  );

CREATE TABLE TICKET(
  TICKET_ID     NUMERIC(7,0) PRIMARY KEY,
  FOREIGN KEY   (ROUTE_ASSIGN) 
  SEAT_NUM      VARCHAR(6)
  FOREIGN KEY(INV_ID) REFERENCES INVOICE(INV_ID)
  );
  
CREATE TABLE TRAIN(
TRAIN_NUM PRIMARY KEY
CONDUCTOR_ID	NUMERIC(7,0) NOT NULL
NUM_SEATS	NUMERIC(7,0) NOT NULL
);

CREATE TABLE ROUTE(
  ROUTE_NUM   NUMERIC(3,0) PRIMARY KEY,
  FOREIGN KEY (TRAIN_NUM) REFERENCES TRAIN(TRAIN_NUM)
  );
  
CREATE TABLE ROUTE_ASSGN(
  R_ASGN	NUMERIC(7,0) PRIMARY KEY
  FOREIGN KEY (ROUTE_NUM) REFERENCES ROUTE(ROUTE_NUM)
  TRUE_DEPT	DATE
  TRUE_ARR	DATE
  EST_DEPT	DATE
  EST_ARRIVAL	DATE
  );

CREATE TABLE STATION(
STAT_NUM      PRIMARY KEY
STAT_STREET   VARCHAR(20) NOT NULL,
STAT_CITY     VARCHAR(20) NOT NULL,
STAT_STATE    VARCHAR(20) NOT NULL,
STAT_ZIP      INT(10) UNSIGNED NOT NULL,
STAT_COUNTRY  VARCHAR(20) NOT NULL
);

CREATE TABLE STOPS(
  FOREIGN KEY(ROUTE_NUM) REFERENCES ROUTE(ROUTE_NUM)
  FOREIGN KEY(STAT_NUM) REFERENCES STATION(STAT_NUM)
  STOP_NUM	NUMERIC(3,0)
  );
  
CREATE TABLE EMPLOYEE(
  EMP_ID PRIMARY KEY
  EMP_FNAME	VARCHAR(20)
  EMP_LNAME	VARCHAR(20)
  EMP_HIREDATE	DATE NOT NULL
  FOREIGN KEY(JOB_CODE)
  REPORTS_T0	FOREIGN ## FIX THIS W RECURSIVE SETUP##############################################################
  );
 
-- Populating EMPLOYEE
INSERT INTO `EMPLOYEE` (`EMP_ID`, `EMP_FNAME`, `EMP_LNAME`, `HIRE_DATE`, `JOB_CODE`, `REPORTS_TO`) VALUES
(0001, 'Shea', 'Manser', '12/25/2016', 1, null), -- CEO
(0010, 'Hesther', 'Collecott', '12/27/2013', 2, 0001), -- COO
(0011, 'Crystie', 'Dowsey', '6/21/2006', 5, 0010), -- Station Manager 1
(0100, 'Hulda', 'Geany', '11/2/2007', 5, 0010), -- Station Manager 2
(0101, 'Gustaf', 'Wraith', '5/29/2012', 6, 0010), -- Train Manager 1
(0110, 'Anya', 'Rusted', '2/22/2017', 6, 0010), -- Train Manager 2
(0111, 'Skippy', 'Dodshun', '10/22/2005', 4, 0011), -- Head Mechanic 1
(1000, 'Maia', 'Yuranovev', '7/26/2016', 4, 0100), -- Head Mechanic 2
(1001, 'Pat', 'Britian', '2/10/2016', 9, 0111), --Mechanics
(1010, 'Philipa', 'Bolesworth', '9/2/2002', 9, 0111),
(1011, 'Ilyse', 'Krimmer', '4/19/2004', 9, 1000),
(1100, 'Saraann', 'Hetterich', '10/5/2003', 9, 1000),
(1101, 'Traci', 'Marciskewski', '8/4/2011', 11, 0011), -- Tellers
(1110, 'Cobbie', 'Canfer', '4/22/2000', 11, 0100),
(1111, 'Sloan', 'Quixley', '1/8/2001', 3, 0101), -- Head Steward 1
(0002, 'Thornton', 'Pyke', '10/28/2004', 3, 0110), -- Head Steward 2
(0020, 'Amity', 'Aidler', '6/5/2003', 7, 1111), -- Stewardesses 
(0022, 'Karoly', 'Rippin', '9/26/2020', 7, 1111),
(0200, 'Alecia', 'Filipowicz', '10/25/2020', 7, 0002),
(0202, 'Rowan', 'Farnworth', '9/23/2002', 7, 0002),
(0220, 'Sascha', 'Hallowes', '7/21/2002', 8, 1111), -- Cafe Attendants
(0222, 'Darrel', 'Chiverstone', '7/10/2019', 8, 0002),
(2000, 'Teodoor', 'Pottle', '4/25/2007', 5, 0010), --Station Manager 3
(2002, 'Piggy', 'Cawte', '12/14/2019', 11, 2000), -- Teller
(2020, 'Hale', 'Earengey', '6/4/2008', 4, 2000), -- Head Mechanic 3
(2022, 'Cloe', 'Muddiman', '9/1/2013', 9, 2020), -- Mechanics (3)
(2200, 'Camilla', 'Pitcher', '12/26/2009', 9, 2020),
(2202, 'Vail', 'Cawt', '12/4/2000', 9, 2020),
(2220, 'Bonnibelle', 'Bellam', '9/14/2020', 10, 0110), -- Conductors
(2222, 'Dwain', 'Siviter', '12/20/2017', 10, 0101);
 -- I'll remove the comments later bc we don't really need that, it's just for us
CREATE TABLE STATION_ASSGN(
  STAT_ASSGN PRIMARY KEY
  FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE(EMP_ID)
  FOREIGN KEY(STAT_NUM) REFERENCES STATION(STAT_NUM)
  START_DATE	DATE NOT NULL
  END_DATE	DATE
  );


  


CREATE TABLE TRAIN_ASSGN(
  T_ASSGN PRIMARY KEY
  FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE(EMP_ID)
  FOREIGN KEY(TRAIN_NUM) REFERENCES TRAIN(TRAIN_NUM)
  START_DATE	DATE NOT NULL
  END_DATE	DATE 
  );
  
CREATE TABLE ENGINE(
  ENG_NUM PRIMARY KEY
  ENG_MODEL	VARCHAR(20) NOT NULL
  ENG_DESC	VARCHAR(50) NOT NULL
  );
  
CREATE TABLE ENGINE_ASSGN(
  E_ASSGN PRIMARY KEY
  FOREIGN KEY(ENG_NUM) REFERENCES ENGINE(ENG_NUM)
  FOREIGN KEY(TRAIN_NUM)
  START_DATE	DATE NOT NULL
  END_DATE	DATE 
  );
  
CREATE TABLE CAR(
  CAR_NUM PRIMARY KEY 
  CAR_DESC	VARCHAR(20) NOT NULL
  CAR_CAPACITY	NUMERIC(7,0) NOT NULL
  );
  
CREATE TABLE CAR_ASSGN
  C_ASSGN PRIMARY KEY
  FOREIGN KEY(CAR_NUM) REFERENCES CAR(CAR_NUM)
  FOREIGN KEY(TRAIN_NUM) REFERENCES TRAIN(TRAIN_NUM)
  START_DATE DATE NOT NULL
  END_DATE   DATE 
  );
  
CREATE TABLE JOB(
  JOB_CODE PRIMARY KEY
  JOB_DESC	VARCHAR(20) NOT NULL
  JOB_TITLE	VARCHAR(20) NOT NULL
  );
  
-- Populating JOB
INSERT INTO `JOB` (`JOB_CODE`, `JOB_TITLE`, `JOB_DESC`) VALUES
(1, 'CEO', 'Chief Executive Officer'),
(2, 'COO', 'Chief Operations Officer'),
(3, 'Head Stewardess', 'Manages all stewards on the train'),
(4, 'Head Mechanic', 'Manages all of the mechanics in the station'),
(5, 'Station Manager', 'Manages all staff in a station'),
(6, 'Train Manager', 'Manages all staff in a train')
(7, 'Stewardess', 'Collect ticket stubs and accomodate passengers on trains.'),
(8, 'Cafe Attendant', 'Manages the cafe car and serves food.'),
(9, 'Mechanic', 'Fixes engines and other components of the train at the station.'),
(10, 'Conductor', 'Drives and directs the train.'),
(11, 'Teller', 'Sells tickets at the station.');
  
CREATE TABLE MEHCANIC(
  FOREIGN KEY(EMP_ID) REFERENCES EMPLOYE(EMP_ID)
  CERT_DATE	VARCHAR(20) NOT NULL
  CERT_EXP	VARCHAR(20) NOT NULL
  );
  
-- Populating MECHANIC
INSERT INTO `MECHANIC` (`EMP_ID`, `CERT_DATE`, `CERT_EXP`) VALUES
(1001, '3/4/2019', '3/4/2024'),
(1010, '12/5/2015', '12/5/2020'),
(1011, '7/6/2016', '7/6/2021'),
(1100, '7/6/2016', '7/6/2021'),
(2022, '5/5/2017', '5/5/2022'),
(2200, '8/5/2020', '8/5/2025'),
(2202, '1/5/2018', '1/5/2023');

CREATE TABLE CONDUCTOR
  FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE(EMP_ID)
  CERT_DATE	DATE NOT NULL
  CERT_EXP	DATE NOT NULL
  );

-- Populating CONDUCTOR
INSERT INTO `CONDUCTOR` (`EMP_ID`, `CERT_DATE`, `CERT_EXP`) VALUES
(2220, '1/8/2020', '1/8/2025'),
(2222, '9/12/2019', '9/12/2024');
