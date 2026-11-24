/*
QUESTION 12
TOPIC: UNION ALL + STRING FUNCTIONS + SEARCHING
DIFFICULTY: Intermediate

QUESTION:
Create a combined list of learner first names and instructor names
that end with the letter 'n'.

DISPLAY:
1. person_name
2. person_type
3. name_length

REQUIREMENTS:
1. Retrieve matching first names from learners.
2. Retrieve matching instructor names from instructors.
3. Use UNION ALL to combine both result sets.
4. Convert all displayed names to lowercase using LOWER.
5. Calculate the name length using LEN.
6. Display 'Learner' as person_type for learners.
7. Display 'Instructor' as person_type for instructors.
8. Find names ending with 'n' using LIKE.
9. Sort by person_name alphabetically.

TABLES:
learners
instructors
*/


select 
	lower(l.first_name) as person_name,
	'learner' as person_type,
	len(l.first_name) as name_length
from learners l
where l.first_name like '%n'
union all 
select 
	lower(i.instructor_name) as person_name,
	'instructor' as person_type,
	len(i.instructor_name) as name_length
from instructors i
where i.instructor_name like '%n'
order by person_name asc


/*
QUESTION 13
TOPIC: INTERSECT + STRING FUNCTIONS + SEARCHING
DIFFICULTY: Intermediate

QUESTION:
Find names that appear both as learner first names and instructor names.

DISPLAY:
1. matching_name
2. name_length

REQUIREMENTS:
1. Extract first_name from learners.
2. Extract instructor_name from instructors.
3. Convert both names to uppercase using UPPER.
4. Use INTERSECT to find common names.
5. Include only names containing the letter 'a'.
6. Calculate the length of each matching name using LEN.
7. Sort alphabetically by matching_name.

TABLES:
learners
instructors
*/

select 
	upper(l.first_name) as matching_name,
	len(l.first_name) as name_length
from learners l
where l.first_name like '%a%'
intersect 
select 
	upper(i.instructor_name) as matching_name,
	len(i.instructor_name) as name_length
from instructors i
where i.instructor_name like '%a%'
order by matching_name asc


/*
QUESTION 14
TOPIC: EXCEPT + STRING FUNCTIONS + SEARCHING
DIFFICULTY: Intermediate

QUESTION:
Find learner first names that do not appear as instructor names.

DISPLAY:
1. learner_name
2. name_length

REQUIREMENTS:
1. Retrieve first_name from learners.
2. Retrieve instructor_name from instructors.
3. Convert both names to lowercase using LOWER.
4. Use EXCEPT to find names that exist among learners
   but do not exist among instructors.
5. Include only names containing the letter 'a'.
6. Calculate name length using LEN.
7. Sort alphabetically by learner_name.

TABLES:
learners
instructors
*/

select 
	lower(l.first_name) as learner_name,
	len(l.first_name) as name_length
from learners l
where l.first_name like '%a%'
except
select 
	lower(i.instructor_name) as learner_name,
	len(i.instructor_name) as name_length
from instructors i
where i.instructor_name like '%a%'
order by learner_name asc 


/*
QUESTION 15
TOPIC: INNER JOIN + LIKE + CONCAT + SUBSTRING + REPLACE
DIFFICULTY: Intermediate

QUESTION:
Create a formatted report of learners whose last names contain
the letter 'e' and whose program names contain the letter 'a'.

DISPLAY:
1. learner_id
2. full_name
3. formatted_name
4. program_name
5. program_code

REQUIREMENTS:
1. Combine first_name and last_name using CONCAT.
2. Convert full_name to uppercase.
3. Replace every occurrence of 'e' with '3' in last_name.
4. Extract the first 3 characters of program_name using LEFT.
5. Convert program_code to uppercase.
6. Filter last_name using LIKE '%e%'.
7. Filter program_name using LIKE '%a%'.
8. Use INNER JOIN.
9. Sort by program_name, then full_name.

TABLES:
learners
degree_programs
*/

select 
	l.learner_id,
	upper(concat(l.first_name,' ',l.last_name)) as full_name,
	replace(lower(l.last_name),'e','3') as formatted_name,
	dp.program_name,
	upper(left(dp.program_name,3)) as program_code
from learners l
inner join degree_programs dp
on l.program_id=dp.program_id
where l.last_name like '%e%' and dp.program_name like '%a%'
order by program_name,full_name asc


/*
QUESTION 16
TOPIC: LEFT JOIN + CONCAT + TRIM + REPLACE + LIKE
DIFFICULTY: Intermediate

QUESTION:
Generate a report of all learners and their scholarship information.

DISPLAY:
1. learner_id
2. full_name
3. learner_status
4. scholarship_name
5. formatted_scholarship_name
6. scholarship_amount

REQUIREMENTS:
1. Include all learners, even those without scholarship records.
2. Combine first_name and last_name using CONCAT.
3. Remove unwanted leading and trailing spaces from full_name using TRIM.
4. Replace spaces in scholarship_name with underscores.
5. Display scholarship_name in uppercase.
6. Display 0 when scholarship_amount is NULL.
7. Use LEFT JOIN.
8. Sort by learner_id ascending.

TABLES:
learners
grant_awards
*/


select 
	l.learner_id,
	trim(concat(l.first_name,' ',l.last_name)) as full_name,
	l.learner_status as learner_status,
	ga.award_name as scholarship_name ,
	replace(upper(ga.award_name),' ','_') as formatted_scholarship_name,
	isnull(ga.award_amount,0) as scholarship_amount
from learners l
left join grant_awards ga
on ga.learner_id=l.learner_id
order by learner_id asc