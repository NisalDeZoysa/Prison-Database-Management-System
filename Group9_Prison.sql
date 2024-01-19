CREATE DATABASE Prison;
USE Prison;


CREATE TABLE PRISONER (
	Prisoner_ID varchar(10) PRIMARY KEY NOT NULL,
    Prisoner_Name varchar(50) NOT NULL,
    Gender varchar(10) NOT NULL,
    Age varchar(5) NOT NULL,
	Punishment_StartDate varchar(20) NOT NULL,
    Punishment_EndDate varchar(20) NOT NULL
);

select * from PRISONER;

CREATE TABLE VISITOR (
	Visitor_ID varchar(10) PRIMARY KEY NOT NULL,
    Visitor_Name varchar(50) NOT NULL,
    Gender varchar(10) NOT NULL,
    Connectivity varchar(20)
);

CREATE TABLE VISITOR_MOBILENO (
	Visitor_ID varchar(10)  NOT NULL,
    Mobile_No varchar(10),
    PRIMARY KEY(Visitor_ID, Mobile_No)
);

# Creation of visitor_visit_Prison   -- TABLE NAME "VISI T I OR" 
CREATE TABLE VISITOR_VISITS_PRISONER (
	Prisoner_ID varchar(10) NOT NULL,
    Visitor_ID varchar(10) NOT NULL,
    Session_Date varchar(20) NOT NULL,
    Session_Start_Time varchar(10) ,
    Session_Duration varchar(10) NOT NULL,
    primary key (Prisoner_ID , Visitor_ID, Session_Date, Session_Start_Time)
);


CREATE TABLE PARCELL (
	Parcell_ID varchar(10) PRIMARY KEY NOT NULL,
    Parcell_Name varchar(30) NOT NULL,
    Parcell_Type varchar(20),
    Weight varchar(20),
    Arrived_Time varchar(20) NOT NULL,
    Arrived_Date varchar(20) NOT NULL
);


CREATE TABLE VISITOR_BELONGINGS (
	Belonging_Name varchar(20) NOT NULL,
    weight varchar(20),
    Arr_Date varchar(20),
	Arr_Time varchar(20),
    Visitor_ID varchar(10)
);



CREATE TABLE CELL (
	Cell_ID varchar(10) PRIMARY KEY NOT NULL,
	Capacity varchar(5),
    Bed_Count varchar(5)	
);


CREATE TABLE WING (
	Wing_ID varchar(10) PRIMARY KEY NOT NULL,
    Wing_Name varchar(20) NOT NULL,
    Cell_Capacity varchar(10)
);


CREATE TABLE OFFICER (
	Officer_ID varchar(10) PRIMARY KEY NOT NULL,
    Officer_Type varchar(20) NOT NULL,
    Officer_Level varchar(20) NOT NULL,
    Officer_FName varchar(50) NOT NULL,
    Officer_LName varchar(50) NOT NULL,
    Age varchar(10),
    Gender varchar(10) 	NOT NULL,
    Experience varchar(20)
);


CREATE TABLE OFFICER_MOBILE_NUMBERS(
	Officer_ID varchar(10) NOT NULL,
	Mobile_No varchar(11) NOT NULL,
    primary key(Officer_ID,Mobile_No)
);


CREATE TABLE CaseOnGoing (
	Case_ID varchar(10) PRIMARY KEY NOT NULL,
    Case_Name varchar(50) NOT NULL,
    Police_Area varchar(20),
    Case_Type varchar(20)
);


#creating Prisoner_Involves_Case
CREATE TABLE PRISONER_INVOLVE_CASE (
	Prisoner_ID varchar(10) NOT NULL,
    Case_ID varchar(10) NOT NULL,
    PRIMARY KEY (Prisoner_ID, Case_ID)
);


CREATE TABLE VICTIM (
	Victim_Name varchar(50) NOT NULL, 
    Victim_Gender varchar(10) ,
    Victim_Age varchar(10),
    Case_ID varchar(10) NOT NULL,
    PRIMARY KEY( Case_ID , Victim_Name)
);


CREATE TABLE COURT (
	Court_ID varchar(10) PRIMARY KEY NOT NULL,
    Court_Name varchar(20) NOT NULL,
    District varchar(10) NOT NULL
);


CREATE TABLE COURT_ADDRESS(
	Court_ID varchar(10) NOT NULL,
    Address_Line varchar(50) NOT NULL,
    PRIMARY KEY(Court_ID, Address_Line)
);


CREATE TABLE LAWYER(
	Lawyer_ID varchar(10) PRIMARY KEY NOT NULL,
	Lawyer_Name varchar(50) NOT NULL,
    Lawyer_Level varchar(20) 
);	


CREATE TABLE LAWYER_MOBILENO (
	Lawyer_ID varchar(10) NOT NULL,
    Mobile_No varchar(10) NOT NULL,
    PRIMARY KEY ( Lawyer_ID, Mobile_No)
);

#Drop table LAWTER_MOBILENO;

#Creation of Case_Incontrol_Lawyer
CREATE TABLE CASE_INCONTROL_LAWYER (
	Lawyer_ID varchar(10) NOT NULL,
    Case_ID varchar(10) NOT NULL,
    PRIMARY KEY( lawyer_ID, Case_ID)
);


CREATE TABLE MEDICAL_RECORD (
	Record_ID varchar(10) PRIMARY KEY NOT NULL,
    Medical_Condition varchar(60) NOT NULL,
    Recorded_Date varchar(20),
    Recorded_Time varchar(20)
);


CREATE TABLE MEDICAL_RECORD_MEDICATIONS (
	Record_ID varchar(10) NOT NULL,
    Medication varchar(50) NOT NULL
);


-- --------------------------### FK adding


ALTER TABLE PRISONER ADD COLUMN Cell_ID varchar(10);

ALTER TABLE PRISONER ADD CONSTRAINT FK_PRISONER_CELL
FOREIGN KEY(Cell_ID) REFERENCES CELL(Cell_ID)
ON UPDATE CASCADE ON DELETE SET NULL;


-- USE Prison;


ALTER TABLE VISITOR ADD COLUMN Parcell_ID varchar(10);

ALTER TABLE VISITOR ADD CONSTRAINT FK_VISITOR_PARCELL
FOREIGN KEY (Parcell_ID) REFERENCES PARCELL(Parcell_ID)
ON UPDATE CASCADE ON DELETE SET NULL;


ALTER TABLE PARCELL ADD COLUMN Prisoner_ID varchar(10);

ALTER TABLE PARCELL ADD CONSTRAINT FK_PRISONER_PARCELL
FOREIGN KEY (Prisoner_ID) REFERENCES PRISONER(Prisoner_ID)
ON UPDATE CASCADE ON DELETE SET NULL;

#----------------special-------------meka demma att widiyata

-- ALTER TABLE VISITOR_BELONGINGS
-- ADD Visitor_ID varchar(10) NOT NULL;

-- Add the composite primary key constraint
ALTER TABLE VISITOR_BELONGINGS
ADD CONSTRAINT PK_VISITOR_BELONGINGS
PRIMARY KEY (Visitor_ID, Belonging_Name);

-- Add the foreign key constraint to VB table reference the VISITOR table
ALTER TABLE VISITOR_BELONGINGS
ADD CONSTRAINT FK_VISITOR_BELONGINGS_VISITOR
FOREIGN KEY (Visitor_ID)
REFERENCES VISITOR (Visitor_ID);

-- ---------------------------------

ALTER TABLE CELL ADD COLUMN Wing_ID varchar(10);

ALTER TABLE CELL ADD CONSTRAINT FK_CELL_WING
FOREIGN KEY (Wing_ID) REFERENCES WING(Wing_ID)
ON UPDATE CASCADE ON DELETE SET NULL;


ALTER TABLE OFFICER ADD COLUMN Wing_ID varchar(10);

ALTER TABLE OFFICER ADD CONSTRAINT FK_OFFICER_WING
FOREIGN KEY (Wing_ID) REFERENCES WING(Wing_ID)
ON UPDATE CASCADE ON DELETE SET NULL;

-- that supervisor thing need to update


ALTER TABLE MEDICAL_RECORD ADD COLUMN Prisoner_ID varchar(10);

ALTER TABLE MEDICAL_RECORD ADD CONSTRAINT FK_MEDREC_PRISONER
FOREIGN KEY (Prisoner_ID) REFERENCES PRISONER(Prisoner_ID)
ON UPDATE CASCADE ON DELETE SET NULL;



ALTER TABLE CaseOnGoing ADD COLUMN Court_ID varchar(10);

ALTER TABLE CaseOnGoing ADD CONSTRAINT FK_CASE_COURT
FOREIGN KEY (Court_ID) REFERENCES COURT(Court_ID)
ON UPDATE CASCADE ON DELETE SET NULL;

-- supervisor thing

ALTER TABLE OFFICER ADD COLUMN Supervisor varchar(10);   -- varchar 10 kara. 5 thibbe

ALTER TABLE OFFICER ADD CONSTRAINT FOREIGN KEY (Supervisor) REFERENCES OFFICER(Officer_ID)
ON UPDATE CASCADE ON DELETE CASCADE;

-- MV visitor mobile no table add fk visitor_ID
ALTER TABLE VISITOR_MOBILENO ADD CONSTRAINT FK_VISITOR_ID
FOREIGN KEY (Visitor_ID) REFERENCES VISITOR(Visitor_ID)
ON UPDATE CASCADE ON DELETE CASCADE;

-- vsi visits pri FK's
ALTER TABLE VISITOR_VISITS_PRISONER ADD CONSTRAINT FK_PRISONER_ID
FOREIGN KEY (Prisoner_ID) REFERENCES PRISONER(Prisoner_ID)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE VISITOR_VISITS_PRISONER ADD CONSTRAINT FK_VISID_VISI_VISIT_PRI
FOREIGN KEY (Visitor_ID) REFERENCES VISITOR(Visitor_ID)
ON UPDATE CASCADE ON DELETE CASCADE;


-- OFFICER_MOBILE_NUMBERS
ALTER TABLE OFFICER_MOBILE_NUMBERS ADD CONSTRAINT FK_OFFICER_MOBILE
FOREIGN KEY (Officer_ID) REFERENCES OFFICER(Officer_ID)
ON UPDATE CASCADE ON DELETE CASCADE;


-- PRISONER_INVOLVE_CASE
ALTER TABLE PRISONER_INVOLVE_CASE ADD CONSTRAINT FK_PRI_INVO_CASE_PRI_ID
FOREIGN KEY (Prisoner_ID) REFERENCES PRISONER(Prisoner_ID)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE PRISONER_INVOLVE_CASE ADD CONSTRAINT FK_PRI_INVO_CASE_CASE_ID
FOREIGN KEY (Case_ID) REFERENCES CaseOnGoing(Case_ID)
ON UPDATE CASCADE ON DELETE CASCADE;


-- COURT_ADDRESS
ALTER TABLE COURT_ADDRESS ADD CONSTRAINT FK_COURT_ADDRESS_COURT_ID
FOREIGN KEY (Court_ID) REFERENCES COURT(Court_ID)
ON UPDATE CASCADE ON DELETE CASCADE;


-- LAWYER_MOBILENO
ALTER TABLE LAWYER_MOBILENO ADD CONSTRAINT FK_LAWYERMOBILE_LAWID
FOREIGN KEY (Lawyer_ID) REFERENCES LAWYER(Lawyer_ID)
ON UPDATE CASCADE ON DELETE CASCADE;


-- CASE_INCONTROL_LAWYER
ALTER TABLE CASE_INCONTROL_LAWYER ADD CONSTRAINT FK_CASE_INCONTROL_LAWYER_CASE_ID
FOREIGN KEY (Case_ID) REFERENCES CaseOnGoing(Case_ID)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE CASE_INCONTROL_LAWYER ADD CONSTRAINT FK_CASE_INCONTROL_LAWYER_LAWYER_ID
FOREIGN KEY (Lawyer_ID) REFERENCES LAWYER(Lawyer_ID)
ON UPDATE CASCADE ON DELETE CASCADE;


-- MEDICAL_RECORD_MEDICATIONS
ALTER TABLE MEDICAL_RECORD_MEDICATIONS ADD CONSTRAINT FK_MEDICAL_RECORD_MEDICATIONS_RECORD_ID
FOREIGN KEY (Record_ID) REFERENCES MEDICAL_RECORD(Record_ID)
ON UPDATE CASCADE ON DELETE CASCADE;


-- VICTIM TA CASEID eka FK kara(khmath pk krl thibbe)
ALTER TABLE VICTIM
ADD CONSTRAINT FK_VICTIM_CASE_ID
FOREIGN KEY (Case_ID)
REFERENCES CaseOnGoing (Case_ID);

-- -----------------------------------------------


-- ------INSERT DATA INTO TABLES
-- 8) WING
INSERT INTO WING (Wing_ID, Wing_Name, Cell_Capacity)
VALUES
    ('W001', 'East Wing', '10'),
    ('W002', 'West Wing', '12'),
    ('W003', 'North Wing', '8'),
    ('W004', 'South Wing', '15');

-- 7) CELL
INSERT INTO CELL (Cell_ID, Capacity, Bed_Count, Wing_ID)
VALUES
    ('C001', '4', '2', 'W001'),
    ('C002', '6', '3', 'W001'),
    ('C003', '5', '2', 'W002'),
    ('C004', '8', '4', 'W002');
    
    
-- 1)PRISONER
INSERT INTO PRISONER (Prisoner_ID, Prisoner_Name, Gender, Age, Punishment_StartDate, Punishment_EndDate, Cell_ID)
VALUES
    ('P001', 'Ranil Silva', 'Male', '30', '2023-01-15', '2024-01-14', 'C001'),
    ('P002', 'Kavitha Fernando', 'Female', '25', '2023-02-20', '2024-02-19', 'C002'),
    ('P003', 'Nimal Perera', 'Male', '40', '2023-03-10', '2024-03-09', 'C003'),
    ('P004', 'Samantha de Silva', 'Female', '22', '2023-04-05', '2024-04-04', 'C001'),
    ('P005', 'Ajith Bandara', 'Male', '35', '2023-05-12', '2024-05-11', 'C004');
    
    
-- 5) PARCELL   --prcell_Name    -- weight walata kg kiyalath wetila
INSERT INTO PARCELL (Parcell_ID, Parcell_Name, Parcell_Type, Weight, Arrived_Time, Arrived_Date, Prisoner_ID)
VALUES
    ('PAR001', 'Package 1', 'Box', '5 kg', '10:00 AM', '2023-01-15', 'P001'),
    ('PAR002', 'Package 2', 'Envelope', '0.5 kg', '11:30 AM', '2023-02-20', 'P002'),
    ('PAR003', 'Package 3', 'Box', '8 kg', '02:15 PM', '2023-03-10', 'P003'),
    ('PAR004', 'Package 4', 'Parcel', '12 kg', '03:45 PM', '2023-04-05', 'P004');
    
    
-- 2) Visitor
INSERT INTO VISITOR (Visitor_ID, Visitor_Name, Gender, Connectivity, Parcell_ID)
VALUES
    ('V001', 'Malini Perera', 'Female', 'Friend', 'PAR001'),
    ('V002', 'Ranjan Silva', 'Male', 'Family', 'PAR002'),
    ('V003', 'Chandani Fernando', 'Female', 'Friend', 'PAR003'),
    ('V004', 'Kamal Bandara', 'Male', 'Family', 'PAR004');
    
    
-- 3) VISITIOR_VISITS_PRISONER
INSERT INTO VISITOR_VISITS_PRISONER (Prisoner_ID, Visitor_ID, Session_Date, Session_Start_Time, Session_Duration)
VALUES
    ('P001', 'V001', '2023-01-15', '10:00 AM', '30'),
    ('P002', 'V002', '2023-02-20', '11:30 AM', '45'),
    ('P003', 'V003', '2023-03-10', '02:15 PM', '60'),
    ('P004', 'V004', '2023-04-05', '03:45 PM', '45');
    
    
-- 4) VISITOR_MOBILENO
INSERT INTO VISITOR_MOBILENO (Visitor_ID, Mobile_No)
VALUES
    ('V001', '1234567890'),
    ('V002', '9876543210'),
    ('V002', '5555555555'),
    ('V003', '9999999999'),
    ('V001', '7777777777');
    
    
-- 6) VISITOR BELONGINGS
INSERT INTO VISITOR_BELONGINGS (Belonging_Name, Weight, Arr_Date, Arr_Time, Visitor_ID)
VALUES
    ('Laptop', '2 kg', '2023-01-15', '10:00 AM', 'V001'),
    ('Backpack', '1 kg', '2023-02-20', '11:30 AM', 'V002'),
    ('Camera', '0.5 kg', '2023-03-10', '02:15 PM', 'V003'),
    ('Mobile Phone', '0.3 kg', '2023-04-05', '03:45 PM', 'V004');
    
    
    
 -- ALTER TABLE OFFICER MODIFY COLUMN Supervisor varchar(10);      // must needed
-- 9) OFFICER
INSERT INTO OFFICER (Officer_ID, Officer_Type, Officer_Level, Officer_FName, Officer_LName, Age, Gender, Experience, Wing_ID, Supervisor)
VALUES
    ('OFFICER01', 'Guard', 'Junior', 'John', 'Smith', '30', 'Male', '5 years', 'W001', NULL),
    ('OFFICER02', 'Jailer', 'Senior', 'Mary', 'Johnson', '40', 'Female', '10 years', 'W001', 'OFFICER01'),
    ('OFFICER03', 'Guard', 'Junior', 'David', 'Williams', '28', 'Male', '3 years', 'W002', NULL),
    ('OFFICER04', 'Doctor', 'Senior', 'Emily', 'Davis', '35', 'Female', '8 years', 'W002', 'OFFICER01');


-- 10) OFFICER_MOBILE_NUMBERS 
INSERT INTO OFFICER_MOBILE_NUMBERS (Officer_ID, Mobile_No)
VALUES
    ('OFFICER01', '12345678901'),
    ('OFFICER02', '98765432109');


-- 14) COURT   (please update length of court name)
INSERT INTO COURT (Court_ID, Court_Name, District)
VALUES
    ('CRT001', 'Court Galle', 'Galle'),
    ('CRT002', 'Court Matara', 'Matara'),
    ('CRT003', 'Court Kandy', 'Kandy');
    
    
-- 11) CaseOnGoing
INSERT INTO CaseOnGoing (Case_ID, Case_Name, Police_Area, Case_Type, Court_ID)
VALUES
    ('C001', 'Theft Case', 'City A', 'Property Theft', 'CRT001'),
    ('C002', 'Assault Case', 'City B', 'Assault and Battery', 'CRT002'),
    ('C003', 'Fraud Case', 'City C', 'Financial Fraud', 'CRT001');


-- 12) PRISONER_INVOLVE_CASE
INSERT INTO PRISONER_INVOLVE_CASE (Prisoner_ID, Case_ID)
VALUES
    ('P001', 'C001'),
    ('P002', 'C002'),
    ('P003', 'C003');


-- 13) VICTIM
INSERT INTO VICTIM (Victim_Name, Victim_Gender, Victim_Age, Case_ID)
VALUES
    ('Alice Smith', 'Female', '28', 'C001'),
    ('Bob Johnson', 'Male', '35', 'C002'),
    ('Charlie Davis', 'Male', '45', 'C003');
    

-- 15) COURT_ADDRESS
INSERT INTO COURT_ADDRESS (Court_ID, Address_Line)
VALUES
    ('CRT001', '123 Main Street,'),
    ('CRT001', '456 Elm Avenue, District A'),
    ('CRT002', '789 Oak Road,');
    
    
-- 16) LAWYER
INSERT INTO LAWYER (Lawyer_ID, Lawyer_Name, Lawyer_Level)
VALUES
    ('L001', 'Nisal Chandira', 'Senior Lawyer'),
    ('L002', 'Hiruna De Silva', 'Junior Lawyer'),
    ('L003', 'Kavindu Silva ','Senior Lawyer');
    
    
-- 17) LAWYER_MOBILENO
INSERT INTO LAWYER_MOBILENO (Lawyer_ID, Mobile_No)
VALUES
    ('L001', '0714360300'),
    ('L001', '0718210432'),
    ('L002', '0713409857');
    
    
-- 18) CASE_INCONTROL_LAWYER
INSERT INTO CASE_INCONTROL_LAWYER (Lawyer_ID, Case_ID)
VALUES
    ('L001', 'C001'),
    ('L002', 'C002'),
    ('L003', 'C003');
    
    
-- 19) MEDICAL_RECORD
INSERT INTO MEDICAL_RECORD (Record_ID, Medical_Condition, Recorded_Date, Recorded_Time, Prisoner_ID)
VALUES
    ('MR001', 'Fever', '2023-01-15', '10:00 AM', 'P001'),
    ('MR002', 'Injury', '2023-02-20', '11:30 AM', 'P002'),
    ('MR003', 'Flu', '2023-03-10', '02:15 PM', 'P003');
    

-- 20) MEDICAL_RECORD_MEDICATIONS
INSERT INTO MEDICAL_RECORD_MEDICATIONS (Record_ID, Medication)
VALUES
    ('MR001', 'Paracetamol'),
    ('MR001', 'Ibuprofen'),
    ('MR002', 'Amoxicillin');


UPDATE WING SET Wing_Name='West Wing' WHERE Wing_ID = '001';
DELETE FROM PRISONER WHERE Prisoner_ID = 'P005';
-- -----executed update -------------------------------------------------------------------


-- Prisoner wala duration attribute eka danawada nedda


-- ----------------------------------- chap 4


-- select
SELECT * FROM PRISONER;

SELECT * FROM PRISONER WHERE Gender = 'Male';


-- Project
SELECT Prisoner_ID,Prisoner_Name,Age
FROM PRISONER
WHERE Cell_ID = 'C001';

SELECT Parcell_ID, Parcell_Name, Parcell_type
FROM PARCELL
WHERE Arrived_Date < '2023-04-01';


-- Cartesian Product
SELECT * FROM VISITOR
CROSS JOIN PARCELL;

SELECT Visitor_ID, Visitor_Name, Parcell_Name 
FROM visitor,parcell;



CREATE OR REPLACE VIEW USER_MEDICAL_RECORDS AS
SELECT
    MR.Record_ID,
    MR.Medical_Condition,
    MR.Recorded_Date,
    MR.Recorded_Time,
    COALESCE(P.Prisoner_Name, 'N/A') AS Prisoner_Name,
    MM.Medication
FROM
    MEDICAL_RECORD AS MR
LEFT JOIN
    PRISONER AS P ON MR.Prisoner_ID = P.Prisoner_ID
LEFT JOIN
    MEDICAL_RECORD_MEDICATIONS AS MM ON MR.Record_ID = MM.Record_ID;

SELECT * FROM USER_MEDICAL_RECORDS;

-- user view 2
CREATE VIEW OFFICER_DEATAILS AS SELECT Officer_ID, Officer_FName, Age FROM OFFICER WHERE Gender='Male';
SELECT * FROM OFFICER_DEATAILS ;

-- LIKE Keyword
SELECT *
FROM USER_MEDICAL_RECORDS
WHERE Medical_Condition LIKE '%Fever%';


-- Renaming operation
RENAME TABLE OFFICER_MOBILE_NUMBERS TO OFFICER_MOBILE_NUMBER;
SHOW TABLES;


-- aggregate
SELECT
    P.Prisoner_ID,
    P.Prisoner_Name,
    COUNT(VVP.Visitor_ID) AS TotalVisitors
FROM
    PRISONER AS P
LEFT JOIN
    VISITOR_VISITS_PRISONER AS VVP ON P.Prisoner_ID = VVP.Prisoner_ID
GROUP BY
    P.Prisoner_ID, P.Prisoner_Name
ORDER BY
    TotalVisitors DESC;


-- chapter 5

-- UNION
(SELECT * FROM VISITOR AS V
WHERE V.Gender = 'Male')
UNION
(SELECT * FROM VISITOR AS V
WHERE V.Connectivity = 'Family');


-- Intersection       No results because in the data base particular admin is assigned for particular field in the company
SELECT P.Prisoner_ID, P.Prisoner_Name
FROM PRISONER AS P
INNER JOIN VISITOR AS V ON P.Prisoner_ID = V.Visitor_ID;

SELECT * FROM PRISONER
WHERE Gender IN (SELECT Gender FROM OFFICER);

-- SET DIFFERENCE
SELECT P.*
FROM PRISONER P
LEFT JOIN OFFICER O
ON P.Gender = O.Gender AND P.Age = O.Age
WHERE O.Gender IS NULL AND O.Age IS NULL;

-- Inner join
SELECT PRISONER.*, CELL.Cell_ID, CELL.Capacity
FROM PRISONER
INNER JOIN CELL
ON PRISONER.Cell_ID = CELL.Cell_ID;


-- Natural Join
SELECT OFFICER.Officer_ID, OFFICER.Officer_FName, OFFICER.Officer_LName, WING.Wing_Name, VISITOR.Visitor_Name
FROM OFFICER
NATURAL JOIN WING
NATURAL JOIN VISITOR;

-- NJ2
CREATE VIEW OFFICER_WING_VIEW AS
SELECT OFFICER.Officer_ID, OFFICER.Officer_FName, OFFICER.Officer_LName, WING.Wing_Name
FROM OFFICER
NATURAL JOIN WING;

CREATE VIEW OFFICER_VISITOR_VIEW AS
SELECT OFFICER.Officer_ID, OFFICER.Officer_FName, OFFICER.Officer_LName, VISITOR.Visitor_Name
FROM OFFICER
NATURAL JOIN VISITOR;

SELECT OFFICER_WING_VIEW.*, OFFICER_VISITOR_VIEW.Visitor_Name
FROM OFFICER_WING_VIEW
NATURAL JOIN OFFICER_VISITOR_VIEW;


-- LOJ
SELECT
    PRISONER.Prisoner_ID,
    PRISONER.Prisoner_Name,
    CELL.Cell_ID,
    CELL.Capacity,
    WING.Wing_Name,
    OFFICER.Officer_ID,
    OFFICER.Officer_FName,
    OFFICER.Officer_LName
FROM PRISONER
LEFT OUTER JOIN CELL ON PRISONER.Cell_ID = CELL.Cell_ID
LEFT OUTER JOIN WING ON CELL.Wing_ID = WING.Wing_ID
LEFT OUTER JOIN OFFICER ON CELL.Wing_ID = OFFICER.Wing_ID;


-- ROJ
SELECT
    PRISONER.Prisoner_ID,
    PRISONER.Prisoner_Name,
    VISITOR.Visitor_ID,
    VISITOR.Visitor_Name,
    VISITOR_VISITS_PRISONER.Session_Date
FROM
    PRISONER
RIGHT OUTER JOIN
    VISITOR_VISITS_PRISONER ON PRISONER.Prisoner_ID = VISITOR_VISITS_PRISONER.Prisoner_ID
LEFT OUTER JOIN
    VISITOR ON VISITOR_VISITS_PRISONER.Visitor_ID = VISITOR.Visitor_ID;


-- Full Outer JOIn

SELECT PARCELL.Parcell_ID,PARCELL.Parcell_Name,PARCELL.Parcell_Type,PARCELL.Weight AS Parcell_Weight,VISITOR.Visitor_ID,
        VISITOR.Visitor_Name,
			NULL AS Visitor_Belonging_Name, NULL AS Belonging_Weight,
			NULL AS Belonging_Arr_Date, NULL AS Belonging_Arr_Time
FROM PARCELL LEFT JOIN VISITOR ON PARCELL.Parcell_ID = VISITOR.Parcell_ID
UNION ALL
SELECT PARCELL.Parcell_ID,PARCELL.Parcell_Name,PARCELL.Parcell_Type,PARCELL.Weight AS Parcell_Weight,VISITOR.Visitor_ID,
		VISITOR.Visitor_Name,
    NULL AS Visitor_Belonging_Name, NULL AS Belonging_Weight, NULL AS Belonging_Arr_Date, NULL AS Belonging_Arr_Time
FROM VISITOR LEFT JOIN PARCELL ON PARCELL.Parcell_ID = VISITOR.Parcell_ID
UNION ALL
SELECT NULL AS Parcell_ID,NULL AS Parcell_Name,NULL AS Parcell_Type,NULL AS Parcell_Weight, VISITOR.Visitor_ID,VISITOR.Visitor_Name,
    VB.Belonging_Name AS Visitor_Belonging_Name, VB.weight AS Belonging_Weight, VB.Arr_Date AS Belonging_Arr_Date,
    VB.Arr_Time AS Belonging_Arr_Time
FROM VISITOR_BELONGINGS AS VB LEFT JOIN VISITOR ON VB.Visitor_ID = VISITOR.Visitor_ID
UNION ALL
SELECT NULL AS Parcell_ID, NULL AS Parcell_Name,NULL AS Parcell_Type, NULL AS Parcell_Weight,VISITOR.Visitor_ID, VISITOR.Visitor_Name,
    VB.Belonging_Name AS Visitor_Belonging_Name, VB.weight AS Belonging_Weight, VB.Arr_Date AS Belonging_Arr_Date,
    VB.Arr_Time AS Belonging_Arr_Time
FROM VISITOR
LEFT JOIN VISITOR_BELONGINGS AS VB ON VB.Visitor_ID = VISITOR.Visitor_ID;


-- Nested Queries
-- 1) names of all visitors who have visited prisoners
SELECT Visitor_Name FROM VISITOR
WHERE Visitor_ID IN (
    SELECT DISTINCT Visitor_ID
    FROM VISITOR_VISITS_PRISONER
);

-- 2) finds the names of prisoners who have been visited by female visitors:
SELECT Prisoner_Name FROM PRISONER
WHERE Prisoner_ID IN (
    SELECT Prisoner_ID
    FROM VISITOR_VISITS_PRISONER
    WHERE Visitor_ID IN (
        SELECT Visitor_ID
        FROM VISITOR
        WHERE Gender = 'Female'
    )
);

-- 3) calculates the average age of prisoners who are involved in a case
SELECT AVG(Age) AS Average_Prisoner_Age
FROM PRISONER
WHERE Prisoner_ID IN (
    SELECT DISTINCT Prisoner_ID
    FROM PRISONER_INVOLVE_CASE
    WHERE Case_ID IN (
        SELECT Case_ID
        FROM CaseOnGoing
    )
);


-- ----------------------------------------------------------------------------------------

-- tuning







-- ---------------------------------------------------------------------------------------------------------

-- 
EXPLAIN(SELECT *
FROM USER_MEDICAL_RECORDS
WHERE Medical_Condition LIKE '%Fever%');


-- after tunued
CREATE INDEX idx_med_condition_f ON MEDICAL_RECORD(Medical_Condition);


-- Now, run the tuned query
EXPLAIN(SELECT *
FROM MEDICAL_RECORD
WHERE Medical_Condition LIKE '%Fever%');


-- ------------------------------------------------------------------------------------------------------------------
-- USE prison;
/*
EXPLAIN(SELECT P.Prisoner_ID, P.Prisoner_Name,COUNT(VVP.Visitor_ID) AS TotalVisitors
FROM PRISONER AS P
LEFT JOIN VISITIOR_VISITS_PRISONER AS VVP ON P.Prisoner_ID = VVP.Prisoner_ID
GROUP BY P.Prisoner_ID, P.Prisoner_Name
ORDER BY TotalVisitors DESC);

CREATE INDEX idx_prisoner_id_a ON VISITIOR_VISITS_PRISONER(Prisoner_ID);

-- Now, run the tuned query
EXPLAIN(SELECT P.Prisoner_ID, P.Prisoner_Name, IFNULL(COUNT(VVP.Visitor_ID), 0) AS TotalVisitors
FROM PRISONER AS P
LEFT JOIN VISITIOR_VISITS_PRISONER AS VVP ON P.Prisoner_ID = VVP.Prisoner_ID
GROUP BY P.Prisoner_ID, P.Prisoner_Name
ORDER BY TotalVisitors DESC);
*/
-- --------------------------------------
/*
EXPLAIN(SELECT PRISONER.*, CELL.Cell_ID, CELL.Capacity
FROM PRISONER
INNER JOIN CELL
ON PRISONER.Cell_ID = CELL.Cell_ID);

EXPLAIN(SELECT p.Prisoner_Name , c.Cell_ID
from PRISONER p inner join CELL c
ON p.Cell_ID = c.Cell_ID where Capacity >'2');

CREATE INDEX idx_prisoner_cell_id_c ON CELL(Capacity);

EXPLAIN(SELECT p.Prisoner_Name , c.Cell_ID
from PRISONER p inner join CELL c
ON p.Cell_ID = c.Cell_ID );

DROP INDEX idx_prisoner_cell_id_c ON CELL;



CREATE INDEX idx_prisoner_cell_id_b ON PRISONER(Cell_ID);

explain(SELECT P.Prisoner_ID, P.Prisoner_Name, P.Gender, P.Age, P.Punishment_StartDate, P.Punishment_EndDate, C.Cell_ID, C.Capacity
FROM PRISONER AS P
INNER JOIN CELL AS C ON P.Cell_ID = C.Cell_ID);
*/
-- ----------------

/*
explain(SELECT
    PRISONER.Prisoner_ID,
    PRISONER.Prisoner_Name,
    VISITOR.Visitor_ID,
    VISITOR.Visitor_Name,
    VISITIOR_VISITS_PRISONER.Session_Date
FROM
    PRISONER
RIGHT OUTER JOIN
    VISITIOR_VISITS_PRISONER ON PRISONER.Prisoner_ID = VISITIOR_VISITS_PRISONER.Prisoner_ID
LEFT OUTER JOIN
    VISITOR ON VISITIOR_VISITS_PRISONER.Visitor_ID = VISITOR.Visitor_ID);


CREATE INDEX idx_prisoner_cell_id_c ON PRISONER(Prisoner_Name);


explain(SELECT
    PRISONER.Prisoner_ID,
    PRISONER.Prisoner_Name,
    VISITOR.Visitor_ID,
    VISITOR.Visitor_Name,
    VISITIOR_VISITS_PRISONER.Session_Date
FROM
    PRISONER
RIGHT OUTER JOIN
    VISITIOR_VISITS_PRISONER ON PRISONER.Prisoner_ID = VISITIOR_VISITS_PRISONER.Prisoner_ID
LEFT OUTER JOIN
    VISITOR ON VISITIOR_VISITS_PRISONER.Visitor_ID = VISITOR.Visitor_ID);

*/
-- ------------------------------------------------------------------------

explain(SELECT
    PRISONER.Prisoner_ID,
    PRISONER.Prisoner_Name,
    CELL.Cell_ID,
    CELL.Capacity,
    WING.Wing_Name,
    OFFICER.Officer_ID,
    OFFICER.Officer_FName,
    OFFICER.Officer_LName
FROM PRISONER
LEFT OUTER JOIN CELL ON PRISONER.Cell_ID = CELL.Cell_ID
LEFT OUTER JOIN WING ON CELL.Wing_ID = WING.Wing_ID
LEFT OUTER JOIN OFFICER ON CELL.Wing_ID = OFFICER.Wing_ID);
    
    
CREATE INDEX idx_prisoner_prisoner_id_d ON PRISONER(Prisoner_ID);
-- Index on CELL table
CREATE INDEX idx_cell_cell_id_d ON CELL(Cell_ID);
CREATE INDEX idx_cell_wing_id_d ON CELL(Wing_ID);
-- Index on WING table
CREATE INDEX idx_wing_wing_id_d ON WING(Wing_ID);

-- Index on OFFICER table
CREATE INDEX idx_officer_wing_id_d ON OFFICER(Wing_ID);

explain(SELECT PRISONER.Prisoner_ID, PRISONER.Prisoner_Name,CELL.Cell_ID, CELL.Capacity,WING.Wing_Name,OFFICER.Officer_ID,OFFICER.Officer_FName,
    OFFICER.Officer_LName
FROM PRISONER
LEFT OUTER JOIN CELL ON PRISONER.Cell_ID = CELL.Cell_ID
LEFT OUTER JOIN WING ON CELL.Wing_ID = WING.Wing_ID
LEFT OUTER JOIN OFFICER ON CELL.Wing_ID = OFFICER.Wing_ID);

-- ---------------

explain(SELECT OFFICER.Officer_ID, OFFICER.Officer_FName, OFFICER.Officer_LName, WING.Wing_Name, VISITOR.Visitor_Name
FROM OFFICER
NATURAL JOIN WING
NATURAL JOIN VISITOR);

CREATE INDEX idx_officer_wing_id_f ON OFFICER(Wing_ID);
-- drop index  idx_officer_wing_id_f ON OFFICER;


explain(SELECT OFFICER.Officer_ID, OFFICER.Officer_FName, OFFICER.Officer_LName, WING.Wing_Name, VISITOR.Visitor_Name
FROM OFFICER
NATURAL JOIN WING
NATURAL JOIN VISITOR);














