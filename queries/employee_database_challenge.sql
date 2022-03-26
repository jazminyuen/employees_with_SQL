-- Deliverable 1: The Number of Retiring Employees by Title
-- Create Retirement Title table
-- to hold all employee records eligible for retirement.
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_title
FROM employees as e
LEFT JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC;

-- Create Unique Titles table
-- to hold most recent titles of each employee.
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title,
INTO unique_titles
FROM retirement_title
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

-- Create Retiring Titles table
-- to show retiring employees by title.
SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

-- Deliverable 2: The Employees Eligible for the Mentorship Program
-- Create Mentorship Eligibility table
-- for current employees who were born between January 1, 1965 and December 31, 1965.
SELECT DISTINCT ON(e.emp_no) e.emp_no, 
	e.birth_date,
	e.first_name,
	e.last_name,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_emp as de
	ON e.emp_no = de.emp_no
LEFT JOIN titles as t
	ON e.emp_no = t.emp_no
WHERE de.to_date = ('9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no ASC;

-- Additional table: Mentorship Titles
-- to show eligible mentors by title.
SELECT COUNT(emp_no), title
INTO mentorship_titles
FROM mentorship_eligibility
GROUP BY title
ORDER BY COUNT(emp_no) DESC;