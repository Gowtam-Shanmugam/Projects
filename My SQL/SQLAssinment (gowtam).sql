create database company
use company

create table Employee_Table(Employee_id int primary key,
First_name varchar(50), Last_name varchar(50),
Salary money, Joining_date datetime, Department varchar(50))

insert into Employee_Table(Employee_id, First_name,
Last_name,Salary,Joining_date,Department)
select 1, 'Anika', 'Arora',100000,'2020-02-14 9:00:00', 'HR' union all
select 2, 'Veena', 'Verma', 80000, '2011-06-15 9:00:00', 'Admin' union all
select 3, 'Vishal', 'Singhal', 300000, '2020-02-16 9:00:00', 'HR' union all
select 4, 'Sushanth', 'Singh', 500000, '2020-02-17 9:00:00', 'Admin' union all
select 5, 'Bhupal', 'Bhati', 500000, '2011-06-18 9:00:00', 'Admin' union all
select 6, 'Dheeraj', 'Diwan', 200000, '2011-06-19 9:00:00', 'Account' union all
select 7, 'Karan', 'Kumar', 75000, '2020-01-14 9:00:00', 'Account' union all
select 8, 'Chandrika', 'Chauhan', 90000, '2011-04-15 9:00:00', 'Admin'

select* from Employee_Table
drop table Employee_Table

create table Employee_Bonus_Table(
Employee_ref_id int foreign key references Employee_Table(employee_id),
Bonus_Amount money, Bonus_Date datetime)

select* from Employee_Bonus_Table
drop table Employee_Bonus_Table

insert into Employee_Bonus_Table(Employee_ref_id,Bonus_Amount,Bonus_Date)
select 1,5000,'2020-02-16 0:00:00' union all
select 2,3000,'2011-06-16 0:00:00' union all
select 3,4000,'2020-02-16 0:00:00' union all
select 1,4500,'2020-02-16 0:00:00' union all
select 2,3500,'2011-06-16 0:00:00'

create table Employee_Title_Table(
Employee_ref_id int foreign key references employee_table(employee_id),
Employee_Title varchar(50), Affective_Date datetime)

select* from Employee_Title_Table

insert into Employee_Title_Table(Employee_ref_id,Employee_Title,Affective_Date)
select 1,'Manager','2016-02-20 0:00:00' union all
select 2,'Executive','2016-06-11 0:00:00' union all
select 8,'Executive','2016-06-11 0:00:00' union all
select 5,'Manager','2016-06-11 0:00:00' union all
select 4,'Asst.Manager','2016-06-11 0:00:00' union all
select 7,'Executive','2016-06-11 0:00:00' union all
select 6,'Lead','2016-06-11 0:00:00' union all
select 3,'Lead','2016-06-11 0:00:00'

------------------------------------------------------------------------------

--1. Display the “FIRST_NAME” from Employee table using the alias name as Employee_name.
select first_name 'Employee_name' from employee_table

---------------------------------------------------------------------------------

--2. Display “LAST_NAME” from Employee table in upper case.
select upper(last_name) 'Employee_last_name' from employee_table

--------------------------------------------------------------------------------------

--3. Display unique values of DEPARTMENT from EMPLOYEE table.
select distinct department from employee_table

-------------------------------------------------------------------------------------

--4. Display the first three characters of LAST_NAME from EMPLOYEE table.
select SUBSTRING(last_name,1,3) from employee_table

-------------------------------------------------------------------------------------

--5. Display the unique values of DEPARTMENT from EMPLOYEE table and prints its length.
select distinct department from employee_table
select distinct len(department) 'length' from employee_table

-------------------------------------------------------------------------------------

--6. Display the FIRST_NAME and LAST_NAME from EMPLOYEE table into a single column AS FULL_NAME.
--A space char should separate them.
select CONCAT(first_name,' ',last_name) 'Full_name' from employee_table

---------------------------------------------------------------------------------------

--7. DISPLAY all EMPLOYEE details from the employee table order by FIRST_NAME Ascending.
select* from employee_table
order by (first_name)

----------------------------------------------------------------------------------------

--8. Display all EMPLOYEE details order by FIRST_NAME Ascending and DEPARTMENT Descending.
select* 
from employee_table
order by first_name asc, department desc

---------------------------------------------------------------------------------------

--9. Display details for EMPLOYEE with the first name as “VEENA” and “KARAN” from EMPLOYEE table.
select* from employee_table
where first_name = 'veena' or first_name='karan'

-----------------------------------------------------------------------------------------

--10. Display details of EMPLOYEE with DEPARTMENT name as “Admin”.
select* from employee_table
where department='admin'

---------------------------------------------------------------------------------------

--11. DISPLAY details of the EMPLOYEES whose FIRST_NAME contains ‘V’.
select* from employee_table
where first_name like '%v%'

---------------------------------------------------------------------------------------

--12. DISPLAY details of the EMPLOYEES whose SALARY lies between 100000 and 500000.
select* from employee_table
where salary between 100001 and 499999

-------------------------------------------------------------------------------------

--13. Display details of the employees who have joined in Feb-2020.
SELECT *
FROM employee_table
WHERE month(joining_date)=2

------------------------------------------------------------------------------------

--14. Display employee names with salaries >= 50000 and <= 100000.
select concat(first_name,' ',last_name) as Employee_Name, salary
from employee_table
where salary between 50000 and 100000

--------------------------------------------------------------------------------------

--16. DISPLAY details of the EMPLOYEES who are also Managers.
select*
from employee_table e
inner join Employee_Title_Table et
on e.employee_id=et.Employee_ref_id
where Employee_Title='manager'

----------------------------------------------------------------------------------------

--17. DISPLAY duplicate records having matching data in some fields of a table.
SELECT employee_ref_id, COUNT(*)
FROM Employee_Bonus_Table
GROUP BY employee_ref_id
HAVING COUNT(*) > 1

-----------------------------------------------------------------------------------

--18. Display only odd rows from a table.
SELECT*
FROM (
    SELECT *, Row_Number() OVER(ORDER BY employee_id) AS RowNumber 
            
    FROM employee_table
) t
WHERE t.RowNumber % 2 <> 0

------------------------------------------------------------------------------------

--19. Clone a new table from EMPLOYEE table.
select* into clone from Employee_table;
select* from clone

------------------------------------------------------------------------------------

--20. DISPLAY the TOP 2 highest salary from a table.
select top 2*
from employee_table
order by salary desc 

-----------------------------------------------------------------------------------

--21. DISPLAY the list of employees with the same salary.
SELECT *
FROM employee_table
WHERE salary IN
    (SELECT salary
     FROM employee_table e
     WHERE employee_table.employee_id <> e.employee_id)

------------------------------------------------------------------------------------

--22. Display the second highest salary from a table.
select*
from (
    SELECT *, Row_Number() OVER(ORDER By salary desc) AS RowNumber 
            
    FROM employee_table
) t
WHERE t.RowNumber= 2

-----------------------------------------------------------------------------------

--23. Display the first 50% records from a table.
select top 50 percent * 
from employee_table

------------------------------------------------------------------------------------

--24. Display the departments that have less than 4 people in it.
SELECT department, COUNT(*)
FROM Employee_table
GROUP BY department
HAVING COUNT(*) < 4

-------------------------------------------------------------------------------------

--25. Display all departments along with the number of people in there.
SELECT department, COUNT(*)
FROM Employee_table
GROUP BY department

-------------------------------------------------------------------------------------

--26. Display the name of employees having the highest salary in each department.
SELECT concat(first_name,' ',last_name) as Employee_name,department, salary 
	FROM employee_table e
		WHERE salary = 
			(SELECT MAX(salary) 
				FROM employee_table 
			WHERE department = e.department)

-----------------------------------------------------------------------------------

--27. Display the names of employees who earn the highest salary.
select top 2*
from employee_table
order by salary desc 

----------------------------------------------------------------------------------

--28. Diplay the average salaries for each department
SELECT DEPARTMENT,AVG(SALARY) AS 
AVERAGE_SALARY FROM employee_table GROUP BY DEPARTMENT

-----------------------------------------------------------------------------------

--29. display the name of the employee who has got maximum bonus
select top 1*
from employee_bonus_table
order by bonus_amount desc

--------------------------------------------------------------------------------------

--30. Display the first name and title of all the employees
select first_name, Employee_Title
from employee_table e
inner join Employee_Title_Table et
on e.employee_id=et.Employee_ref_id

-----------------x---------------------x--------------------x---------------x------------
