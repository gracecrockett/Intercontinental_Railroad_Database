/* Brysen Allen, Joe Davidson, Grace Crockett, David Pesin
   DB-Project
*/
CREATE TABLE PASSENGER(
	PASS_ID       Numeric(7,0),
	PASS_NAME     VARCHAR(20) NOT NULL,
	PASS_LNAME    VARCHAR(20) NOT NULL,
	PASS_STREET   VARCHAR(20) NOT NULL,
	PASS_CITY     VARCHAR(20) NOT NULL,
	PASS_STATE    VARCHAR(20) NOT NULL,
	PASS_ZIP      NUMERIC(10,0) NOT NULL,
	PASS_COUNTRY  VARCHAR(20) NOT NULL,
	PRIMARY KEY(PASS_ID)
);

CREATE TABLE INVOICE(
	INV_ID		NUMERIC(7,0),
	PRICE		NUMERIC(5,2) NOT NULL,
	CONF_CODE	VARCHAR(20) NOT NULL,
	PASS_ID   	NUMERIC(7,0),
	PRIMARY KEY(INV_ID));
	/*FOREIGN KEY(PASS_ID) REFERNCES PASSENGER(PASS_ID)*/
  
CREATE TABLE TRAIN(
	TRAIN_NUM 	NUMERIC(2,0) NOT NULL,
	CONDUCTOR_ID	NUMERIC(7,0) NOT NULL,
	NUM_SEATS	NUMERIC(7,0) NOT NULL,
	PRIMARY KEY(TRAIN_NUM)
);

CREATE TABLE STATION(
	STAT_NUM      NUMERIC(3,0) NOT NULL,
	STAT_STREET   VARCHAR(20) NOT NULL,
	STAT_CITY     VARCHAR(20) NOT NULL,
	STAT_STATE    VARCHAR(20) NOT NULL,
	STAT_ZIP      INT(10) UNSIGNED NOT NULL,
	STAT_COUNTRY  VARCHAR(20) NOT NULL,
	PRIMARY KEY(STAT_NUM)
);

CREATE TABLE ROUTE(
	ROUTE_NUM   	NUMERIC(3,0) NOT NULL,
	ORIGIN		NUMERIC(3,0),
	DESTINATION	NUMERIC(3,0),
	PRIMARY KEY(ROUTE_NUM));
	/*FOREIGN KEY(ORIGIN) REFERENCES STATION(STAT_NUM),
	FOREIGN KEY(DESTINATION) REFERENCES STATION(STAT_NUM)*/

  
CREATE TABLE ROUTE_ASSGN(
	R_ASSGN		NUMERIC(7,0) NOT NULL,
	ROUTE_NUM 	NUMERIC(3,0),
	TRUE_DEPT	DATE,
	TRUE_ARR	DATE,
	EST_DEPT	DATE NOT NULL,
	EST_ARRIVAL	DATE NOT NULL,
	PRIMARY KEY(R_ASSGN));
	/*FOREIGN KEY(ROUTE_NUM) REFERENCES ROUTE(ROUT_NUM)*/

CREATE TABLE STOPS(
	ROUTE_NUM 	NUMERIC(3,0),
	STOP_NUM	NUMERIC(3,0) NOT NULL,
	STAT_NUM	NUMERIC(3,0),
	PRIMARY KEY(ROUTE_NUM,STOP_NUM));
  	/*FOREIGN KEY(ROUTE_NUM) REFERENCES ROUTE(ROUTE_NUM),
  	FOREIGN KEY(STAT_NUM) REFERENCES STATION(STAT_NUM)*/

CREATE TABLE TICKET(
 	TICKET_ID     	NUMERIC(7,0) NOT NULL,
	INV_ID		NUMERIC(7,0) ,
	R_ASSGN		NUMERIC(7,0) ,
	SEAT_NUM      	VARCHAR(6) NOT NULL,
	PRIMARY KEY(TICKET_ID));
	/*FOREIGN KEY(INV_ID) REFERENCES INVOICE(INV_ID),
	FOREIGN KEY(R_ASSGN) REFERENCES ROUTE_ASSGN(R_ASSGN)*/


CREATE TABLE JOB(
	JOB_CODE 	NUMERIC(2,0) NOT NULL,
	JOB_DESC	VARCHAR(20) NOT NULL,
	JOB_TITLE	VARCHAR(20) NOT NULL,
	PRIMARY KEY(JOB_CODE)
);
  
CREATE TABLE EMPLOYEE(
	EMP_ID 		NUMERIC(4,0) NOT NULL PRIMARY KEY,
	EMP_FNAME	VARCHAR(20) NOT NULL,
	EMP_LNAME	VARCHAR(20) NOT NULL,
	EMP_HIREDATE	DATE NOT NULL,
	JOB_CODE	NUMERIC(2,0),
	REPORTS_T0	NUMERIC(7,0));
	/*FOREIGN KEY(JOB_CODE) REFERENCES JOB(JOB_CODE)
	FOREIGN KEY(REPORTS_TO) REFERENCES EMPLOYEE(EMP_ID)*/


CREATE TABLE MEHCANIC(
	EMP_ID		NUMERIC(4,0),
	CERT_DATE	VARCHAR(20) NOT NULL,
	CERT_EXP	VARCHAR(20) NOT NULL,
	PRIMARY KEY(EMP_ID));
	/*FOREIGN KEY(EMP_ID) REFERENCES EMPLOYE(EMP_ID)*/


CREATE TABLE CONDUCTOR(
	EMP_ID		NUMERIC(4,0),
	CERT_DATE	DATE NOT NULL,
	CERT_EXP	DATE NOT NULL,
	PRIMARY KEY (EMP_ID));
	/*FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE(EMP_ID)*/

 

CREATE TABLE STATION_ASSGN(
	STAT_ASSGN	NUMERIC(7,0) NOT NULL,
	EMP_ID		NUMERIC(4,0) ,
 	STAT_NUM	NUMERIC(3,0) ,
	START_DATE	DATE NOT NULL,
	END_DATE	DATE);
	/*FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE(EMP_ID),
	FOREIGN KEY(STAT_NUM) REFERENCES STATION(STAT_NUM)*/
  

CREATE TABLE TRAIN_ASSGN(
	T_ASSGN 	NUMERIC(7,0) NOT NULL,
	EMP_ID		NUMERIC(4,0),
	TRAIN_NUM	NUMERIC(4,0),
	START_DATE	DATE NOT NULL,
	END_DATE	DATE ,
	PRIMARY KEY(T_ASSGN));
	/*FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE(EMP_ID)
	FOREIGN KEY(TRAIN_NUM) REFERENCES TRAIN(TRAIN_NUM)*/
  
  
CREATE TABLE ENGINE(
  	ENG_NUM		NUMERIC(7,0) NOT NULL,
	ENG_MODEL	VARCHAR(20) NOT NULL,
	ENG_DESC	VARCHAR(50) NOT NULL,
	PRIMARY KEY(ENG_NUM)
);
  
CREATE TABLE ENGINE_ASSGN(
	E_ASSGN 	NUMERIC(7,0),
	ENG_NUM		NUMERIC(7,0),
	TRAIN_NUM	NUMERIC(4,0),
	START_DATE	DATE NOT NULL,
	END_DATE	DATE ,
	PRIMARY KEY(E_ASSGN));
	/*FOREIGN KEY(ENG_NUM) REFERENCES ENGINE(ENG_NUM),
	FOREIGN KEY(TRAIN_NUM) REFERENCES TRAIN(TRAIN_NUM)*/
CREATE TABLE CAR(
  	CAR_NUM 	NUMERIC(7,0),
  	CAR_DESC	VARCHAR(20) NOT NULL,
  	CAR_CAPACITY	NUMERIC(7,0) NOT NULL,
  	PRIMARY KEY(CAR_NUM)
  );
  
CREATE TABLE CAR_ASSGN(
	C_ASSGN 	NUMERIC(7,0) NOT NULL,
	CAR_NUM		NUMERIC(7,0),
	TRAIN_NUM	NUMERIC(4,0),
	START_DATE 	DATE NOT NULL,
	END_DATE   	DATE ,
	PRIMARY KEY(C_ASSGN)
	);
	
  
  
/*-- Populating EMPLOYEE
INSERT INTO `EMPLOYEE` (`EMP_ID`, `EMP_FNAME`, `EMP_LNAME`, `EMP_HIRE_DATE`, `JOB_CODE`, `REPORTS_TO`) VALUES
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
(2000, 'Teodoor', 'Pottle', '4/25/2007', 5, 0010), -- Station Manager 3
(2002, 'Piggy', 'Cawte', '12/14/2019', 11, 2000), -- Teller
(2020, 'Kanye', 'West', '6/4/2008', 4, 2000), -- Head Mechanic 3
(2022, 'Cloe', 'Muddiman', '9/1/2013', 9, 2020), -- Mechanics (3)
(2200, 'Camilla', 'Pitcher', '12/26/2009', 9, 2020),
(2202, 'Vail', 'Cawt', '12/4/2000', 9, 2020),
(2220, 'Bonnibelle', 'Bellam', '9/14/2020', 10, 0110), -- Conductors
(2222, 'Dwain', 'Siviter', '12/20/2017', 10, 0101),
(0003, 'Nanette', 'Guille', '11/20/2015', 5, 0010), -- Station Manager 4
(0030, 'Diandra', 'Newsome', '3/1/2005', 5, 0010), -- Station Manager 5
(0033, 'Eduardo', 'Waliszek', '6/5/2015', 4, 0003), -- Head Mechanics
(0300, 'Nyssa', 'Chucks', '8/12/2014', 4, 0030),
(0303, 'Che', 'Peyes', '5/5/2005', 11, 0003), -- Tellers
(0330, 'Dal', 'Boon', '6/16/2015', 11, 0030),
(0333, 'Abram', 'Simonian', '1/9/2006', 9, 0033), -- Mechanics
(3000, 'Wendall', 'Satterthwaite', '3/30/2017', 9, 0033),
(3003, 'Curtice', 'Reinisch', '4/20/2001', 9, 0300),
(3030, 'Blake', 'Le Count', '3/13/2020', 9, 0300),
(3033, 'Gaspard', 'Holbarrow', '7/5/2004', 6, 0010), -- Train Manager 3
(3300, 'Harlin', 'Cornelissen', '1/3/2002', 6, 0010), -- Train Manager 4
(3303, 'Susan', 'Lanphere', '4/19/2018', 3, 3033), -- Head Steward 3
(3330, 'Theodora', 'MacNair', '12/31/2000', 3, 3300), -- Head Steward 4
(3333, 'Grete', 'Mallabon', '8/13/2016', 7, 3303), -- Stewards
(0004, 'Maxwell', 'Heenan', '4/1/2015', 7, 3330),
(0040, 'Zsazsa', 'Easman', '9/13/2004', 7, 3303),
(0044, 'Zonnya', 'Symcoxe', '4/13/2011', 7, 3330),
(0400, 'Eleen', 'Tetther', '11/11/2011', 8, 3303), -- Cafe Attendants
(0404, 'Jack', 'Devonside', '2/2/2002', 8, 3330),
(0440, 'Joe', 'Biden', '4/4/2004', 10, 3033), -- Conductors
(0444, 'Donald', 'Trump', '8/8/2008', 10, 3300);
  
-- Populating JOB
INSERT INTO `JOB` (`JOB_CODE`, `JOB_TITLE`, `JOB_DESC`) VALUES(
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
(11, 'Teller', 'Sells tickets at the station.'));
  
-- Populating MECHANIC
INSERT INTO `MECHANIC` (`EMP_ID`, `CERT_DATE`, `CERT_EXP`) VALUES
(1001, '3/4/2019', '3/4/2024'),
(1010, '12/5/2015', '12/5/2020'),
(1011, '7/6/2016', '7/6/2021'),
(1100, '7/6/2016', '7/6/2021'),
(2022, '5/5/2017', '5/5/2022'),
(2200, '8/5/2020', '8/5/2025'),
(2202, '1/5/2018', '1/5/2023'),
(0333, '9/12/2016', '9/12/2021'),
(3000, '11/15/2020', '11/15/2025'),
(3003, '2/20/2018', '2/20/2023'),
(3030, '6/4/2019', '6/3/2024');

INSERT INTO `CONDUCTOR` (`EMP_ID`, `CERT_DATE`, `CERT_EXP`) VALUES
(2220, '1/8/2020', '1/8/2025'),
(2222, '9/12/2019', '9/12/2024'),
(0440, '12/15/2017', '12/15/2022'),
(0444, '7/4/2018', '7/4/2023');/*

INSERT INTO ‘CAR’ (‘CAR_NUM’, ‘CAR_DESC’, ‘CAR_CAPACITY’) VALUES
(101,WAUZL54B01N482168,25),
(102,1G6DM5EG3A0389360,25),
(103,3N1BC1CP8CK567250,25),
(104,4T1BK1EB9EU135251,25),
(105,KNADH4A38A6117024,25),
(106,WDDJK7DA0FF026345,25),
(107,1G6DH8E35E0524895,25),
(108,1N6AA0CH9DN457236,25),
(109,JM1GJ1U5XF1095466,25),
(110,1GKS1AKC0FR064566,25),
(111,1G6KD57Y76U506838,25),
(112,WBAYM9C56DD766894,25),
(113,WBAEV33433K541654,25),
(114,WDDEJ7EB5BA691597,3),
(115,5YMGY0C59AL719852,25),
(116,WA1WKBFP5AA221698,25),
(117,WBAYM9C51DD942198,25),
(118,2B3CM5CT1BH479663,6),
(119,2FMDK4GC2AB775914,25),
(120,WDCGG5GBXBF772210,25),
(121,1G4HD57218U692393,25),
(122,3D7LT2ET1AG955430,25),
(123,5XYKT3A1XCG599657,25),
(124,1G4PP5SK8F4185238,25),
(125,2V4RW3D16AR793327,25),
(126,1GYS3DEFXDR361543,25),
(127,1N6AA0CA1DN937466,25),
(128,1N4AB7AP3DN819893,19),
(129,2G4WS52J111516036,25),
(130,WAULFAFR2CA401813,25);
		    
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
(100, 'Elora', 'Godilington', '1780 Tony Center', 'Masuda', null, 68790, 'Japan');
