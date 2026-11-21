/*
QUESTION 01
TOPIC: Filtering + Sorting + TOP
DIFFICULTY: Intermediate

QUESTION:
Using the learners table, find the 10 most recently
admitted learners whose status is Active.

DISPLAY:
1. learner_id
2. first_name
3. last_name
4. admission_date
5. learner_status

REQUIREMENTS:
1. Only include learners with learner_status = 'Active'.
2. Sort admission_date from newest to oldest.
3. Return only 10 records.

TABLE:
learners
*/



select  top 10
	l.learner_id,
	l.first_name,
	l.last_name,
	l.admission_date,
	l.learner_status
from learners l
where l.learner_status='active'
order by l.admission_date desc;



/*
QUESTION 02
TOPIC: GROUP BY + COUNT + HAVING
DIFFICULTY: Intermediate

QUESTION:
Find the total number of learners in each degree program.

DISPLAY:
1. program_id
2. program_name
3. total_learners

REQUIREMENTS:
1. Include only learners whose status is Active.
2. Display only programs having more than 3 active learners.
3. Sort by total_learners in descending order.

TABLES:
learners
degree_programs
*/


select 
	dp.program_id,
	dp.program_name,
	count(distinct l.learner_id) [total learners]
from learners l
join degree_programs dp
on l.program_id=dp.program_id
where l.learner_status='active' 
group by  dp.program_id,
	dp.program_name
having count(distinct l.learner_id)>3
order by [total learners] desc



/*
QUESTION 03
TOPIC: INNER JOIN + DISTINCT + WHERE
DIFFICULTY: Intermediate

QUESTION:
Find all unique degree programs in which learners
with Active status are enrolled.

DISPLAY:
1. program_id
2. program_name
3. degree_level

REQUIREMENTS:
1. Use INNER JOIN.
2. Include only Active learners.
3. Do not display duplicate degree programs.
4. Sort program names alphabetically.

TABLES:
learners
degree_programs
*/


select distinct
	l.program_id,
	dp.program_name,
	dp.degree_level
from learners l
inner join degree_programs dp
on l.program_id=dp.program_id
where l.learner_status='active'
order by dp.program_name asc