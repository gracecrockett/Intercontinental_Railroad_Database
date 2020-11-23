/* 
 * Transplanetary Railway Database
 * Brysen Allen, Joe Davidson, Grace Crockett, David Pesin
 */
CREATE TABLE IF NOT EXISTS PASSENGER( -- Table structure for PASSENGER
  PASS_ID       Numeric(7,0) NOT NULL,
  PASS_FNAME     VARCHAR(20) NOT NULL,
  PASS_LNAME    VARCHAR(20) NOT NULL, 
  PASS_STREET   VARCHAR(20) NOT NULL,
  PASS_CITY     VARCHAR(20) NOT NULL,
  PASS_STATE    VARCHAR(20) NOT NULL,
  PASS_ZIP      NUMERIC(10,0) NOT NULL,
  PASS_COUNTRY  VARCHAR(20) NOT NULL
);
ALTER TABLE PASSENGER -- Indexes for PASSENGER
  ADD PRIMARY KEY (PASS_ID);


CREATE TABLE IF NOT EXISTS INVOICE( -- Table structure for INVOICE
  INV_ID	NUMERIC(7,0),
  PRICE		NUMERIC(7,2) NOT NULL,
  CONF_CODE	VARCHAR(20) NOT NULL,
  PASS_ID   	NUMERIC(7,0),
  P_DATE	DATE NOT NULL
);
ALTER TABLE INVOICE -- Indexes for INVOICE
  ADD PRIMARY KEY (INV_ID),
  ADD KEY PASS_ID (PASS_ID);
ALTER TABLE INVOICE -- Constraints for INVOICE
  ADD CONSTRAINT INVOICE_ibfk_1 FOREIGN KEY (PASS_ID) REFERENCES PASSENGER(PASS_ID);

  
CREATE TABLE IF NOT EXISTS TRAIN( -- Table structure for TRAIN
 TRAIN_NUM 	NUMERIC(3,0) NOT NULL,
 CONDUCTOR_ID	NUMERIC(7,0) NOT NULL,
  NUM_SEATS	NUMERIC(7,0) NOT NULL
);
ALTER TABLE TRAIN -- Indexes for TRAIN
  ADD PRIMARY KEY (TRAIN_NUM);


CREATE TABLE IF NOT EXISTS STATION( -- Table structure for STATION
  STAT_NUM      NUMERIC(3,0) NOT NULL,
  STAT_STREET   VARCHAR(30) NOT NULL,
  STAT_CITY     VARCHAR(30) NOT NULL,
  STAT_STATE    VARCHAR(30) NOT NULL,
  STAT_ZIP      INT(10) UNSIGNED NOT NULL,
  STAT_COUNTRY  VARCHAR(20) NOT NULL
);
ALTER TABLE STATION -- Indexes for STATION
  ADD PRIMARY KEY(STAT_NUM);
  
  
CREATE TABLE IF NOT EXISTS ROUTE( -- Table structure for ROUTE
  ROUTE_NUM   	NUMERIC(3,0) NOT NULL,
  ORIGIN	NUMERIC(3,0),
  DESTINATION	NUMERIC(3,0)
);
ALTER TABLE ROUTE -- Indexes for ROUTE
  ADD PRIMARY KEY(ROUTE_NUM),
  ADD KEY(ORIGIN),
  ADD KEY(DESTINATION);
ALTER TABLE ROUTE -- Constraints for ROUTE
  ADD CONSTRAINT ROUTE_IBFK_1 FOREIGN KEY(ORIGIN) REFERENCES STATION(STAT_NUM),
  ADD CONSTRAINT ROUTE_IBFK_2 FOREIGN KEY(DESTINATION) REFERENCES STATION(STAT_NUM);

  
CREATE TABLE IF NOT EXISTS ROUTE_ASSGN(
  R_ASSGN	NUMERIC(7,0) NOT NULL,
  ROUTE_NUM	NUMERIC(3,0),
  TRAIN_NUM 	NUMERIC(3,0),  
  TRUE_DEPT 	DATETIME,
  TRUE_ARR 	DATETIME,
  EST_DEPT	DATETIME NOT NULL,
  EST_ARRIVAL	DATETIME NOT NULL
);
ALTER TABLE ROUTE_ASSGN -- Indexes for ROUTE_ASSGN
  ADD PRIMARY KEY(R_ASSGN),
  ADD KEY(ROUTE_NUM),
  ADD KEY(TRAIN_NUM);
ALTER TABLE ROUTE_ASSGN -- Constraints for ROUTE_ASSGN
  ADD CONSTRAINT ROUTE_ASSGN_IBFK_1 FOREIGN KEY(ROUTE_NUM) REFERENCES ROUTE(ROUTE_NUM),
  ADD CONSTRAINT ROUTE_ASSGN_IBFK_2 FOREIGN KEY(TRAIN_NUM) REFERENCES TRAIN(TRAIN_NUM);

 
CREATE TABLE IF NOT EXISTS STOPS(
  ROUTE_NUM 	NUMERIC(3,0),
  STOP_NUM	NUMERIC(3,0) NOT NULL,
  STAT_NUM	NUMERIC(3,0)
);
ALTER TABLE STOPS -- Indexes for STOPS
  ADD PRIMARY KEY(ROUTE_NUM,STOP_NUM);
ALTER TABLE STOPS -- Constraints for STOPS
  ADD CONSTRAINT STOPS_IBFK_1 FOREIGN KEY(ROUTE_NUM) REFERENCES ROUTE(ROUTE_NUM),
  ADD CONSTRAINT STOPS_IBFK_2 FOREIGN KEY(STAT_NUM) REFERENCES STATION(STAT_NUM);


CREATE TABLE IF NOT EXISTS TICKET( -- Table structure for TICKET
  TICKET_ID     NUMERIC(7,0) NOT NULL,
  INV_ID	NUMERIC(7,0),
  R_ASSGN	NUMERIC(7,0),
  ORIGIN	NUMERIC(3,0),
  DESTINATION	NUMERIC(3,0)
);
ALTER TABLE TICKET -- Indexes for TICKET
  ADD PRIMARY KEY(TICKET_ID);
ALTER TABLE TICKET -- Constraints for TICKET
  ADD CONSTRAINT TICKET_IBFK_1 FOREIGN KEY(INV_ID) REFERENCES INVOICE(INV_ID),
  ADD CONSTRAINT TICKET_IBFK_2 FOREIGN KEY(R_ASSGN) REFERENCES ROUTE_ASSGN(R_ASSGN);


CREATE TABLE IF NOT EXISTS JOB( -- Table structure for JOB
  JOB_CODE 	NUMERIC(2,0) NOT NULL,
  JOB_DESC	VARCHAR(20) NOT NULL,
  JOB_TITLE	VARCHAR(150) NOT NULL
);
ALTER TABLE JOB -- Indexes for JOB
  ADD PRIMARY KEY(JOB_CODE);
  
  
CREATE TABLE IF NOT EXISTS EMPLOYEE( -- Table structure for EMPLOYEE
  EMP_ID 	NUMERIC(4,0) NOT NULL,
  EMP_FNAME	VARCHAR(20) NOT NULL,
  EMP_LNAME	VARCHAR(20) NOT NULL,
  EMP_HIREDATE	DATE NOT NULL,
  JOB_CODE	NUMERIC(2,0),
  REPORTS_TO	NUMERIC(4,0)
);
ALTER TABLE EMPLOYEE -- Indexes for EMPLOYEE
  ADD PRIMARY KEY(EMP_ID);
ALTER TABLE EMPLOYEE -- Constraints for EMPLOYEE
  ADD CONSTRAINT EMPLOYEE_IBFK_1 FOREIGN KEY(JOB_CODE) REFERENCES JOB(JOB_CODE),
  ADD CONSTRAINT EMPLOYEE_IBFK_2 FOREIGN KEY(REPORTS_TO) REFERENCES EMPLOYEE(EMP_ID);
	

CREATE TABLE IF NOT EXISTS MECHANIC( -- Table structure for MECHANIC
  EMP_ID	NUMERIC(4,0),
  CERT_DATE	VARCHAR(20) NOT NULL,
  CERT_EXP	VARCHAR(20) NOT NULL
);
ALTER TABLE MECHANIC
  ADD PRIMARY KEY(EMP_ID);
ALTER TABLE MECHANIC -- Constraints for MECHANIC
  ADD CONSTRAINT MECHANIC_IBFK_1 FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE(EMP_ID); 


CREATE TABLE IF NOT EXISTS CONDUCTOR( -- Table structure for CONDUCTOR
  EMP_ID	NUMERIC(4,0),
  CERT_DATE	DATE NOT NULL,
  CERT_EXP	DATE NOT NULL
);
ALTER TABLE CONDUCTOR -- Indexes for CONDUCTOR
  ADD PRIMARY KEY(EMP_ID);
ALTER TABLE CONDUCTOR -- Constraints for CONDUCTOR
  ADD CONSTRAINT CONDUCTOR_IBFK_1 FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE(EMP_ID); 
	
 
CREATE TABLE IF NOT EXISTS STATION_ASSGN( -- Table structure for STATION_ASSGN
  STAT_ASSGN	NUMERIC(7,0) NOT NULL,
  EMP_ID	NUMERIC(4,0) ,
  STAT_NUM	NUMERIC(3,0)
);
ALTER TABLE STATION_ASSGN -- Indexes for STATION_ASSGN
  ADD PRIMARY KEY(STAT_ASSGN),
  ADD KEY(EMP_ID),
  ADD KEY(STAT_NUM);
ALTER TABLE STATION_ASSGN -- Constraints for STATION_ASSGN
  ADD CONSTRAINT STATION_ASSGN_IBFK_1 FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE(EMP_ID),
  ADD CONSTRAINT STATION_ASSGN_IBFK_2 FOREIGN KEY(STAT_NUM) REFERENCES STATION(STAT_NUM);
  

CREATE TABLE IF NOT EXISTS TRAIN_ASSGN( -- Table structure for TRAIN_ASSIGN
  T_ASSGN 	NUMERIC(7,0) NOT NULL,
  EMP_ID	NUMERIC(4,0),
  TRAIN_NUM	NUMERIC(4,0),
  START_DATE	DATE NOT NULL,
  END_DATE	DATE 
);
ALTER TABLE TRAIN_ASSGN -- Indexes for TRAIN_ASSGN
  ADD PRIMARY KEY(T_ASSGN),
  ADD KEY(EMP_ID),
  ADD KEY(TRAIN_NUM);
ALTER TABLE TRAIN_ASSGN -- Constraints for TRAIN_ASSGN
  ADD CONSTRAINT TRAIN_ASSGN_IBFK_1 FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE(EMP_ID),
  ADD CONSTRAINT TRAIN_ASSGN_IBFK_2 FOREIGN KEY(TRAIN_NUM) REFERENCES TRAIN(TRAIN_NUM);

  
CREATE TABLE IF NOT EXISTS ENGINE( -- Table structure for ENGINE
  ENG_NUM	NUMERIC(7,0) NOT NULL,
  ENG_MODEL	VARCHAR(20) NOT NULL,
  ENG_DESC	VARCHAR(50) NOT NULL
);
ALTER TABLE ENGINE -- Indexes for ENGINE
  ADD PRIMARY KEY(ENG_NUM);
  
  
CREATE TABLE IF NOT EXISTS ENGINE_ASSGN( -- Table structure for ENGINE_ASSGN
  E_ASSGN 	NUMERIC(7,0),
  ENG_NUM	NUMERIC(7,0),
  TRAIN_NUM	NUMERIC(4,0),
  START_DATE	DATE NOT NULL,
  END_DATE	DATE
);
ALTER TABLE ENGINE_ASSGN -- Indexes for ENGINE_ASSGN
  ADD PRIMARY KEY(E_ASSGN),
  ADD KEY(ENG_NUM),
  ADD KEY(TRAIN_NUM);
ALTER TABLE ENGINE_ASSGN -- Constraints for ENGINE_ASSGN
  ADD CONSTRAINT ENGINE_ASSGN_IBFK_1 FOREIGN KEY(ENG_NUM) REFERENCES ENGINE(ENG_NUM),
  ADD CONSTRAINT ENGINE_ASSGN_IBFK_2 FOREIGN KEY(TRAIN_NUM) REFERENCES TRAIN(TRAIN_NUM);
	

CREATE TABLE IF NOT EXISTS CAR( -- Table structure for CAR
  CAR_NUM 	NUMERIC(7,0),
  CAR_DESC	VARCHAR(20) NOT NULL,
  CAR_CAPACITY	NUMERIC(7,0) NOT NULL
);
ALTER TABLE CAR -- Indexes for CAR
  ADD PRIMARY KEY(CAR_NUM);
  
  
CREATE TABLE IF NOT EXISTS CAR_ASSGN( -- Table structure for CAR_ASSGN
  C_ASSGN 	NUMERIC(7,0) NOT NULL,
  CAR_NUM	NUMERIC(7,0),
  TRAIN_NUM	NUMERIC(3,0),
  START_DATE 	DATE NOT NULL,
  END_DATE   	DATE
);
ALTER TABLE CAR_ASSGN -- Indexes for CAR_ASSGN
  ADD PRIMARY KEY(C_ASSGN),
  ADD KEY(CAR_NUM),
  ADD KEY(TRAIN_NUM);
ALTER TABLE CAR_ASSGN -- Constraints for CAR_ASSGN
  ADD CONSTRAINT CAR_ASSGN_IBFK_1 FOREIGN KEY(CAR_NUM) REFERENCES CAR(CAR_NUM),
  ADD CONSTRAINT CAR_ASSGN_IBFK_2 FOREIGN KEY(TRAIN_NUM) REFERENCES TRAIN(TRAIN_NUM);
	


/****** POPULATING THE TABLES ******/

 -- Populating JOB
INSERT INTO `JOB` (`JOB_CODE`, `JOB_TITLE`, `JOB_DESC`) VALUES
(1, 'CEO', 'Chief Executive Officer'),
(2, 'COO', 'Chief Operations Officer'),
(3, 'Head Stewardess', 'Manages all stewards on the train'),
(4, 'Head Mechanic', 'Manages all of the mechanics in the station'),
(5, 'Station Manager', 'Manages all staff in a station'),
(6, 'Train Manager', 'Manages all staff in a train'),
(7, 'Stewardess', 'Collect ticket stubs and accomodate passengers on trains.'),
(8, 'Cafe Attendant', 'Manages the cafe car and serves food.'),
(9, 'Mechanic', 'Fixes engines and other components of the train at the station.'),
(10, 'Conductor', 'Drives and directs the train.'),
(11, 'Teller', 'Sells tickets at the station.');

-- Populating EMPLOYEE
INSERT INTO `EMPLOYEE` (`EMP_ID`, `EMP_FNAME`, `EMP_LNAME`, `EMP_HIREDATE`, `JOB_CODE`, `REPORTS_TO`) VALUES
(0001, 'Shea', 'Manser', '2016-12-25', 1, null), -- CEO
(0010, 'Hesther', 'Collecott', '2013-12-27', 2, 0001), -- COO
(0011, 'Crystie', 'Dowsey', '2006-06-21', 5, 0010), -- Station Manager 1
(0100, 'Hulda', 'Geany', '2007-11-2', 5, 0010), -- Station Manager 2
(0101, 'Gustaf', 'Wraith', '2012-05-29', 6, 0010), -- Train Manager 1
(0110, 'Anya', 'Rusted', '2017-02-22', 6, 0010), -- Train Manager 2
(0111, 'Skippy', 'Dodshun', '2005-10-22', 4, 0011), -- Head Mechanic 1
(1000, 'Maia', 'Yuranovev', '2016-07-26', 4, 0100), -- Head Mechanic 2
(1001, 'Pat', 'Britian', '2016-02-10', 9, 0111), -- Mechanics
(1010, 'Philipa', 'Bolesworth', '2002-09-02', 9, 0111),
(1011, 'Ilyse', 'Krimmer', '2004-04-19', 9, 1000),
(1100, 'Saraann', 'Hetterich', '2003-10-05', 9, 1000),
(1101, 'Traci', 'Marciskewski', '2011-08-04', 11, 0011), -- Tellers
(1110, 'Cobbie', 'Canfer', '2000-04-22', 11, 0100),
(1111, 'Sloan', 'Quixley', '2001-01-08', 3, 0101), -- Head Steward 1
(0002, 'Thornton', 'Pyke', '2004-10-28', 3, 0110), -- Head Steward 2
(0020, 'Amity', 'Aidler', '2003-05-06', 7, 1111), -- Stewardesses 
(0022, 'Karoly', 'Rippin', '2020-09-26', 7, 1111),
(0200, 'Alecia', 'Filipowicz', '2020-10-25', 7, 0002),
(0202, 'Rowan', 'Farnworth', '2002-09-23', 7, 0002),
(0220, 'Sascha', 'Hallowes', '2002-07-21', 8, 1111), -- Cafe Attendants
(0222, 'Darrel', 'Chiverstone', '2019-07-10', 8, 0002),
(2000, 'Teodoor', 'Pottle', '2007-04-25', 5, 0010), -- Station Manager 3
(2002, 'Piggy', 'Cawte', '2019-12-14', 11, 2000), -- Teller
(2020, 'Kanye', 'West', '2008-06-04', 4, 2000), -- Head Mechanic 3
(2022, 'Cloe', 'Muddiman', '2013-09-01', 9, 2020), -- Mechanics (3)
(2200, 'Camilla', 'Pitcher', '2009-12-26', 9, 2020),
(2202, 'Vail', 'Cawt', '2000-12-04', 9, 2020),
(2220, 'Bonnibelle', 'Bellam', '2020-09-14', 10, 0110), -- Conductors
(2222, 'Dwain', 'Siviter', '2017-12-20', 10, 0101),
(0003, 'Nanette', 'Guille', '2015-11-20', 5, 0010), -- Station Manager 4
(0030, 'Diandra', 'Newsome', '2005-03-01', 5, 0010), -- Station Manager 5
(0033, 'Eduardo', 'Waliszek', '2015-06-05', 4, 0003), -- Head Mechanics
(0300, 'Nyssa', 'Chucks', '2014-08-14', 4, 0030),
(0303, 'Che', 'Peyes', '2005-05-05', 11, 0003), -- Tellers
(0330, 'Dal', 'Boon', '2015-06-16', 11, 0030),
(0333, 'Abram', 'Simonian', '2006-01-09', 9, 0033), -- Mechanics
(3000, 'Wendall', 'Satterthwaite', '2017-03-30', 9, 0033),
(3003, 'Curtice', 'Reinisch', '2001-04-20', 9, 0300),
(3030, 'Blake', 'Le Count', '2020-03-13', 9, 0300),
(3033, 'Gaspard', 'Holbarrow', '2004-07-05', 6, 0010), -- Train Manager 3
(3300, 'Harlin', 'Cornelissen', '2002-01-03', 6, 0010), -- Train Manager 4
(3303, 'Susan', 'Lanphere', '2018-04-19', 3, 3033), -- Head Steward 3
(3330, 'Theodora', 'MacNair', '2000-12-31', 3, 3300), -- Head Steward 4
(3333, 'Grete', 'Mallabon', '2016-08-13', 7, 3303), -- Stewards
(0004, 'Maxwell', 'Heenan', '2015-04-01', 7, 3330),
(0040, 'Zsazsa', 'Easman', '2004-09-13', 7, 3303),
(0044, 'Zonnya', 'Symcoxe', '011-04-13', 7, 3330),
(0400, 'Eleen', 'Tetther', '2011-11-11', 8, 3303), -- Cafe Attendants
(0404, 'Jack', 'Devonside', '2002-02-02', 8, 3330),
(0440, 'Joe', 'Biden', '2004-04-04', 10, 3033), -- Conductors
(0444, 'Donald', 'Trump', '2008-08-08', 10, 3300);


-- Populating MECHANIC
INSERT INTO `MECHANIC` (`EMP_ID`, `CERT_DATE`, `CERT_EXP`) VALUES
(1001, '2019-03-04', '2024-03-04'),
(1010, '2015-12-05', '2020-12-05'),
(1011, '2016-07-06', '2021-07-06'),
(1100, '2016-07-06', '2021-07-06'),
(2022, '2017-05-05', '2022-05-05'),
(2200, '2020-08-05', '2021-08-05'),
(2202, '2018-01-05', '2023-01-05'),
(0333, '2016-09-12', '2021-09-12'),
(3000, '2020-11-15', '2025-11-15'),
(3003, '2018-02-20', '2023-02-20'),
(3030, '2019-06-04', '2024-06-03');

-- Populating CONDUCTOR
INSERT INTO `CONDUCTOR` (`EMP_ID`, `CERT_DATE`, `CERT_EXP`) VALUES
(2220, '2020-01-08', '2025-01-08'),
(2222, '2019-09-12', '2024-09-12'),
(0440, '2017-12-15', '2022-12-15'),
(0444, '2018-07-04', '2023-07-04');

-- Populating CAR
INSERT INTO CAR (CAR_NUM, CAR_DESC, CAR_CAPACITY) VALUES
(101, 'WAUZL54B01N482168', 25),
(102, '1G6DM5EG3A0389360', 25),
(103, '3N1BC1CP8CK567250', 25),
(104, '4T1BK1EB9EU135251', 25),
(105, 'KNADH4A38A6117024', 25),
(106, 'WDDJK7DA0FF026345', 25),
(107, '1G6DH8E35E0524895', 25),
(108, '1N6AA0CH9DN457236', 25),
(109, 'JM1GJ1U5XF1095466', 25),
(110, '1GKS1AKC0FR064566', 25),
(111, '1G6KD57Y76U506838', 25),
(112, 'WBAYM9C56DD766894', 25),
(113, 'WBAEV33433K541654', 25),
(114, 'WDDEJ7EB5BA691597', 3),
(115, '5YMGY0C59AL719852', 25),
(116, 'WA1WKBFP5AA221698', 25),
(117, 'WBAYM9C51DD942198', 25),
(118, '2B3CM5CT1BH479663', 6),
(119, '2FMDK4GC2AB775914', 25),
(120, 'WDCGG5GBXBF772210', 25),
(121, '1G4HD57218U692393', 25),
(122, '3D7LT2ET1AG955430', 25),
(123, '5XYKT3A1XCG599657', 25),
(124, '1G4PP5SK8F4185238', 25),
(125, '2V4RW3D16AR793327', 25),
(126, '1GYS3DEFXDR361543', 25),
(127, '1N6AA0CA1DN937466', 25),
(128, '1N4AB7AP3DN819893', 19),
(129, '2G4WS52J111516036', 25),
(130, 'WAULFAFR2CA401813', 25);
		    
-- Populating PASSENGER
INSERT INTO `PASSENGER` (`PASS_ID`, `PASS_FNAME`, `PASS_LNAME`, `PASS_STREET`, `PASS_CITY`, `PASS_STATE`, `PASS_ZIP`, `PASS_COUNTRY`) VALUES
(1, 'Lyndsay', 'Pfeffer', '77 Anzinger Hill', 'Kresna', null, 34312, 'Bulgaria'),
(2, 'Lacie', 'Kealey', '51 Hayes Place', 'Paracuru', null, 80559, 'Brazil'),
(3, 'Lowe', 'Perocci', '8572 Bultman Drive', 'Gaoqiao', null, 23154, 'China'),
(4, 'Dominic', 'Gratrix', '9312 Express Center', 'Outlook', 'SK', 72395, 'Canada'),
(5, 'Renee', 'Palatino', '3 Sutteridge Park', 'Valcheta', null, 95794, 'Argentina'),
(6, 'Kimmi', 'Derr', '660 American Center', 'Jiyang', null, 24671, 'China'),
(7, 'Garrek', 'Robberts', '622 Cordelia Park', 'Pregrada', null, 99253, 'Croatia'),
(8, 'Estel', 'Maundrell', '70 Union Lane', 'Murów', null, 31630, 'Poland'),
(9, 'Waring', 'Cownden', '045 Novick Hill', 'Nifuboko', null, 17181, 'Indonesia'),
(10, 'Natalee', 'Aldous', '9 Eastwood Terrace', 'Isoka', null, 48688, 'Zambia'),
(11, 'Antony', 'Sebright', '5 Anniversary Road', 'Lewopao', null, 41415, 'Indonesia'),
(12, 'Ilise', 'Rushworth', '67797 Bellgrove Pass', 'Węgliniec', null, 45023, 'Poland'),
(13, 'Lois', 'Proudlove', '6839 Victoria Parkway', 'Maqiu', null, 32275, 'China'),
(14, 'Franciskus', 'Reichhardt', '568 Transport Hill', 'Pandan Niog', null, 37445, 'Philippines'),
(15, 'Renato', 'Stille', '2793 Moose Way', 'Zhaxirabdain', null, 91597, 'China'),
(16, 'Annecorinne', 'Sharply', '11 Hoepker Way', 'Verkh-Usugli', null, 82474, 'Russia'),
(17, 'Krista', 'Hamsley', '387 Mariners Cove Point', 'Åhus', 'M', 35103, 'Sweden'),
(18, 'Ly', 'Roggieri', '4948 Farragut Avenue', 'Lomba', '01', 91060, 'Portugal'),
(19, 'Muire', 'Schwaiger', '718 Mandrake Center', 'Zhangpu', null, 99412, 'China'),
(20, 'Justino', 'Wakelam', '3 Canary Crossing', 'Marsa Alam', null, 54572, 'Egypt'),
(21, 'Jacinta', 'Andrich', '63 Hovde Lane', 'Yanqul', null, 59768, 'Oman'),
(22, 'Franciska', 'McFarlane', '3 Forest Avenue', 'São Sebastião', null, 22242, 'Brazil'),
(23, 'Gretal', 'Korejs', '6368 Harper Alley', 'Gandrungmangu', null, 34399, 'Indonesia'),
(24, 'Elvera', 'Tuerena', '7 Monica Point', 'Nalinggou', null, 50735, 'China'),
(25, 'Jane', 'Maddock', '917 Mayfield Junction', 'Rucava', null, 38127, 'Latvia'),
(26, 'Elisabetta', 'Linsley', '9487 Alpine Trail', 'Sorang', null, 71618, 'Kazakhstan'),
(27, 'Rad', 'Bocken', '52885 Ryan Way', 'Powassan', 'ON', 75827, 'Canada'),
(28, 'Lin', 'Aitchinson', '553 Stone Corner Pass', 'Yingtan', null, 81114, 'China'),
(29, 'Caz', 'Feye', '1420 Oriole Junction', 'Ébolowa', null, 34461, 'Cameroon'),
(30, 'Valentia', 'Panons', '0 Westridge Avenue', 'Frolovo', null, 41176, 'Russia'),
(31, 'Barthel', 'Bellhanger', '091 Spaight Pass', 'Jayapura', null, 76959, 'Indonesia'),
(32, 'Roselia', 'Berecloth', '0 Jackson Center', 'Paiçandu', null, 65083, 'Brazil'),
(33, 'Rey', 'Jiru', '2 Continental Drive', 'Tolomango', null, 83706, 'Indonesia'),
(34, 'Selene', 'Keld', '9 Packers Pass', 'Poyang', null, 78120, 'China'),
(35, 'Wakefield', 'Lammerts', '76 Hagan Parkway', 'Lunec', null, 95954, 'Philippines'),
(36, 'Benjie', 'Danell', '48475 Porter Center', 'Indang', null, 13997, 'Philippines'),
(37, 'Georgi', 'McGrill', '2180 Dakota Pass', 'Cilegi', null, 98205, 'Indonesia'),
(38, 'Hew', 'Tuberfield', '405 Mifflin Terrace', 'Huayang', null, 47717, 'China'),
(39, 'Mal', 'Halleybone', '1 Crest Line Crossing', 'Goge', null, 70381, 'Indonesia'),
(40, 'De', 'Kuhnel', '54 Anniversary Lane', 'Xinglongquan', null, 46817, 'China'),
(41, 'Ferdinanda', 'De La Coste', '6 Crowley Court', 'Salinungan Proper', null, 12107, 'Philippines'),
(42, 'Hillard', 'Swigg', '59738 8th Trail', 'Budapest', 'BU', 82720, 'Hungary'),
(43, 'King', 'Vel', '945 Lillian Drive', 'Shuangxiqiao', null, 15671, 'China'),
(44, 'Nilson', 'MacKeogh', '11 North Drive', 'Caaguazú', null, 79021, 'Paraguay'),
(45, 'Frances', 'Legen', '6 Thackeray Lane', 'Ḩalabjah', null, 84080, 'Iraq'),
(46, 'Ruperta', 'O''Lunney', '52855 Talmadge Terrace', 'Apaga', null, 13331, 'Armenia'),
(47, 'Townsend', 'Yurtsev', '69370 Anhalt Park', 'Kostakioí', null, 58826, 'Greece'),
(48, 'Malia', 'Bodicum', '33875 Bluestem Drive', 'Zhaojia', null, 39434, 'China'),
(49, 'Amanda', 'Chastenet', '1886 Merchant Park', 'Ribeirão', '03', 63914, 'Portugal'),
(50, 'Winn', 'Beminster', '1 Melby Road', 'Ji’an', null, 64810, 'China'),
(51, 'Marchall', 'Peracco', '0 Glendale Road', 'Pamoyanan', null, 59973, 'Indonesia'),
(52, 'Selby', 'Abson', '83 Pearson Junction', 'El Dividive', null, 75961, 'Venezuela'),
(53, 'Ola', 'Iannazzi', '7 Milwaukee Crossing', 'Ceper', null, 38689, 'Indonesia'),
(54, 'Odessa', 'Hubbuck', '3 Ronald Regan Plaza', 'Singapore', null, 21742, 'Singapore'),
(55, 'Nata', 'Studholme', '457 Brentwood Avenue', 'Bangunsari', null, 68140, 'Indonesia'),
(56, 'Morrie', 'Soars', '89 Holmberg Junction', 'Ondoy', null, 48610, 'Philippines'),
(57, 'Collie', 'Cullimore', '32929 Briar Crest Avenue', 'Troyes', 'A4', 14786, 'France'),
(58, 'Faulkner', 'Traise', '780 Mendota Alley', 'Linköping', 'E', 42633, 'Sweden'),
(59, 'Noel', 'Colchett', '0902 Scott Pass', 'Vryburg', null, 35473, 'South Africa'),
(60, 'Maximilianus', 'Huchot', '78 Northridge Lane', 'Zhongchuan', null, 60223, 'China'),
(61, 'Lea', 'Thing', '15 Corry Street', 'Qārah', null, 63822, 'Syria'),
(62, 'Neill', 'Bremley', '4002 Scofield Lane', 'Puyehue', null, 82078, 'Chile'),
(63, 'Tisha', 'Manzell', '960 Superior Place', 'Luqa', null, 38964, 'Malta'),
(64, 'Margery', 'Crocombe', '3 Walton Junction', 'Calle Blancos', null, 95001, 'Costa Rica'),
(65, 'Nariko', 'Esplin', '6096 Scoville Parkway', 'La Habana Vieja', null, 78677, 'Cuba'),
(66, 'Celka', 'Renard', '222 Drewry Circle', 'Aḑ Ḑil‘', null, 92454, 'Yemen'),
(67, 'Jeane', 'Dryburgh', '25304 1st Court', 'Yaroslavskaya', null, 17626, 'Russia'),
(68, 'Mab', 'Gandey', '152 Coolidge Alley', 'Pende', null, 89545, 'Indonesia'),
(69, 'Adelaida', 'Boatwright', '649 Kennedy Crossing', 'Lanuza', null, 10147, 'Philippines'),
(70, 'Correna', 'Tomblings', '24 Cardinal Parkway', 'Hrušovany u Brna', null, 19575, 'Czech Republic'),
(71, 'Nannie', 'Switzer', '3613 Porter Way', 'Baños', null, 71873, 'Ecuador'),
(72, 'Ki', 'Davidesco', '6895 Grover Avenue', 'Saint Petersburg', null, 97595, 'Russia'),
(73, 'Alon', 'Gowenlock', '860 Sunbrook Junction', 'Andong', null, 18664, 'South Korea'),
(74, 'Reggi', 'Laidlaw', '966 Blue Bill Park Alley', 'Ziway', null, 80053, 'Ethiopia'),
(75, 'Robin', 'Toombes', '18925 Mesta Terrace', 'Porto Formoso', '42', 29938, 'Portugal'),
(76, 'Cammy', 'Penright', '41 Kinsman Way', 'Atescatempa', null, 44220, 'Guatemala'),
(77, 'Jdavie', 'Leward', '05 Barnett Avenue', 'Tamaki', null, 57962, 'New Zealand'),
(78, 'Nannette', 'Watterson', '127 Karstens Road', 'Chengji', null, 35683, 'China'),
(79, 'Harold', 'Grishakov', '9 Helena Point', 'Kato Pyrgos', null, 71182, 'Cyprus'),
(80, 'Elnore', 'Raybould', '883 School Drive', 'Hatton', null, 89712, 'Sri Lanka'),
(81, 'Nonna', 'Barnes', '66090 Twin Pines Avenue', 'Nevel’', null, 97170, 'Russia'),
(82, 'Tate', 'Islep', '6 Anzinger Circle', 'Ōtawara', null, 25947, 'Japan'),
(83, 'Andonis', 'Mordin', '02139 Northfield Hill', 'Aūa', null, 97144, 'American Samoa'),
(84, 'Isacco', 'Kimpton', '3922 Sachs Plaza', 'Canoas', null, 49841, 'Brazil'),
(85, 'Kristos', 'MacGahey', '783 Claremont Park', 'Wucun', null, 45088, 'China'),
(86, 'Angelika', 'Lowndsbrough', '68729 Manufacturers Court', 'Zhangjiafang', null, 65344, 'China'),
(87, 'Pammie', 'Duddin', '071 Jay Center', 'Urbiztondo', null, 91049, 'Philippines'),
(88, 'Fremont', 'Curbishley', '47 Jenna Circle', 'Liangchahe', null, 60791, 'China'),
(89, 'Roland', 'Frosch', '69763 Independence Center', 'Ancol', null, 61996, 'Indonesia'),
(90, 'Claiborne', 'Petrasch', '813 Colorado Junction', 'Luokeng', null, 30565, 'China'),
(91, 'Kaleena', 'Maior', '42 Eagle Crest Pass', 'Oliveiras', '13', 95583, 'Portugal'),
(92, 'Isabella', 'Sellack', '5 Quincy Way', 'Porsgrunn', '08', 35648, 'Norway'),
(93, 'Ramsey', 'Ryrie', '5 Northview Junction', 'Pásion', null, 99786, 'Greece'),
(94, 'Robby', 'Coronado', '47 Lakewood Court', 'Guangyuan', null, 33155, 'China'),
(95, 'Ferris', 'McDarmid', '99742 Schmedeman Junction', 'København', '1084', 56507, 'Denmark'),
(96, 'Lenora', 'Balmforth', '79867 Elmside Court', 'Petrodvorets', null, 84711, 'Russia'),
(97, 'Sheila-kathryn', 'Warrior', '887 Grasskamp Place', 'Jovellanos', null, 43180, 'Cuba'),
(98, 'Farra', 'Crenshaw', '73980 Sloan Hill', 'Tangzang', null, 13999, 'China'),
(99, 'Hedwiga', 'Klink', '44339 Mendota Drive', 'Puan Selatan', null, 82889, 'Indonesia'),
(100, 'Elora', 'Godilington', '1780 Tony Center', 'Masuda', null, 68790, 'Japan'),
(101, 'Felicio', 'Knuckles', '63 Donald Point', 'El Paso', 'TX', 75795, 'United States'),
(102, 'Darius', 'Pittwood', '8 Northview Court', 'Flint', 'MI', 82664, 'United States'),
(103, 'Marwin', 'Benneyworth', '8 Glacier Hill Drive', 'Pasadena', 'CA', 47151, 'United States'),
(104, 'Irita', 'Mottinelli', '64 Sommers Point', 'Raleigh', 'NC', 81424, 'United States'),
(105, 'Uta', 'Leyfield', '59 Dayton Lane', 'Pittsburgh', 'PA', 33717, 'United States'),
(106, 'Johnette', 'Rist', '3 Onsgard Way', 'Houston', 'TX', 18325, 'United States'),
(107, 'Talya', 'Suston', '62341 Cherokee Terrace', 'Houston', 'TX', 37646, 'United States'),
(108, 'Edgar', 'Scorrer', '46837 Mifflin Place', 'El Paso', 'TX', 43434, 'United States'),
(109, 'Liesa', 'Bocke', '48427 Pearson Lane', 'Syracuse', 'NY', 76144, 'United States'),
(110, 'Merry', 'Parkey', '7425 Norway Maple Court', 'Atlanta', 'GA', 55268, 'United States'),
(111, 'Cicely', 'Hukins', '468 Randy Center', 'New York City', 'NY', 42093, 'United States'),
(112, 'Waldon', 'Colhoun', '1421 Transport Street', 'Phoenix', 'AZ', 20989, 'United States'),
(113, 'Imojean', 'Garnson', '9109 Menomonie Plaza', 'Rockville', 'MD', 64150, 'United States'),
(114, 'Elfrieda', 'Rallings', '14983 Nancy Place', 'Dayton', 'OH', 71258, 'United States'),
(115, 'Blake', 'Knifton', '38 3rd Court', 'Atlanta', 'GA', 78579, 'United States'),
(116, 'Georgeanna', 'Brotherick', '9501 Myrtle Plaza', 'Madison', 'WI', 41420, 'United States'),
(117, 'Mitchael', 'Underhill', '04 Scott Alley', 'Phoenix', 'AZ', 95890, 'United States'),
(118, 'Pearla', 'Ralston', '48 Merrick Avenue', 'Lincoln', 'NE', 97114, 'United States'),
(119, 'Hephzibah', 'Playhill', '2 Derek Street', 'Jackson', 'MS', 34382, 'United States'),
(120, 'Lesli', 'Viger', '633 Stuart Crossing', 'Tucson', 'AZ', 36096, 'United States'),
(121, 'Binny', 'Leinster', '7193 Raven Terrace', 'Santa Fe', 'NM', 72976, 'United States'),
(122, 'Cord', 'Hutton', '262 Fairfield Place', 'Daytona Beach', 'FL', 47282, 'United States'),
(123, 'Rand', 'Steinhammer', '00625 Cottonwood Junction', 'Oakland', 'CA', 86043, 'United States'),
(124, 'Erroll', 'Nesterov', '5 Schiller Parkway', 'Sterling', 'VA', 84548, 'United States'),
(125, 'Selena', 'Spurge', '979 Oak Valley Terrace', 'Corpus Christi', 'TX', 95147, 'United States'),
(126, 'Marina', 'Perritt', '5319 Birchwood Point', 'San Diego', 'CA', 14802, 'United States'),
(127, 'Brendis', 'Denisyev', '3842 Atwood Parkway', 'Harrisburg', 'PA', 44109, 'United States'),
(128, 'Matteo', 'Slyne', '82 Macpherson Pass', 'Henderson', 'NV', 19897, 'United States'),
(129, 'Avril', 'Kupke', '9 Badeau Street', 'Inglewood', 'CA', 80271, 'United States'),
(130, 'Truda', 'Rickson', '024 Crowley Street', 'Waco', 'TX', 66455, 'United States');

-- Populating STATION
INSERT INTO STATION (STAT_NUM, STAT_STREET, STAT_CITY, STAT_STATE, STAT_ZIP, STAT_COUNTRY) VALUES 
(101, '148 Crest Line Plaza', 'New York City', 'New York', 74091, 'United States'),
(102, '0765 Hagan Center', 'München', 'Bayern', 16928, 'Germany'),
(103, '52 Dottie Trail', 'Tokyo', null, 60131, 'Japan'),
(104, '455 Fieldstone Crossing', 'London', 'England', 78256, 'United Kingdom'),
(105, '21657 Dakota Center', 'Paris', 'Île-de-France', 42182, 'France');

-- Populating ENGINE
INSERT INTO ENGINE (ENG_NUM, ENG_MODEL, ENG_DESC) VALUES
(101, 'AC6000CW', '6000 hp'),
(102, 'AC4460CW', '6000 hp'),
(103, 'CW46AH', '4600 hp'),
(104, 'AC6000CW', '6000 hp'),
(105, 'CW60AC', '5100 hp'),
(106, 'AC4460CW', '6000 hp, chassis is corroded, needs repairs'),
(107, 'CW60AC', '5100 hp, cylinders keep misfiring, needs repairs');

-- Populating INVOICE
INSERT INTO `INVOICE` (`INV_ID`, `PRICE`, `CONF_CODE`, `PASS_ID`, `P_DATE`) VALUES
(1, 2859.74, '264KUT', 1, '2020-03-31'),
(2, 1411.6, '374SHR', 2, '2020-04-17'),
(3, 2947.63, '923PRK', 3, '2020-02-18'),
(4, 2960.95, '124VKI', 4, '2020-03-20'),
(5, 879.43, '183GED', 5, '2020-03-17'),
(6, 2687.84, '413PHL', 6, '2020-02-13'),
(7, 1800.47, '803LAQ', 7, '2019-11-09'),
(8, 1462.54, '607HYJ', 8, '2020-01-18'),
(9, 1410.38, '880CIR', 9, '2020-03-31'),
(10, 1181.25, '377MHU', 10, '2020-05-08'),
(11, 1563.68, '544UEG', 11, '2020-03-22'),
(12, 1091.4, '253TJE', 12, '2019-12-21'),
(13, 2342.57, '937BMR', 13, '2019-12-10'),
(14, 1318.2, '107BVZ', 14, '2019-11-30'),
(15, 1655.55, '423GYV', 15, '2020-03-07'),
(16, 1672.23, '174KTJ', 16, '2020-02-09'),
(17, 1077.77, '128VYN', 17, '2020-01-05'),
(18, 1447.72, '506WEQ', 18, '2020-03-04'),
(19, 1795.25, '677DPB', 19, '2020-05-06'),
(20, 1003.64, '909ELZ', 20, '2020-01-27'),
(21, 2645.73, '483BBO', 21, '2019-10-27'),
(22, 2953.79, '605HSU', 22, '2020-04-10'),
(23, 1117.61, '435OVT', 23, '2020-03-27'),
(24, 1795.9, '321TTL', 24, '2020-02-06'),
(25, 1399.02, '459KML', 25, '2020-02-22'),
(26, 866.19, '230UAK', 26, '2019-11-15'),
(27, 1008.3, '391MDE', 27, '2020-02-27'),
(28, 2429.74, '830PWX', 28, '2020-01-13'),
(29, 1321.11, '933YTW', 29, '2020-02-28'),
(30, 1018.07, '438RTY', 30, '2019-11-12'),
(31, 2487.59, '139XUV', 31, '2019-12-23'),
(32, 2970.41, '097OCB', 32, '2020-03-22'),
(33, 1319.3, '050IKF', 33, '2019-11-19'),
(34, 2073.54, '366GSC', 34, '2019-11-18'),
(35, 951.06, '263VRU', 35, '2020-01-10'),
(36, 1230.79, '362RKK', 36, '2019-11-21'),
(37, 2453.41, '854CQR', 37, '2020-04-18'),
(38, 2337.11, '241XIA', 38, '2020-02-04'),
(39, 1401.64, '201YRG', 39, '2020-03-11'),
(40, 2223.06, '749MXC', 40, '2019-11-26'),
(41, 1113.43, '670EKA', 41, '2019-11-07'),
(42, 2545.92, '513LKA', 42, '2020-03-28'),
(43, 2551.93, '818JWZ', 43, '2020-02-06'),
(44, 2345.75, '975FRT', 44, '2020-04-07'),
(45, 1577.48, '014IRR', 45, '2019-11-16'),
(46, 1865.83, '875IKF', 46, '2020-02-02'),
(47, 2968.85, '654GPH', 47, '2020-05-06'),
(48, 1600.63, '491JMT', 48, '2019-11-21'),
(49, 2255.14, '977XOQ', 49, '2020-04-18'),
(50, 856.91, '870TDH', 50, '2020-04-20'),
(51, 1557.11, '616CPN', 51, '2019-11-09'),
(52, 2582.66, '988BNU', 52, '2020-04-11'),
(53, 2923.84, '088FSE', 53, '2020-03-10'),
(54, 2954.09, '158MKR', 54, '2020-03-16'),
(55, 1757.58, '499UMJ', 55, '2020-04-02'),
(56, 2992.83, '034ZJB', 56, '2020-04-02'),
(57, 1713.95, '655UOF', 57, '2020-02-08'),
(58, 1452.62, '576OTV', 58, '2020-02-16'),
(59, 1099.31, '200YHE', 59, '2020-03-06'),
(60, 1529.18, '082LWV', 60, '2019-12-21'),
(61, 1805.16, '269SXK', 61, '2020-03-21'),
(62, 2289.19, '839PLQ', 62, '2020-04-12'),
(63, 1902.78, '462QHY', 63, '2019-11-12'),
(64, 1394.26, '727HZF', 64, '2020-04-16'),
(65, 1245.92, '478SYJ', 65, '2020-04-27'),
(66, 1277.34, '750ZNK', 66, '2019-11-01'),
(67, 2744.58, '616HXC', 67, '2019-12-09'),
(68, 928.86, '408AJN', 68, '2020-02-12'),
(69, 2619.4, '496OHR', 69, '2019-12-01'),
(70, 2473.84, '533GFH', 70, '2020-03-08'),
(71, 2941.59, '340BLM', 71, '2020-03-19'),
(72, 1397.88, '660REW', 72, '2020-02-22'),
(73, 2552.08, '169UIU', 73, '2020-03-10'),
(74, 2049.77, '783DJL', 74, '2020-02-01'),
(75, 2635.19, '229KVD', 75, '2020-01-28'),
(76, 1576.59, '063USO', 76, '2019-12-01'),
(77, 1400.08, '156FKL', 77, '2020-04-14'),
(78, 1947.11, '296MWV', 78, '2020-01-16'),
(79, 1269.4, '797CTM', 79, '2020-02-22'),
(80, 1091.31, '441HGP', 80, '2019-11-17'),
(81, 1785.85, '757TQJ', 81, '2019-10-31'),
(82, 2607.82, '943GXX', 82, '2019-12-01'),
(83, 1468.67, '978JCB', 83, '2019-11-28'),
(84, 1771.03, '475QYK', 84, '2020-02-03'),
(85, 2084.57, '213LSK', 85, '2019-11-06'),
(86, 2569.76, '238LRN', 86, '2020-01-18'),
(87, 2108.0, '173GHN', 87, '2019-12-24'),
(88, 2451.96, '266OCB', 88, '2019-11-12'),
(89, 826.84, '653MUA', 89, '2020-02-13'),
(90, 2027.8, '810PNK', 90, '2019-11-06'),
(91, 1761.62, '986CYA', 91, '2020-02-26'),
(92, 2381.89, '041RBP', 92, '2020-01-31'),
(93, 2635.93, '311GJY', 93, '2020-01-12'),
(94, 1652.63, '989BST', 94, '2020-05-05'),
(95, 2151.57, '942OCZ', 95, '2020-04-11'),
(96, 2489.81, '561USR', 96, '2020-02-12'),
(97, 2137.97, '900BOJ', 97, '2020-03-17'),
(98, 1557.69, '503XPM', 98, '2020-05-09'),
(99, 2613.93, '395SKV', 99, '2020-01-12'),
(100, 2931.14, '024EGB', 100, '2019-11-22'),
(101, 2657.42, '982HOG', 101, '2020-05-01'),
(102, 1913.86, '883TXF', 102, '2020-01-20'),
(103, 2847.43, '577RTZ', 103, '2020-03-10'),
(104, 2488.27, '916URE', 104, '2020-01-26'),
(105, 1489.94, '738YDI', 105, '2020-01-12'),
(106, 1161.8, '477TKS', 106, '2020-05-10'),
(107, 1746.77, '082FAF', 107, '2020-03-10'),
(108, 2212.38, '789RRD', 108, '2019-12-31'),
(109, 1779.69, '723BJQ', 109, '2020-03-22'),
(110, 2813.97, '915OKG', 110, '2020-04-14'),
(111, 815.74, '120NPD', 111, '2020-04-04'),
(112, 1009.18, '875HSB', 112, '2019-11-23'),
(113, 1670.65, '514KYB', 113, '2020-04-18'),
(114, 1069.63, '450LIZ', 114, '2020-01-07'),
(115, 1116.13, '273ZRL', 115, '2019-12-31'),
(116, 1031.28, '804IBC', 116, '2020-01-12'),
(117, 2423.05, '687DMQ', 117, '2020-03-26'),
(118, 1665.12, '713BFH', 118, '2020-01-07'),
(119, 1385.09, '544RMA', 119, '2019-12-21'),
(120, 1433.51, '373ZFJ', 120, '2019-12-23'),
(121, 1767.74, '537YIS', 121, '2020-03-10'),
(122, 2400.54, '974UFA', 122, '2019-11-27'),
(123, 1767.05, '707IIH', 123, '2019-10-24'),
(124, 1622.24, '810GUM', 124, '2019-12-01'),
(125, 1755.43, '896OCT', 125, '2020-02-27'),
(126, 2839.71, '680JQU', 126, '2019-10-27'),
(127, 2710.42, '762KDV', 127, '2019-11-12'),
(128, 1070.89, '898MIO', 128, '2019-12-27'),
(129, 2206.03, '845XZO', 129, '2020-03-24'),
(130, 1111.91, '589ZJE', 130, '2019-12-09'),
(131, 1151.99, '325OEG', 84, '2020-04-08'),
(132, 1136.92, '168CEI', 124, '2019-11-02'),
(133, 2627.5, '744VXJ', 69, '2020-03-02'),
(134, 1184.19, '819WCO', 112, '2020-04-18'),
(135, 2936.35, '962XOU', 115, '2019-12-09'),
(136, 1078.67, '239XIP', 98, '2019-11-16'),
(137, 2423.74, '844RTQ', 23, '2020-04-08'),
(138, 1473.4, '572IEM', 69, '2020-04-27'),
(139, 2514.62, '467TRJ', 122, '2020-03-19'),
(140, 1652.34, '192FDE', 5, '2020-01-22'),
(141, 2030.24, '096KTD', 75, '2019-11-05'),
(142, 1425.95, '793SBV', 114, '2020-04-09'),
(143, 1758.38, '723FMM', 52, '2019-11-12'),
(144, 1385.44, '778ESA', 81, '2020-04-28'),
(145, 826.47, '312UIR', 90, '2019-10-23'),
(146, 1133.01, '061WFA', 116, '2020-01-17'),
(147, 2809.45, '133OGK', 6, '2020-05-06'),
(148, 1448.74, '426JRV', 125, '2019-11-10'),
(149, 2209.79, '247CNI', 125, '2019-12-26'),
(150, 1656.64, '423UMZ', 54, '2019-10-29'),
(151, 1668.9, '984CLT', 82, '2020-03-11'),
(152, 928.28, '509ETB', 122, '2019-12-01'),
(153, 848.07, '511SMZ', 113, '2020-03-11'),
(154, 2028.46, '828ZPI', 13, '2020-03-27'),
(155, 1523.35, '124KCX', 25, '2020-03-10'),
(156, 2448.21, '910MPU', 87, '2019-10-29'),
(157, 1203.38, '990HAF', 69, '2019-11-03'),
(158, 1756.64, '360MBR', 91, '2020-04-10'),
(159, 2368.92, '057SPG', 51, '2020-04-18'),
(160, 2878.93, '946APF', 107, '2020-02-28');
		    
-- Populating TRAIN
INSERT INTO `TRAIN` (`TRAIN_NUM`, `CONDUCTOR_ID`, `NUM_SEATS`) VALUES
(453, 2220, null),
(145, 2222, null),
(342, 0040, null),
(234, null, null), -- unused train (unassigned to any route, etc.)
(361, 0444, null),
(253, null, null); -- unused train
-- We'll replace the NUM_SEATS when we get proper values but for now this should be enough
-- Engines with lower HP can be used to carry less people.
		    
-- Populating ENGINE_ASSGN
INSERT INTO `ENGINE_ASSGN` (`E_ASSGN`, `ENG_NUM`, `TRAIN_NUM`, `START_DATE`, `END_DATE`) VALUES
(1, 107, 453, '2014-09-29', '2016-04-12'),
(2, 104, 145, '2015-01-12', '2020-04-14'),
(3, 105, 361, '2015-07-15', null),
(4, 103, 453, '2016-06-20', null),
(5, 107, 234, '2017-03-07', null),
(6, 106, 342, '2018-08-12', '2019-11-05'),
(7, 106, 253, '2019-09-05', null),
(8, 101, 342, '2019-12-01', null),
(9, 104, 145, '2020-6-24', null);

-- Populating ROUTE
INSERT INTO ROUTE (ROUTE_NUM, ORIGIN, DESTINATION) VALUES
(001, 101, 105),
(002, 102, 104),
(003, 104, 103),
(004, 103, 105),
(005, 105, 102),
(006, 101, 103),
(007, 105, 101),
(008, 104, 102),
(009, 103, 104),
(010, 105, 103),
(011, 102, 105),
(012, 103, 101);

-- Populating ROUTE_ASSGN
INSERT INTO ROUTE_ASSGN (R_ASSGN, ROUTE_NUM, TRAIN_NUM, TRUE_DEPT, TRUE_ARR, EST_DEPT, EST_ARRIVAL) VALUES
(0000001, 001, 453, '2020-05-18 18:40:08', '2020-05-18 21:47:16', '2020-05-18 18:30:00', '2020-05-18 21:30:00'),
(0000002, 002, 145, '2020-05-18 10:20:00', '2020-05-18 15:30:16', '2020-05-18 10:30:00', '2020-05-18 15:10:00'),
(0000003, 003, 342, '2020-05-18 14:00:15', '2020-05-18 19:38:16', '2020-05-18 13:50:00', '2020-05-18 19:30:00'),
(0000004, 004, 361, '2020-05-18 18:40:08', '2020-05-18 21:47:16', '2020-05-18 18:30:00', '2020-05-18 21:30:00'),
(0000005, 005, 361, '2020-05-19 22:40:08', '2020-05-20 10:47:16', '2020-05-19 22:30:00', '2020-05-20 10:30:00'),
(0000006, 006, 453, '2020-05-20 18:40:08', '2020-05-19 21:47:16', '2020-05-19 18:30:00', '2020-05-19 21:30:00'),
(0000007, 007, 453, '2020-05-19 18:40:08', '2020-05-19 21:47:16', '2020-05-19 18:30:00', '2020-05-19 21:30:00'),
(0000008, 008, 145, '2020-05-19 18:40:08', '2020-05-19 21:47:16', '2020-05-19 18:30:00', '2020-05-19 21:30:00'),
(0000009, 009, 342, '2020-05-19 18:40:08', '2020-05-19 21:47:16', '2020-05-19 18:30:00', '2020-05-19 21:30:00'),
(0000010, 010, 361, '2020-05-19 18:40:08', '2020-05-19 21:47:16', '2020-05-19 18:30:00', '2020-05-19 21:30:00'),
(0000011, 011, 361, '2020-05-19 18:40:08', '2020-05-19 21:47:16', '2020-05-19 18:30:00', '2020-05-19 21:30:00'),
(0000012, 012, 453, '2020-05-19 18:40:08', '2020-05-19 21:47:16', '2020-05-19 18:30:00', '2020-05-19 21:30:00');

-- Populating TRAIN_ASSGN
INSERT INTO TRAIN_ASSGN (T_ASSGN, EMP_ID, TRAIN_NUM, START_DATE, END_DATE) VALUES
(0000001, 2220, 453, '2000-01-08', NULL),
(0000002, 3303, 453, '2020-02-10', NULL),
(0000003, 3333, 453, '2020-02-17', NULL),
(0000004, 0040, 453, '2020-01-01', NULL),
(0000005, 0400, 453, '2020-01-01', NULL),
(0000006, 0440, 145, '2000-08-22', NULL),
(0000007, 0002, 145, '2000-01-07', NULL),
(0000008, 0200, 145, '2000-01-07', NULL),
(0000009, 0202, 145, '2000-01-07', NULL),
(0000010, 0222, 145, '2000-01-07', NULL),
(0000011, 0444, 342, '2020-04-17', NULL),
(0000012, 1111, 342, '2019-12-12', NULL),
(0000013, 0020, 342, '2019-12-12', NULL),
(0000014, 0022, 342, '2019-12-12', NULL),
(0000015, 0220, 342, '2019-12-12', NULL),
(0000016, 2222, 361, '2020-05-18', NULL),
(0000017, 3330, 361, '2012-04-22', NULL),
(0000018, 0004, 342, '2019-12-12', NULL),
(0000019, 0044, 342, '2019-12-12', NULL),
(0000020, 0404, 342, '2019-12-12', NULL);

-- Populating STATION_ASSGN
INSERT INTO `STATION_ASSGN` (`STAT_ASSGN`, `EMP_ID`, `STAT_NUM`) VALUES
(1, 0011, 101), -- Station Managers
(2, 0100, 102),
(3, 2000, 103),
(4, 0003, 104),
(5, 0030, 105),
(6, 0111, 101), -- Head Mechanics
(7, 1000, 102),
(8, 2020, 103),
(9, 0033, 104),
(10, 0300, 105),
(11, 1101, 101), -- Tellers
(12, 1110, 102),
(13, 2002, 103),
(14, 0303, 104),
(15, 0330, 105),
(16, 1001, 101), -- Mechanics
(17, 1010, 101),
(18, 1011, 102),
(19, 1100, 102),
(20, 2022, 103),
(21, 2200, 103),
(22, 2202, 103),
(23, 0333, 104),
(24, 3000, 104),
(25, 3003, 105),
(26, 3030, 105);

-- Populating STOPS
INSERT INTO STOPS (ROUTE_NUM, STOP_NUM, STAT_NUM) VALUES
(001, 1, 104),
(002, 1, 105),
(003, 1, 105),
(003, 2, 102),
(004, 1, 102),
(006, 1, 104),
(006, 2, 105),
(006, 3, 102),
(007, 1, 104),
(008, 1, 105),
(009, 1, 102),
(009, 2, 105),
(0011, 1, 102),
(0012, 1, 102),
(0012, 2, 105),
(0012, 3, 104);

-- Populating CAR_ASSGN
INSERT INTO CAR_ASSGN (C_ASSGN, CAR_NUM, TRAIN_NUM, START_DATE, END_DATE) VALUES
(1, 101, 453, '2014-09-29',null),
(2, 102, 453, '2014-09-29',null),
(3, 103, 453, '2014-09-29',null),
(4, 104, 453, '2014-09-29',null),
(5, 105, 453, '2014-09-29',null),
(6, 111, 145, '2014-09-29',null),
(7, 112, 145, '2014-09-29',null),
(13, 113, 145, '2014-09-29',null),
(14, 114, 145, '2014-09-29',null),
(15, 115, 145, '2014-09-29',null),
(16, 116, 342, '2014-09-29',null),
(17, 117, 342, '2014-09-29',null),
(18, 118, 342, '2014-09-29',null),
(19, 119, 342, '2014-09-29',null),
(20, 120, 342, '2014-09-29',null),
(21, 121, 361, '2014-09-29',null),
(22, 122, 361, '2014-09-29',null),
(23, 123, 361, '2014-09-29',null),
(24, 124, 361, '2014-09-29',null),
(25, 125, 361, '2014-09-29',null),
(26, 126, 253, '2014-09-29',null),
(27, 127, 253, '2014-09-29',null),
(28, 128, 253, '2014-09-29',null),
(29, 129, 253, '2014-09-29',null),
(30, 130, 253, '2014-09-29',null);

-- Populating TICKET
INSERT INTO `TICKET` (`TICKET_ID`, `INV_ID`, `R_ASSGN`, `ORIGIN`, `DESTINATION`) VALUES 
(1, 1, 9, 103, 105),
(2, 2, 1, 101, 105),
(3, 3, 1, 101, 105),
(4, 4, 3, 105, 102),
(5, 5, 4, 103, 105),
(6, 6, 12, 102, 101),
(7, 7, 4, 103, 102),
(8, 8, 1, 101, 104),
(9, 9, 7, 104, 101),
(10, 10, 10, 105, 102),
(11, 11, 12, 102, 104),
(12, 12, 8, 104, 102),
(13, 13, 8, 104, 102),
(14, 14, 3, 105, 103),
(15, 15, 2, 102, 104),
(16, 16, 1, 101, 104),
(17, 17, 1, 104, 105),
(18, 18, 9, 102, 104),
(19, 19, 5, 105, 102),
(20, 20, 12, 103, 104),
(21, 21, 10, 105, 101),
(22, 22, 11, 102, 105),
(23, 23, 8, 104, 102),
(24, 24, 10, 105, 102),
(25, 25, 7, 105, 104),
(26, 26, 12, 104, 101),
(27, 27, 3, 105, 103),
(28, 28, 8, 104, 102),
(29, 29, 12, 103, 101),
(30, 30, 3, 104, 102),
(31, 31, 1, 104, 105),
(32, 32, 11, 102, 105),
(33, 33, 11, 102, 105),
(34, 34, 6, 104, 103),
(35, 35, 1, 101, 105),
(36, 36, 9, 102, 104),
(37, 37, 4, 103, 105),
(38, 38, 11, 102, 105),
(39, 39, 5, 105, 102),
(40, 40, 12, 105, 101),
(41, 41, 1, 101, 104),
(42, 42, 2, 102, 105),
(43, 43, 8, 105, 102),
(44, 44, 1, 104, 105),
(45, 45, 11, 102, 105),
(46, 46, 6, 104, 102),
(47, 47, 9, 102, 104),
(48, 48, 8, 104, 102),
(49, 49, 6, 102, 103),
(50, 50, 1, 101, 105),
(51, 51, 8, 104, 105),
(52, 52, 12, 103, 102),
(53, 53, 4, 103, 105),
(54, 54, 3, 104, 103),
(55, 55, 5, 105, 102),
(56, 56, 6, 105, 102),
(57, 57, 11, 102, 105),
(58, 58, 5, 105, 102),
(59, 59, 7, 104, 101),
(60, 60, 1, 101, 105),
(61, 61, 9, 103, 104),
(62, 62, 7, 105, 104),
(63, 63, 2, 102, 105),
(64, 64, 12, 102, 101),
(65, 65, 9, 105, 104),
(66, 66, 5, 105, 102),
(67, 67, 8, 104, 102),
(68, 68, 4, 103, 102),
(69, 69, 4, 103, 105),
(70, 70, 8, 104, 105),
(71, 71, 12, 104, 101),
(72, 72, 3, 104, 102),
(73, 73, 11, 102, 105),
(74, 74, 12, 103, 105),
(75, 75, 1, 101, 105),
(76, 76, 2, 102, 104),
(77, 77, 6, 101, 103),
(78, 78, 11, 102, 105),
(79, 79, 7, 105, 101),
(80, 80, 4, 103, 102),
(81, 81, 1, 101, 105),
(82, 82, 2, 102, 104),
(83, 83, 3, 105, 103),
(84, 84, 4, 103, 105),
(85, 85, 5, 105, 102),
(86, 86, 6, 101, 103),
(87, 87, 7, 105, 104),
(88, 88, 8, 104, 102),
(89, 89, 9, 102, 104),
(90, 90, 10, 105, 102),
(91, 91, 11, 102, 105),
(92, 92, 12, 103, 105),
(93, 93, 11, 102, 105),
(94, 94, 10, 105, 102),
(95, 95, 9, 102, 104),
(96, 96, 8, 105, 102),
(97, 97, 7, 104, 101),
(98, 98, 6, 105, 103),
(99, 99, 5, 105, 102),
(100, 100, 4, 102, 105),
(101, 101, 3, 105, 103),
(102, 102, 2, 105, 104),
(103, 103, 1, 104, 105),
(104, 104, 2, 105, 104),
(105, 105, 3, 105, 103),
(106, 106, 4, 102, 105),
(107, 107, 5, 105, 102),
(108, 108, 6, 104, 103),
(109, 109, 7, 105, 101),
(110, 110, 8, 104, 102),
(111, 111, 9, 103, 105),
(112, 112, 10, 105, 102),
(113, 113, 11, 102, 105),
(114, 114, 12, 103, 105),
(115, 115, 11, 102, 105),
(116, 116, 10, 105, 102),
(117, 117, 9, 103, 105),
(118, 118, 8, 104, 102),
(119, 119, 7, 104, 101),
(120, 120, 6, 104, 103),
(121, 121, 7, 105, 101),
(122, 122, 8, 104, 102),
(123, 123, 12, 103, 105),
(124, 124, 5, 105, 102),
(125, 125, 12, 104, 101),
(126, 126, 8, 104, 105),
(127, 127, 6, 104, 103),
(128, 128, 3, 104, 102),
(129, 129, 12, 105, 101),
(130, 130, 2, 105, 104),
(131, 131, 11, 102, 105),
(132, 132, 3, 105, 103),
(133, 133, 10, 105, 101),
(134, 134, 8, 104, 102),
(135, 135, 12, 105, 101),
(136, 136, 12, 104, 101),
(137, 137, 10, 102, 101),
(138, 138, 7, 105, 101),
(139, 139, 9, 102, 104),
(140, 140, 1, 101, 105),
(141, 141, 9, 105, 104),
(142, 142, 6, 101, 104),
(143, 143, 3, 105, 102),
(144, 144, 9, 103, 105),
(145, 145, 1, 101, 104),
(146, 146, 4, 103, 102),
(147, 147, 7, 104, 101),
(148, 148, 6, 101, 102),
(149, 149, 5, 105, 102),
(150, 150, 4, 102, 105),
(151, 151, 7, 105, 101),
(152, 152, 5, 105, 102),
(153, 153, 12, 103, 101),
(154, 154, 12, 102, 101),
(155, 155, 1, 101, 105),
(156, 156, 4, 102, 105),
(157, 157, 12, 105, 104),
(158, 158, 9, 105, 104),
(159, 159, 2, 102, 104),
(160, 160, 6, 101, 103),
(161, 75, 7, 105, 101),
(162, 76, 8, 104, 102),
(163, 77, 12, 103, 101),
(164, 78, 5, 105, 102),
(165, 79, 1, 101, 105),
(166, 80, 10, 102, 103),
(167, 81, 7, 105, 101),
(168, 82, 8, 104, 102),
(169, 83, 9, 103, 105),
(170, 84, 10, 105, 103),
(171, 85, 11, 102, 105),
(172, 86, 12, 103, 101),
(173, 87, 1, 104, 105),
(174, 88, 2, 102, 104),
(175, 89, 3, 104, 102),
(176, 90, 4, 102, 105),
(177, 91, 5, 105, 102),
(178, 92, 6, 105, 103),
(179, 93, 5, 105, 102),
(180, 94, 4, 102, 105),
(181, 95, 3, 104, 102),
(182, 96, 2, 102, 105),
(183, 97, 1, 101, 104),
(184, 98, 12, 103, 105),
(185, 99, 11, 102, 105),
(186, 100, 10, 105, 102),
(187, 101, 9, 103, 105),
(188, 102, 8, 104, 105),
(189, 103, 7, 105, 104),
(190, 104, 8, 104, 105),
(191, 105, 9, 103, 105),
(192, 106, 10, 105, 102),
(193, 107, 11, 102, 105),
(194, 108, 12, 103, 104),
(195, 109, 1, 101, 105),
(196, 110, 2, 102, 104),
(197, 111, 3, 105, 103),
(198, 112, 4, 102, 105),
(199, 113, 5, 105, 102),
(200, 114, 6, 105, 103),
(201, 115, 5, 105, 102),
(202, 116, 4, 102, 105),
(203, 117, 3, 105, 103),
(204, 118, 2, 102, 104),
(205, 119, 1, 101, 104),
(206, 120, 12, 103, 104),
(207, 121, 1, 101, 105),
(208, 122, 2, 102, 104);
