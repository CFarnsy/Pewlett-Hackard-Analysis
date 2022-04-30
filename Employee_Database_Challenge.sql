-- Create a retirement_titles table of employees born between 1952 and 1955, then order by employee number.
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (t.to_date = '9999-01-01')
ORDER BY e.emp_no;

-- CHALLENGE STARTER CODE PROVIDED
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (______) _____,
______,
______,
______

INTO nameyourtable
FROM _______
WHERE _______
ORDER BY _____, _____ DESC;

-- PROVIDED STARTER CODE UPDATED WITH INFO
-- Use Dictinct with Orderby to remove duplicate rows of employees that are retiring.
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
					rt.first_name,
					rt.last_name,
					rt.title
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY emp_no, title DESC;

-- Create a retiring_titles table of the number of employees by their most recent job title who are about to retire.
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

-- Create mentorship_eligibility table for current employees who are eligible to participate in a mentorship program.
SELECT DISTINCT ON(e.emp_no)e.emp_no,
				e.first_name,
				e.last_name,
				e.birth_date,
				de.from_date,
				de.to_date,
				t.title
INTO mentorship_eligibility
FROM employees AS e
LEFT JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

-- Create a unique_department table of the employees by department who are eligible to retire.
SELECT DISTINCT ON(ut.emp_no) ut.emp_no, 
	d.dept_no, 
	d.dept_name
INTO unique_department
FROM dept_emp AS de
INNER JOIN unique_titles AS ut
ON (de.emp_no = ut.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
GROUP BY d.dept_no, d.dept_name, ut.emp_no
ORDER BY (ut.emp_no) DESC;

-- Create a retiring_department table of the number of employees by department who are eligible to retire.
SELECT COUNT(ud.emp_no), ud.dept_name
INTO retiring_department
FROM unique_department AS ud
GROUP BY ud.dept_name
ORDER BY COUNT(ud.emp_no) DESC;
