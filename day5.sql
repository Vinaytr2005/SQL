/*
QUESTION 17
TOPIC: INNER JOIN + STRING FUNCTIONS + SEARCHING
DIFFICULTY: Intermediate

QUESTION:
Create a report showing degree programs and the departments
they belong to.

DISPLAY:
1. item_name
2. item_type
3. item_length
4. first_three_characters

REQUIREMENTS:
1. Retrieve program_name from degree_programs as item_name.
2. Retrieve dept_name from departments as item_type.
3. Calculate the length of dept_name using LEN.
4. Extract the first 3 characters of program_name using LEFT.
5. Use INNER JOIN to connect degree_programs and departments.
6. Include only program names containing the letter 'e'.
7. Sort by program_name in ascending order.

TABLES:
degree_programs
departments
*/

select 
	dp.program_name as item_name,
	d.dept_name as item_type,
	len(d.dept_name) as item_length,
	left(dp.program_name,3) as first_three_char
from degree_programs dp
join departments d
on d.dept_id=dp.dept_id
where dp.program_name like '%e%'
order by dp.program_name asc


/*
QUESTION 18
TOPIC: INNER JOIN + UNION + STRING FUNCTIONS
DIFFICULTY: Intermediate

QUESTION:
Create a combined list of degree program names and department names
that contain the letter 'e'.

DISPLAY:
1. item_name
2. item_type
3. item_length
4. first_three_characters

REQUIREMENTS:
1. Retrieve program_name from degree_programs.
2. Retrieve dept_name from departments.
3. Use UNION to combine both result sets.
4. Convert item_name to uppercase.
5. Calculate item_length using LEN.
6. Extract the first three characters using LEFT.
7. Display 'Program' as item_type for degree programs.
8. Display 'Department' as item_type for departments.
9. Find names containing 'e' using LIKE.
10. Sort alphabetically by item_name.

TABLES:
degree_programs
departments
*/


select 
	upper(dp.program_name) as item_name,
	'Program' as item_type,
	len(dp.program_name) as item_length,
	left(dp.program_name,3) as first_three_characters
from degree_programs dp
where dp.program_name like '%e%'
union 
select 
	upper(d.dept_name) as item_name,
	'Department' as item_type,
	len(d.dept_name) as item_length,
	left(d.dept_name,3) as  first_three_characters
from departments d
where d.dept_name like '%e%'
order by item_name asc



/*
QUESTION 19
TOPIC: INNER JOIN + STRING FUNCTIONS + SEARCHING
DIFFICULTY: Intermediate

QUESTION:
Create a list of learners and their degree programs.
Display each learner's full name and program name, along with
a cleaned version of the program name.

DISPLAY:
1. learner_full_name
2. program_name
3. cleaned_program_name
4. program_name_length
5. last_four_characters

REQUIREMENTS:
1. Combine first_name and last_name into learner_full_name using CONCAT.
2. Retrieve the program_name for each learner.
3. Use INNER JOIN to connect learners with degree_programs.
4. Convert learner_full_name to uppercase.
5. Use TRIM to remove leading and trailing spaces from program_name.
6. Replace the letter 'a' with '@' in cleaned_program_name.
7. Calculate program_name_length using LEN.
8. Extract the last four characters of program_name using RIGHT.
9. Find learners whose last_name starts with 'S' using LIKE.
10. Sort by learner_full_name in ascending order.

TABLES:
learners
degree_programs
*/

select 
	upper(concat(l.first_name,' ',l.last_name)) as learner_full_name,
	trim(dp.program_name) as program_name,
	replace(trim(dp.program_name),'a','@') as cleaned_program_name,
	len(dp.program_name) as program_name_length,
	right(dp.program_name,4) as last_four_characters
from learners l
inner join degree_programs  dp
on dp.program_id=l.program_id
where l.last_name like 's%'
order by learner_full_name asc


/*
QUESTION 20
TOPIC: ROUND + ABS + DATE/TIME FUNCTIONS
DIFFICULTY: Intermediate

QUESTION:
Create a report of grant awards showing the award amount,
its rounded value, the absolute difference from 5000,
and the number of days since the award was granted.

DISPLAY:
1. award_name
2. award_amount
3. rounded_award_amount
4. difference_from_5000
5. days_since_award

REQUIREMENTS:
1. Retrieve award_name and award_amount from grant_awards.
2. Use ROUND to round award_amount to the nearest hundred.
3. Use ABS to calculate the absolute difference between award_amount and 5000.
4. Use DATEDIFF to calculate the days between award_date and the current date.
5. Use GETDATE() to obtain the current date and time.
6. Exclude records where award_date is NULL.
7. Sort by days_since_award from largest to smallest.

TABLES:
grant_awards
*/


select 
	ga.award_name as award_name,
	ga.award_amount as award_amount,
	round(ga.award_amount,100) as rounded_award_amount,
	abs(ga.award_amount-5000) as difference_from_5000,
	datediff(day,ga.award_date,getdate()) as days_since_award
from grant_awards ga
where ga.award_date is not null
order by days_since_award desc