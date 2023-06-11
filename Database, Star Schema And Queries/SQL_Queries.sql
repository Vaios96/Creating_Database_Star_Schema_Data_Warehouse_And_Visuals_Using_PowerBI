--Some queries (important note: I am not allowed to use Views)

--Display a catalog with the number of loans per department and sex
SELECT COUNT(*) AS loaned_books, Departments.depname, Members.sex
FROM Loans
	JOIN Departments ON Departments.depcode = Loans.depcode
	JOIN Members ON Members.bid = Loans.bid
GROUP BY depname, sex
ORDER BY loaned_books DESC


--Display a catalog with the number of loans per copy location and material
SELECT COUNT(*) AS loaned_books, Book_Copies.copyloc, Books.material
FROM Loans
	JOIN Book_Copies ON Book_Copies.copyno = Loans.copyno
	JOIN Books ON Books.bibno = Loans.bibno
GROUP BY copyloc, material
ORDER BY loaned_books DESC


--Display a catalog with the number of loans per month and sex for the year 2000
SELECT COUNT(*) AS loaned_books, loan_month
FROM Loans
WHERE loan_year = 2000
GROUP BY loan_month
ORDER BY loan_month

--Create a report that generates: 
--a. Total number of loans
--b. Total number of loans per year
--c. Total number of loans per year and quarter
--d. Total number of loans per year, quarter and month

SELECT
  COUNT(*) AS total_loans,
  DATEPART(YEAR, loandate) AS loan_year,
  COUNT(*) AS loans_per_year,
  DATEPART(YEAR, loandate) AS loan_year_quarter,
  (DATEPART(QUARTER, loandate) - 1) / 3 + 1 AS loan_quarter,
  COUNT(*) AS loans_per_year_quarter,
  DATEPART(YEAR, loandate) AS loan_year_quarter_month,
  (DATEPART(QUARTER, loandate) - 1) / 3 + 1 AS loan_quarter,
  DATEPART(MONTH, loandate) AS loan_month,
  COUNT(*) AS loans_per_year_quarter_month
FROM Loans
GROUP BY
  ROLLUP (
    (DATEPART(YEAR, loandate)),
    (DATEPART(YEAR, loandate), (DATEPART(QUARTER, loandate) - 1) / 3 + 1),
    (DATEPART(YEAR, loandate), (DATEPART(QUARTER, loandate) - 1) / 3 + 1, DATEPART(MONTH, loandate))
  )

--Write an SQL query that creates a data cube, where each cell contains the number of loans per year and department
SELECT 
	loan_year,
	depname,
	COUNT(*) AS loaned_books
FROM Loans
JOIN Departments ON Departments.depcode = Loans.depcode
GROUP BY CUBE (loan_year, depname)