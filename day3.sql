/*
QUESTION 08
TOPIC: INNER JOIN + GROUP BY + COUNT + CASE
DIFFICULTY: Intermediate

QUESTION:
Prepare a report showing the number of learners in each degree program, split by learner status.

DISPLAY:
1. program_name
2. total_learners
3. active_learners
4. inactive_learners

REQUIREMENTS:
1. Include only degree programs that have at least one learner.
2. Count all learners in each program.
3. Count active learners separately.
4. Count inactive learners separately.
5. Use conditional aggregation with CASE.
6. Group by degree program.
7. Sort by total_learners in descending order.

TABLES:
degree_programs
learners
*/

select
	dp.program_name,
	count(distinct l.learner_id) as total_learners,
	count(distinct case when l.learner_status='active' then l.learner_id end) as active_learners,
	count(distinct case when l.learner_status='inactive' then l.learner_id end) as inactive_learners
from learners l
inner join degree_programs dp
on dp.program_id=l.program_id
group by dp.program_name
having count(distinct l.learner_id)>=1
order by total_learners desc


/*
QUESTION 09
TOPIC: JOIN + STRING FUNCTIONS + SEARCHING
DIFFICULTY: Intermediate

QUESTION:
Create a learner contact-style report for learners whose first name
contains the letter 'a'.

DISPLAY:
1. learner_id
2. full_name
3. program_name
4. formatted_program_name
5. first_name_length
6. first_name_initials

REQUIREMENTS:
1. Combine first_name and last_name into full_name using CONCAT.
2. Display program_name in uppercase as formatted_program_name.
3. Calculate the length of first_name using LEN.
4. Extract the first character of first_name and last_name
   using LEFT.
5. Combine those two characters as first_name_initials.
6. Find learners whose first_name contains 'a', regardless of case.
7. Use INNER JOIN.
8. Sort by full_name alphabetically.

TABLES:
learners
degree_programs
*/



select 
	l.learner_id,
	concat(l.first_name,' ',l.last_name) as full_name,
	dp.program_name,
	upper(dp.program_name) as formated_program_name,
	len(l.first_name) as first_name_length,
	trim(left(l.first_name,1))+trim(left(l.last_name,1)) as first_name_initials
from learners l
inner join degree_programs dp
on dp.program_id=l.program_id
where l.first_name like '%a%'
order by full_name asc



/*
QUESTION 10
TOPIC: JOIN + STRING EXTRACTION + REPLACE + SEARCHING
DIFFICULTY: Intermediate

QUESTION:
Generate a formatted learner information report for learners whose
last name contains the letter 's'.

DISPLAY:
1. learner_id
2. full_name
3. cleaned_last_name
4. last_name_length
5. last_two_characters
6. first_name_middle_part
7. program_name

REQUIREMENTS:
1. Combine first_name and last_name using CONCAT.
2. Convert last_name to lowercase.
3. Replace every occurrence of 's' with '$' in the last name.
4. Calculate last_name length using LEN.
5. Extract the last two characters of last_name using RIGHT.
6. Extract characters starting from position 2, with length 3,
   from first_name using SUBSTRING.
7. Find learners whose last_name contains 's'.
8. Use INNER JOIN.
9. Sort by last_name in ascending order.

TABLES:
learners
degree_programs
*/


select 
	l.learner_id,
	concat(l.first_name,' ',l.last_name) as full_name,
	replace(lower(l.last_name),'s','$') as cleaned_last_name,
	len(l.last_name) as last_name_length,
	right(l.last_name,2) as last_two_characters,
	substring(l.first_name,2,3) as first_name_middle_part,
	dp.program_name
from learners l
inner join degree_programs dp
on dp.program_id=l.program_id
where l.last_name like '%s%'
order by l.last_name asc


/*
QUESTION 11
TOPIC: UNION + STRING FUNCTIONS + SEARCHING
DIFFICULTY: Intermediate

QUESTION:
Create a combined list of learner first names and instructor names
that contain the letter 'a'.

DISPLAY:
1. person_name
2. person_type

REQUIREMENTS:
1. Retrieve matching first names from learners.
2. Retrieve matching instructor names from instructors.
3. Use UNION to combine both result sets.
4. Convert all displayed names to uppercase using UPPER.
5. Use LIKE to find names containing 'a'.
6. Display 'Learner' as person_type for learners.
7. Display 'Instructor' as person_type for instructors.
8. Sort by person_name alphabetically.

TABLES:
learners
instructors
*/


select 
	upper(l.first_name) as person_name,
	'Learner' as person_type
from learners l
where l.first_name like '%a%'
union
select 
	upper(i.instructor_name) as person_name,
	'Instructor' as person_type
from instructors i
where i.instructor_name like '%a%'
order by person_name asc