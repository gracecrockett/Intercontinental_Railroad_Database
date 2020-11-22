/* Brysen Allen, Joe Davidson, Grace Crockett, David Pesin
   DB-Project
*/
CREATE TABLE IF NOT EXISTS PASSENGER(
	PASS_ID       Numeric(7,0),
	PASS_FNAME     VARCHAR(20) NOT NULL,
	PASS_LNAME    VARCHAR(20) NOT NULL,
	PASS_STREET   VARCHAR(20) NOT NULL,
	PASS_CITY     VARCHAR(20) NOT NULL,
	PASS_STATE    VARCHAR(20) NOT NULL,
	PASS_ZIP      NUMERIC(10,0) NOT NULL,
	PASS_COUNTRY  VARCHAR(20) NOT NULL,
	PRIMARY KEY(PASS_ID)
);

CREATE TABLE IF NOT EXISTS INVOICE(
	INV_ID		NUMERIC(7,0),
	PRICE		NUMERIC(5,2) NOT NULL,
	CONF_CODE	VARCHAR(20) NOT NULL,
	PASS_ID   	NUMERIC(7,0),
	PRIMARY KEY(INV_ID));
	/*FOREIGN KEY(PASS_ID) REFERNCES PASSENGER(PASS_ID)*/
  
CREATE TABLE IF NOT EXISTS TRAIN(
	TRAIN_NUM 	NUMERIC(2,0) NOT NULL,
	CONDUCTOR_ID	NUMERIC(7,0) NOT NULL,
	NUM_SEATS	NUMERIC(7,0) NOT NULL,
	PRIMARY KEY(TRAIN_NUM)
);

CREATE TABLE IF NOT EXISTS STATION(
	STAT_NUM      NUMERIC(3,0) NOT NULL,
	STAT_STREET   VARCHAR(20) NOT NULL,
	STAT_CITY     VARCHAR(20) NOT NULL,
	STAT_STATE    VARCHAR(20) NOT NULL,
	STAT_ZIP      INT(10) UNSIGNED NOT NULL,
	STAT_COUNTRY  VARCHAR(20) NOT NULL,
	PRIMARY KEY(STAT_NUM)
);

CREATE TABLE IF NOT EXISTS ROUTE(
	ROUTE_NUM   	NUMERIC(3,0) NOT NULL,
	ORIGIN		NUMERIC(3,0),
	DESTINATION	NUMERIC(3,0),
	PRIMARY KEY(ROUTE_NUM));
	/*FOREIGN KEY(ORIGIN) REFERENCES STATION(STAT_NUM),
	FOREIGN KEY(DESTINATION) REFERENCES STATION(STAT_NUM)*/

  
CREATE TABLE IF NOT EXISTS ROUTE_ASSGN(
	R_ASSGN		NUMERIC(7,0) NOT NULL,
	ROUTE_NUM 	NUMERIC(3,0),
	TRUE_DEPT	DATETIME,
	TRUE_ARR	DATETIME,
	EST_DEPT	DATETIME NOT NULL,
	EST_ARRIVAL	DATETIME NOT NULL,
	PRIMARY KEY(R_ASSGN));
	/*FOREIGN KEY(ROUTE_NUM) REFERENCES ROUTE(ROUT_NUM)*/

CREATE TABLE IF NOT EXISTS STOPS(
	ROUTE_NUM 	NUMERIC(3,0),
	STOP_NUM	NUMERIC(3,0) NOT NULL,
	STAT_NUM	NUMERIC(3,0),
	PRIMARY KEY(ROUTE_NUM,STOP_NUM));
  	/*FOREIGN KEY(ROUTE_NUM) REFERENCES ROUTE(ROUTE_NUM),
  	FOREIGN KEY(STAT_NUM) REFERENCES STATION(STAT_NUM)*/

CREATE TABLE IF NOT EXISTS TICKET(
 	TICKET_ID     	NUMERIC(7,0) NOT NULL,
	INV_ID		NUMERIC(7,0) ,
	R_ASSGN		NUMERIC(7,0) ,
	SEAT_NUM      	VARCHAR(6) NOT NULL,
	ORIGIN		NUMERIC(3,0),
	DESTINATION	NUMERIC(3,0),	
	PRIMARY KEY(TICKET_ID));
	/*FOREIGN KEY(INV_ID) REFERENCES INVOICE(INV_ID),
	FOREIGN KEY(R_ASSGN) REFERENCES ROUTE_ASSGN(R_ASSGN)*/


CREATE TABLE IF NOT EXISTS JOB(
	JOB_CODE 	NUMERIC(2,0) NOT NULL,
	JOB_DESC	VARCHAR(20) NOT NULL,
	JOB_TITLE	VARCHAR(150) NOT NULL,
	PRIMARY KEY(JOB_CODE)
);
  
CREATE TABLE IF NOT EXISTS EMPLOYEE(
	EMP_ID 		NUMERIC(4,0) NOT NULL PRIMARY KEY,
	EMP_FNAME	VARCHAR(20) NOT NULL,
	EMP_LNAME	VARCHAR(20) NOT NULL,
	EMP_HIREDATE	DATE NOT NULL,
	JOB_CODE	NUMERIC(2,0),
	REPORTS_TO	NUMERIC(4,0));
	#FOREIGN KEY(JOB_CODE) REFERENCES JOB(JOB_CODE)
	#FOREIGN KEY(REPORTS_TO) REFERENCES EMPLOYEE(EMP_ID)


CREATE TABLE IF NOT EXISTS MECHANIC(
	EMP_ID		NUMERIC(4,0),
	CERT_DATE	VARCHAR(20) NOT NULL,
	CERT_EXP	VARCHAR(20) NOT NULL,
	PRIMARY KEY(EMP_ID));
	/*FOREIGN KEY(EMP_ID) REFERENCES EMPLOYE(EMP_ID)*/


CREATE TABLE IF NOT EXISTS CONDUCTOR(
	EMP_ID		NUMERIC(4,0),
	CERT_DATE	DATE NOT NULL,
	CERT_EXP	DATE NOT NULL,
	PRIMARY KEY (EMP_ID));
	/*FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE(EMP_ID)*/

 

CREATE TABLE IF NOT EXISTS STATION_ASSGN(
	STAT_ASSGN	NUMERIC(7,0) NOT NULL,
	EMP_ID		NUMERIC(4,0) ,
 	STAT_NUM	NUMERIC(3,0) ,
	START_DATE	DATE NOT NULL,
	END_DATE	DATE);
	/*FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE(EMP_ID),
	FOREIGN KEY(STAT_NUM) REFERENCES STATION(STAT_NUM)*/
  

CREATE TABLE IF NOT EXISTS TRAIN_ASSGN(
	T_ASSGN 	NUMERIC(7,0) NOT NULL,
	EMP_ID		NUMERIC(4,0),
	TRAIN_NUM	NUMERIC(4,0),
	START_DATE	DATE NOT NULL,
	END_DATE	DATE ,
	PRIMARY KEY(T_ASSGN));
	/*FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE(EMP_ID)
	FOREIGN KEY(TRAIN_NUM) REFERENCES TRAIN(TRAIN_NUM)*/
  
  
CREATE TABLE IF NOT EXISTS ENGINE(
  	ENG_NUM		NUMERIC(7,0) NOT NULL,
	ENG_MODEL	VARCHAR(20) NOT NULL,
	ENG_DESC	VARCHAR(50) NOT NULL,
	PRIMARY KEY(ENG_NUM)
);
  
CREATE TABLE IF NOT EXISTS ENGINE_ASSGN(
	E_ASSGN 	NUMERIC(7,0),
	ENG_NUM		NUMERIC(7,0),
	TRAIN_NUM	NUMERIC(4,0),
	START_DATE	DATE NOT NULL,
	END_DATE	DATE ,
	PRIMARY KEY(E_ASSGN));
	/*FOREIGN KEY(ENG_NUM) REFERENCES ENGINE(ENG_NUM),
	FOREIGN KEY(TRAIN_NUM) REFERENCES TRAIN(TRAIN_NUM)*/

CREATE TABLE IF NOT EXISTS CAR(
  	CAR_NUM 	NUMERIC(7,0),
  	CAR_DESC	VARCHAR(20) NOT NULL,
  	CAR_CAPACITY	NUMERIC(7,0) NOT NULL,
  	PRIMARY KEY(CAR_NUM)
  );
  
CREATE TABLE IF NOT EXISTS CAR_ASSGN(
	C_ASSGN 	NUMERIC(7,0) NOT NULL,
	CAR_NUM		NUMERIC(7,0),
	TRAIN_NUM	NUMERIC(4,0),
	START_DATE 	DATE NOT NULL,
	END_DATE   	DATE ,
	PRIMARY KEY(C_ASSGN)
	);
	
  
 -- Populating jobs
INSERT INTO `JOB` (`JOB_CODE`, `JOB_TITLE`, `JOB_DESC`) 
	VALUES
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


INSERT INTO `CONDUCTOR` (`EMP_ID`, `CERT_DATE`, `CERT_EXP`) VALUES
(2220, '2020-01-08', '2025-01-08'),
(2222, '2019-09-12', '2024-09-12'),
(0440, '2017-12-15', '2022-12-15'),
(0444, '2018-07-04', '2023-07-04');

INSERT INTO ‘CAR’ (‘CAR_NUM’, ‘CAR_DESC’, ‘CAR_CAPACITY’) VALUES
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
INSERT INTO `PASSENGER` (`PASS_ID`, `PASS_NAME`, `PASS_LNAME`, `PASS_STREET`, `PASS_CITY`, `PASS_STATE`, `PASS_ZIP`, `PASS_COUNTRY`) VALUES
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
(100, 'Elora', 'Godilington', '1780 Tony Center', 'Masuda', null, 68790, 'Japan')
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

insert into 'STATION' ('STAT_NUM', 'STAT_STREET', 'STAT_CITY', 'STAT_STATE', 'STAT_ZIP', 'STAT_COUNTRY') values 
(101, '148 Crest Line Plaza', 'New York City', 'New York', 74091, 'United States'),
(102, '0765 Hagan Center', 'München', 'Bayern', 16928, 'Germany'),
(103, '52 Dottie Trail', 'Tokyo', null, 60131, 'Japan'),
(104, '455 Fieldstone Crossing', 'London', 'England', 78256, 'United Kingdom'),
(105, '21657 Dakota Center', 'Paris', 'Île-de-France', 42182, 'France');

INSERT INTO ‘ENGINE’ (‘ENG_NUM’, ‘ENG_MODEL’, ‘ENG_DESC’) VALUES
(101, AC6000CW, '6000 hp'),
(102, AC4460CW, '6000 hp'),
(103, CW46AH, '4600 hp'),
(104, AC6000CW, '6000 hp'),
(105, CW60AC, '5100 hp'),
(106, AC4460CW, '6000 hp, chassis is corroded, needs repairs'),
(107, CW60AC, '5100 hp, cylinders keep misfiring, needs repairs');

INSERT INTO `INVOICE` (`INV_ID`, `PRICE`, `CONF_CODE`, `PASS_ID`) VALUES
(1, 2859.74, '264KUT', 1),
(2, 1411.6, '374SHR', 2),
(3, 2947.63, '923PRK', 3),
(4, 2960.95, '124VKI', 4),
(5, 879.43, '183GED', 5),
(6, 2687.84, '413PHL', 6),
(7, 1800.47, '803LAQ', 7),
(8, 1462.54, '607HYJ', 8),
(9, 1410.38, '880CIR', 9),
(10, 1181.25, '377MHU', 10),
(11, 1563.68, '544UEG', 11),
(12, 1091.4, '253TJE', 12),
(13, 2342.57, '937BMR', 13),
(14, 1318.2, '107BVZ', 14),
(15, 1655.55, '423GYV', 15),
(16, 1672.23, '174KTJ', 16),
(17, 1077.77, '128VYN', 17),
(18, 1447.72, '506WEQ', 18),
(19, 1795.25, '677DPB', 19),
(20, 1003.64, '909ELZ', 20),
(21, 2645.73, '483BBO', 21),
(22, 2953.79, '605HSU', 22),
(23, 1117.61, '435OVT', 23),
(24, 1795.9, '321TTL', 24),
(25, 1399.02, '459KML', 25),
(26, 866.19, '230UAK', 26),
(27, 1008.3, '391MDE', 27),
(28, 2429.74, '830PWX', 28),
(29, 1321.11, '933YTW', 29),
(30, 1018.07, '438RTY', 30),
(31, 2487.59, '139XUV', 31),
(32, 2970.41, '097OCB', 32),
(33, 1319.3, '050IKF', 33),
(34, 2073.54, '366GSC', 34),
(35, 951.06, '263VRU', 35),
(36, 1230.79, '362RKK', 36),
(37, 2453.41, '854CQR', 37),
(38, 2337.11, '241XIA', 38),
(39, 1401.64, '201YRG', 39),
(40, 2223.06, '749MXC', 40),
(41, 1113.43, '670EKA', 41),
(42, 2545.92, '513LKA', 42),
(43, 2551.93, '818JWZ', 43),
(44, 2345.75, '975FRT', 44),
(45, 1577.48, '014IRR', 45),
(46, 1865.83, '875IKF', 46),
(47, 2968.85, '654GPH', 47),
(48, 1600.63, '491JMT', 48),
(49, 2255.14, '977XOQ', 49),
(50, 856.91, '870TDH', 50),
(51, 1557.11, '616CPN', 51),
(52, 2582.66, '988BNU', 52),
(53, 2923.84, '088FSE', 53),
(54, 2954.09, '158MKR', 54),
(55, 1757.58, '499UMJ', 55),
(56, 2992.83, '034ZJB', 56),
(57, 1713.95, '655UOF', 57),
(58, 1452.62, '576OTV', 58),
(59, 1099.31, '200YHE', 59),
(60, 1529.18, '082LWV', 60),
(61, 1805.16, '269SXK', 61),
(62, 2289.19, '839PLQ', 62),
(63, 1902.78, '462QHY', 63),
(64, 1394.26, '727HZF', 64),
(65, 1245.92, '478SYJ', 65),
(66, 1277.34, '750ZNK', 66),
(67, 2744.58, '616HXC', 67),
(68, 928.86, '408AJN', 68),
(69, 2619.4, '496OHR', 69),
(70, 2473.84, '533GFH', 70),
(71, 2941.59, '340BLM', 71),
(72, 1397.88, '660REW', 72),
(73, 2552.08, '169UIU', 73),
(74, 2049.77, '783DJL', 74),
(75, 2635.19, '229KVD', 75),
(76, 1576.59, '063USO', 76),
(77, 1400.08, '156FKL', 77),
(78, 1947.11, '296MWV', 78),
(79, 1269.4, '797CTM', 79),
(80, 1091.31, '441HGP', 80),
(81, 1785.85, '757TQJ', 81),
(82, 2607.82, '943GXX', 82),
(83, 1468.67, '978JCB', 83),
(84, 1771.03, '475QYK', 84),
(85, 2084.57, '213LSK', 85),
(86, 2569.76, '238LRN', 86),
(87, 2108.0, '173GHN', 87),
(88, 2451.96, '266OCB', 88),
(89, 826.84, '653MUA', 89),
(90, 2027.8, '810PNK', 90),
(91, 1761.62, '986CYA', 91),
(92, 2381.89, '041RBP', 92),
(93, 2635.93, '311GJY', 93),
(94, 1652.63, '989BST', 94),
(95, 2151.57, '942OCZ', 95),
(96, 2489.81, '561USR', 96),
(97, 2137.97, '900BOJ', 97),
(98, 1557.69, '503XPM', 98),
(99, 2613.93, '395SKV', 99),
(100, 2931.14, '024EGB', 100),
(101, 2657.42, '982HOG', 101),
(102, 1913.86, '883TXF', 102),
(103, 2847.43, '577RTZ', 103),
(104, 2488.27, '916URE', 104),
(105, 1489.94, '738YDI', 105),
(106, 1161.8, '477TKS', 106),
(107, 1746.77, '082FAF', 107),
(108, 2212.38, '789RRD', 108),
(109, 1779.69, '723BJQ', 109),
(110, 2813.97, '915OKG', 110),
(111, 815.74, '120NPD', 111),
(112, 1009.18, '875HSB', 112),
(113, 1670.65, '514KYB', 113),
(114, 1069.63, '450LIZ', 114),
(115, 1116.13, '273ZRL', 115),
(116, 1031.28, '804IBC', 116),
(117, 2423.05, '687DMQ', 117),
(118, 1665.12, '713BFH', 118),
(119, 1385.09, '544RMA', 119),
(120, 1433.51, '373ZFJ', 120),
(121, 1767.74, '537YIS', 121),
(122, 2400.54, '974UFA', 122),
(123, 1767.05, '707IIH', 123),
(124, 1622.24, '810GUM', 124),
(125, 1755.43, '896OCT', 125),
(126, 2839.71, '680JQU', 126),
(127, 2710.42, '762KDV', 127),
(128, 1070.89, '898MIO', 128),
(129, 2206.03, '845XZO', 129),
(130, 1111.91, '589ZJE', 130),
(131, 1151.99, '325OEG', 84),
(132, 1136.92, '168CEI', 124),
(133, 2627.5, '744VXJ', 69),
(134, 1184.19, '819WCO', 112),
(135, 2936.35, '962XOU', 115),
(136, 1078.67, '239XIP', 98),
(137, 2423.74, '844RTQ', 23),
(138, 1473.4, '572IEM', 69),
(139, 2514.62, '467TRJ', 122),
(140, 1652.34, '192FDE', 5),
(141, 2030.24, '096KTD', 75),
(142, 1425.95, '793SBV', 114),
(143, 1758.38, '723FMM', 52),
(144, 1385.44, '778ESA', 81),
(145, 826.47, '312UIR', 90),
(146, 1133.01, '061WFA', 116),
(147, 2809.45, '133OGK', 6),
(148, 1448.74, '426JRV', 125),
(149, 2209.79, '247CNI', 125),
(150, 1656.64, '423UMZ', 54),
(151, 1668.9, '984CLT', 82),
(152, 928.28, '509ETB', 122),
(153, 848.07, '511SMZ', 113),
(154, 2028.46, '828ZPI', 13),
(155, 1523.35, '124KCX', 25),
(156, 2448.21, '910MPU', 87),
(157, 1203.38, '990HAF', 69),
(158, 1756.64, '360MBR', 91),
(159, 2368.92, '057SPG', 51),
(160, 2878.93, '946APF', 107);
		    
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

INSERT INTO 'ROUTE' ('ROUTE_NUM', 'ORIGIN', 'DESTINATION') VALUES
(001, 101, 105),
(002, 102, 104),
(003, 104, 103),
(004, 103, 105),
(005, 105, 102);
		  
INSERT INTO 'ROUTE_ASSGN' ('R_ASSGN', 'ROUTE_NUM', 'TRAIN_NUM', 'TRUE_DEPT', 'TRUE_ARR', 'EST_DEPT','EST_ARRIVAL') VALUES
(0000001, 001, 453, '2020-05-18 18:40:08', '2020-05-18 21:47:16', '2020-05-18 18:30:00', '2020-05-18 21:30:00'),
(0000002, 002, 145, '2020-05-18 10:20:00', '2020-05-18 15:30:16', '2020-05-18 10:30:00', '2020-05-18 15:10:00'),
(0000003, 003, 342, '2020-05-18 14:00:15', '2020-05-18 19:38:16', '2020-05-18 13:50:00', '2020-05-18 19:30:00'),
(0000004, 004, 361, '2020-05-18 18:40:08', '2020-05-18 21:47:16', '2020-05-18 18:30:00', '2020-05-18 21:30:00');



/* STOP,ROUTE_ASSGN,TICKET,STAT_ASSGN,TRAIN_ASSGN,CAR_ASSGN*/

		    
/*
CREATE TABLE IF NOT EXISTS `employees` (
  `employeeNumber` int(11) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `reportsTo` int(11) DEFAULT NULL,
  `jobTitle` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- population, im not gonna copy it

ALTER TABLE `employees`
  ADD PRIMARY KEY (`employeeNumber`),
  ADD KEY `reportsTo` (`reportsTo`),
  ADD KEY `officeCode` (`officeCode`);

ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`reportsTo`) REFERENCES `employees` (`employeeNumber`),
  ADD CONSTRAINT `employees_ibfk_2` FOREIGN KEY (`officeCode`) REFERENCES `offices` (`officeCode`);
		    
		    Example of how to make it work properly :D */
		    
