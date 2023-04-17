create table employees(
	emp_no int not null,
	emp_title_id varchar(10) not null,
	birth_date date not null,
	first_name varchar(20),
	last_name varchar(20) not null,
	sex varchar(5) not null,
	hire_date date not null,
	primary key (emp_no)
	)

create table dept_manager(
	dept_no varchar(10) not null,
	emp_no int not null,
	foreign key(emp_no) references employees(emp_no)
	)

create table dept_emp(
	emp_no int not null,
	dept_no varchar(10) not null,
	foreign key(emp_no) references employees(emp_no)
	)

create table salaries(
	emp_no int not null,
	salary int not null,
	foreign key(emp_no) references employees(emp_no)
	)
	
create table titles(
	title_id varchar(10) not null,
	title varchar(50) not null
	)

create table departments(
	dept_no varchar(10) not null,
	dept_name varchar(50) not null
	)	

--List the employee number, last name, first name, sex, and salary of each employee
select employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
from employees
left join salaries on employees.emp_no=salaries.emp_no

--List the first name, last name, and hire date for the employees who were hired in 1986 
select employees.first_name, employees.last_name, employees.hire_date
from employees
where employees.hire_date >= '1986-01-01' and  employees.hire_date <= '1986-12-31'

--List the manager of each department along with their department number, department name, employee number, last name, and first name
select dept_manager.emp_no, dept_manager.dept_no, departments.dept_name, employees.first_name, employees.last_name
from dept_manager
left join departments on dept_manager.dept_no=departments.dept_no
left join employees on dept_manager.emp_no=employees.emp_no

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name
select dept_emp.dept_no, dept_emp.emp_no, employees.first_name, employees.last_name, departments.dept_name
from dept_emp
left join employees on dept_emp.emp_no=employees.emp_no
left join departments on dept_emp.dept_no=departments.dept_no

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B 
select employees.first_name, employees.last_name, employees.sex
from employees
where employees.first_name = 'Hercules' and employees.last_name like 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name
select employees.emp_no, employees.first_name, employees.last_name, dept_manager.dept_no, dept_emp.dept_no
from employees
left join dept_manager on employees.emp_no=dept_manager.emp_no
left join dept_emp on employees.emp_no=dept_emp.emp_no
where dept_manager.dept_no = 'd007' or dept_emp.dept_no = 'd007'

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
select employees.emp_no, employees.first_name, employees.last_name, dept_manager.dept_no, dept_emp.dept_no
from employees
left join dept_manager on employees.emp_no=dept_manager.emp_no
left join dept_emp on employees.emp_no=dept_emp.emp_no
where dept_manager.dept_no = 'd007' or dept_manager.dept_no = 'd005' or dept_emp.dept_no = 'd007' or dept_emp.dept_no = 'd005'

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name) 
select last_name, count(emp_no)
from employees
group by last_name
order by count(emp_no) desc