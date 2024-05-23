CREATE DATABASE HR;
USE HR;

CREATE TABLE Employees (
    Employee_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Gender ENUM('Male', 'Female'),
    Projects_Completed INT,
    Productivity FLOAT,
    Satisfaction_Rate FLOAT,
    Feedback_Score FLOAT,
    Department VARCHAR(100),
    Position VARCHAR(100),
    Joining_Date DATE,
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (Name, Age, Gender, Projects_Completed, Productivity, Satisfaction_Rate, Feedback_Score, Department, Position, Joining_Date, Salary)
VALUES 
('Douglas Lindsey', 25, 'Male', 11, 57.0, 25.0, 4.7, 'Marketing', 'Analyst', '2020-01-01', 63596.00),
('Anthony Roberson', 59, 'Female', 19, 55.0, 76.0, 2.8, 'IT', 'Manager', '1999-01-01', 112540.00),
('Thomas Miller', 30, 'Male', 8, 87.0, 10.0, 2.4, 'IT', 'Analyst', '2017-01-01', 66292.00),
('Jonathan Macias', 31, 'Female', 12, 68.0, 20.0, 3.3, 'IT', 'Analyst', '2018-01-01', 68534.00),
('Timothy Hines', 41, 'Female', 8, 85.0, 93.0, 2.4, 'Marketing', 'Analyst', '2016-01-01', 61771.00),
('Charles Prince', 36, 'Female', 16, 63.0, 81.0, 1.8, 'IT', 'Manager', '2009-01-01', 94789.00),
('Luis Garner', 24, 'Female', 12, 78.0, 94.0, 3.4, 'IT', 'Analyst', '2019-01-01', 69636.00),
('Eric Price', 33, 'Female', 15, 72.0, 73.0, 1.4, 'IT', 'Analyst', '2015-01-01', 76994.00),
('Ethan Stevenson', 32, 'Female', 17, 56.0, 29.0, 3.7, 'Marketing', 'Analyst', '2018-01-01', 61608.00),
('Robert Wilson', 26, 'Female', 6, 56.0, 36.0, 1.2, 'Marketing', 'Analyst', '2020-01-01', 60073.00),
('Victor Gutierrez', 43, 'Male', 10, 86.0, 71.0, 2.0, 'IT', 'Team Lead', '2014-01-14', 104341.00),
('John Doe', 30, 'Male', 5, 88.5, 92.3, 8.1, 'IT', 'Developer', '2022-01-15', 75000.00),
    ('Jane Smith', 28, 'Female', 3, 91.2, 87.5, 7.8, 'HR', 'HR Manager', '2021-03-22', 68000.00),
    ('Alice Johnson', 35, 'Female', 10, 89.4, 94.1, 8.5, 'Finance', 'Accountant', '2020-07-10', 72000.00),
    ('Robert Brown', 42, 'Male', 8, 84.6, 88.9, 8.2, 'Marketing', 'Marketing Manager', '2019-11-05', 82000.00),
    ('Emma Davis', 25, 'Female', 2, 90.1, 86.3, 7.9, 'Sales', 'Sales Executive', '2023-02-01', 65000.00),
    ('Michael Wilson', 38, 'Male', 7, 85.7, 90.5, 8.3, 'IT', 'System Administrator', '2018-09-18', 78000.00),
    ('Olivia Martinez', 29, 'Female', 4, 92.8, 89.7, 8.0, 'HR', 'Recruiter', '2021-05-16', 67000.00),
    ('James Anderson', 33, 'Male', 6, 87.3, 91.2, 8.4, 'Finance', 'Financial Analyst', '2020-12-08', 70000.00),
    ('Sophia Thomas', 31, 'Female', 9, 89.9, 93.4, 8.6, 'Marketing', 'Content Strategist', '2019-08-14', 76000.00),
    ('William Taylor', 27, 'Male', 5, 86.5, 87.9, 7.7, 'Sales', 'Sales Manager', '2022-10-30', 69000.00);

SELECT * FROM Employees;


--1) Count the number of employees in each department

SELECT Department, COUNT(*) AS employee_count
FROM employees
GROUP BY Department;

--2) Employees with the highest salary

SELECT Name,
       Salary
FROM Employees
ORDER BY Salary DESC
LIMIT 1;

--3)Average productivity of Employees in the IT department

SELECT AVG(Productivity) AS Avg_Productivity
FROM Employees
WHERE Department = 'IT';

--4) All Employees who joined the company after january 1,2021

SELECT *
FROM Employees
WHERE Joining_Date > '2021-01-01';

--5)Employee with the highest satifaction rate

SELECT Name, Satisfaction_Rate
FROM Employees
ORDER BY Satisfaction_Rate DESC
LIMIT 1;

--6)Calculation of the total salary expenditure for the HR department

SELECT SUM(Salary) AS Total_Salary_Expenditure
FROM Employees
WHERE Department = 'HR';

--7) Name of the employee who have completed more than 5 projects

SELECT Name
FROM Employees
WHERE Projects_Completed > 5;

--8) Average feedback score for employees in the sales department

SELECT AVG(Feedback_Score) AS Avg_Feedback_Score
FROM Employees
WHERE Department = 'Sales';

--9)All employees sorted by their joining date in ascending order

SELECT *
FROM Employees
ORDER BY Joining_Date ASC;

--10)Total number of male and female employees

SELECT Gender, COUNT(*) AS Count
FROM Employees
GROUP BY Gender;

--11)Average salary of employee in each department

SELECT Department, AVG(Salary) AS Avg_Salary
FROM Employees
GROUP BY Department;

--12)top 5 highest paid employees

SELECT Name, Salary
FROM Employees
ORDER BY Salary DESC
LIMIT 5;

--13)total number of project completed by each department

WITH DeptProjects AS (
    SELECT Department, SUM(Projects_Completed) AS Total_Projects
    FROM Employees
    GROUP BY Department
)
SELECT Department, Total_Projects
FROM DeptProjects
ORDER BY Total_Projects DESC;

--14)Average feedback score of employees who have completed more projects than the average number of projects
completed by all employees

WITH AvgProjects AS (
    SELECT AVG(Projects_Completed) AS Avg_Projects
    FROM Employees
)
SELECT AVG(Feedback_Score) AS Avg_Feedback_Score
FROM Employees
WHERE Projects_Completed > (SELECT Avg_Projects FROM AvgProjects);

--15)Youngest employee in each department

WITH DeptMinAge AS (
    SELECT Department, MIN(Age) AS Min_Age
    FROM Employees
    GROUP BY Department
)
SELECT e.Name, e.Department, e.Age
FROM Employees e
JOIN DeptMinAge d
ON e.Department = d.Department AND e.Age = d.Min_Age;

--16)employees who have been with the company for more than 3 years and have a productivity rate higher than the
 average productivity rate of the company.
 
 WITH CompanyAvgProductivity AS (
    SELECT AVG(Productivity) AS Avg_Productivity
    FROM Employees
)
SELECT Name, Department, Productivity, TIMESTAMPDIFF(YEAR, Joining_Date, CURDATE()) AS Years_With_Company
FROM Employees
WHERE TIMESTAMPDIFF(YEAR, Joining_Date, CURDATE()) > 3
AND Productivity > (SELECT Avg_Productivity FROM CompanyAvgProductivity);


--17) the top 5 departments with the highest total salary expenditure

WITH DeptTotalSalary AS (
    SELECT Department, SUM(Salary) AS Total_Salary
    FROM Employees
    GROUP BY Department
)
SELECT Department, Total_Salary
FROM DeptTotalSalary
ORDER BY Total_Salary DESC
LIMIT 5;

--18)department with the highest average productivity

WITH DeptProductivity AS (
    SELECT Department, AVG(Productivity) AS Avg_Productivity
    FROM Employees
    GROUP BY Department
)
SELECT Department, Avg_Productivity
FROM DeptProductivity
ORDER BY Avg_Productivity DESC
LIMIT 3;


--19)employees whose salaries are above the average salary of their respective departments

WITH DeptAvgSalary AS (
    SELECT Department, AVG(Salary) AS Avg_Salary
    FROM Employees
    GROUP BY Department
)
SELECT e.Name, e.Department, e.Salary
FROM Employees e
JOIN DeptAvgSalary d
ON e.Department = d.Department
WHERE e.Salary > d.Avg_Salary;

--20)average salary of employees who have a satisfaction rate above
 the average satisfaction rate of all employees.
 
 WITH AvgSatisfaction AS (
    SELECT AVG(Satisfaction_Rate) AS Avg_Satisfaction
    FROM Employees
)
SELECT AVG(Salary) AS Avg_Salary
FROM Employees
WHERE Satisfaction_Rate > (SELECT Avg_Satisfaction FROM AvgSatisfaction);





 
 



