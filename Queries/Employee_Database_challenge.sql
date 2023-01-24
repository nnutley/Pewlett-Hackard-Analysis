--Joining the Employees and titles tables
SELECT e.emp_no,
		e.first_name,
		e.last_name,
		ti.title,
		ti.from_date,
		ti.to_date
--INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
--INTO unique_titles
FROM retirement_titles as rt
WHERE (rt.to_date= '1999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

--Create retiring titles table
SELECT COUNT(title), 
	ut.title
--INTO retiring_titles
FROM unique_titles as ut
GROUP BY title
ORDER BY ut.count DESC;

--Create mentorship-eligibility table
SELECT DISTINCT ON (emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		ti.title
--INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '1999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;



--Joining the Employees, titles, & department info. tables
SELECT e.emp_no,
		e.first_name,
		e.last_name,
		ti.title,
		ti.from_date,
		ti.to_date,
		di.dept_name
--INTO retirement_dept
FROM employees as e
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
INNER JOIN dept_info as di
ON e.emp_no = di.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) rd.emp_no,
	rd.first_name,
	rd.last_name,
	rd.title,
	rd.dept_name
--INTO unique_dept
FROM retirement_dept as rd
WHERE (rd.to_date= '1999-01-01')
ORDER BY rd.emp_no, rd.to_date DESC;

--Create retiring departments table
SELECT COUNT(dept_name), 
	ud.dept_name
--INTO retiring_dept
FROM unique_dept as ud
GROUP BY dept_name
ORDER BY ud.count DESC;

--Create mentorship-dept table
SELECT DISTINCT ON (emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		de.dept_no,
		d.dept_name
--INTO mentorship_dept
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE (de.to_date = '1999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

--Create mentorship departments 2 table
SELECT COUNT(dept_name), 
	md.dept_name
--INTO mentorship_dept_2
FROM mentorship_dept as md
GROUP BY dept_name
ORDER BY md.count DESC;