-- LINK : https://en.wikibooks.org/wiki/SQL_Exercises/Employee_management
SELECT * FROM sql_exercise_2.employees;
SELECT * FROM sql_exercise_2.departments;

-- 2.1 Select the last name of all employees.
select lastname
from employees;

-- 2.2 Select the last name of all employees, without duplicates.
select distinct lastname
from employees;

-- 2.3 Select all the data of employees whose last name is "Smith".
select *
from employees
where lastname = "Smith";

-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
select *
from employees
where lastname in ("Smith", "Doe") ;

-- 2.5 Select all the data of employees that work in department 14.
select *
from employees
where Department = 14;

-- 2.6 Select all the data of employees that work in department 37 or department 77.
select *
from employees
where Department in (37,77);

-- 2.7 Select all the data of employees whose last name begins with an "S".
select *
from employees
where LastName like "S%";

-- 2.8 Select the sum of all the departments' budgets.
select name Name, sum(budget) Total_Sum
from departments
group by name;

-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).
select Department, count(*) employees_in_each_dept
from employees
group by Department;

-- 2.10 Select all the data of employees, including each employee's department's data.
select * 
from employees e
join departments d on e.Department = d.Code;

-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
select e.name, lastname, d.name, budget
from employees e
join departments d on e.Department = d.Code;

-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
select e.name, lastname
from employees e
join departments d on e.Department = d.Code
where budget > 60000;

-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
select name
from departments
where budget > (select avg(budget) from departments);

-- 2.14 Select the names of departments with more than two employees.
select name
from departments 
where code in (select Department from employees group by Department having count(Department)>2);

-- 2.15 Very Important - Select the name and last name of employees working for departments with second lowest budget.
SELECT e.Name, e.LastName
FROM Employees e 
WHERE e.Department = (
       SELECT sub.Code 
       FROM (SELECT * FROM Departments d ORDER BY d.budget LIMIT 2) sub 
       ORDER BY budget DESC LIMIT 1);


-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
insert into departments (Code, Name, Budget)
values (11, "Quality Assurance", 40000);

insert into employees values(847219811, 'Mary', 'Moore', 11);


-- 2.17 Reduce the budget of all departments by 10%.
update departments
set budget = budget*0.9;

-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).
update employees
set Department = 14
where Department = 77;

-- 2.19 Delete from the table all employees in the IT department (code 14).
delete from employees
where Department = 14;

-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
delete from employees
where department in (select code from departments where budget >= 60000);

-- 2.21 Delete from the table all employees.
delete from employees;