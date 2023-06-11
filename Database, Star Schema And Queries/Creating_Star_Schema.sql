--Creating the Dimension Tables and filling them with data

CREATE TABLE Books
	(
	bibno INT PRIMARY KEY,
	title VARCHAR(200),
	material VARCHAR(30),
	lang CHAR(3),
	place VARCHAR(40)
	);

INSERT INTO Books
	SELECT DISTINCT bibno, title, material, lang, place
	FROM libdata

CREATE TABLE Book_Copies
	(
	copyno CHAR(8) PRIMARY KEY,
	copyloc CHAR(3)
	);

INSERT INTO Book_Copies
	SELECT DISTINCT copyno, copyloc
	FROM libdata

CREATE TABLE Members
	(
	bid INT PRIMARY KEY,
	bname VARCHAR(60),
	sex CHAR(1)
	);

INSERT INTO Members
	SELECT DISTINCT bid, bname, sex
	FROM libdata
	

CREATE TABLE Departments
	(
	depcode INT PRIMARY KEY,
	depname VARCHAR(30)
	);

INSERT INTO Departments
	SELECT DISTINCT depcode, depname
	FROM libdata


--Creating the Fact Table and filling it with data

CREATE TABLE Loans
	(
	lid INT PRIMARY KEY,
	bibno INT FOREIGN KEY REFERENCES Books(bibno),
	copyno CHAR(8) FOREIGN KEY REFERENCES Book_Copies(copyno),
	bid INT FOREIGN KEY REFERENCES Members(bid),
	depcode INT FOREIGN KEY REFERENCES Departments(depcode),
	loandate DATE
	);

INSERT INTO Loans
	SELECT lid, bibno, copyno, bid, depcode, loandate
	FROM libdata


--Altering the fact table for better analysis

ALTER TABLE Loans
ADD loan_month INT,
	loan_year INT;

UPDATE Loans
SET loan_month = DATEPART(MONTH, loandate),
	loan_year = DATEPART(YEAR, loandate);