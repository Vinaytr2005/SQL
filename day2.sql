


/*
QUESTION 04
TOPIC: INNER JOIN + GROUP BY + COUNT + AVG
DIFFICULTY: Intermediate

QUESTION:
Find the total number of learners and their average
age for each degree program.

DISPLAY:
1. program_name
2. total_learners
3. average_age

REQUIREMENTS:
1. Include only Active learners.
2. Calculate age using date_of_birth.
3. Round average age to 2 decimal places.
4. Display only programs having at least 3 learners.
5. Sort by average_age in descending order.

TABLES:
learners
degree_programs
*/

select 
	dp.program_name,
	count(l.learner_id) as total_learners,
	round(avg(datediff(year,l.date_of_birth,GETDATE())),2) as average_age
from learners l
inner join degree_programs dp
on dp.program_id=l.program_id
where l.learner_status='active'
group by dp.program_name
having count(l.learner_id)>=3
order by average_age desc




/*
QUESTION 05
TOPIC: INNER JOIN + GROUP BY + SUM
DIFFICULTY: Intermediate

QUESTION:
Find the total scholarship amount awarded to learners
in each degree program.

DISPLAY:
1. program_name
2. total_learners
3. total_scholarship_amount

REQUIREMENTS:
1. Include only scholarships with award_status = 'Disbursed'.
2. Include only learners whose learner_status = 'Active'.
3. Calculate the total scholarship amount using SUM().
4. Display only programs with total scholarship amounts
   greater than 20000.
5. Sort by total_scholarship_amount in descending order.

TABLES:
learners
degree_programs
grant_awards
*/

select 
	dp.program_name,
	count(distinct l.learner_id) as total_learners,
	sum(ga.award_amount) as total_scholarship_amount
from learners l
inner join degree_programs dp
on l.program_id=dp.program_id
inner join grant_awards ga
on ga.learner_id=l.learner_id
where ga.award_status='Disbursed' and l.learner_status='active'
group by dp.program_name
having sum(ga.award_amount) >20000
order  by total_scholarship_amount desc



/*
QUESTION 06
TOPIC: LEFT JOIN + COUNT + IS NULL
DIFFICULTY: Intermediate

QUESTION:
Find all learners who have never received any scholarship.

DISPLAY:
1. learner_id
2. first_name
3. last_name
4. learner_status

REQUIREMENTS:
1. Include all learners regardless of their status.
2. Use LEFT JOIN.
3. Identify learners without scholarship records.
4. Do not use subqueries.
5. Avoid duplicate learners.
6. Sort by learner_id in ascending order.

TABLES:
learners
grant_awards
*/


select distinct
	l.learner_id,
	l.first_name,
	l.last_name,
	l.learner_status
from learners l
left join grant_awards ga
on ga.learner_id=l.learner_id
where ga.award_id is null
order by l.learner_id asc


/*
QUESTION 07
TOPIC: LEFT JOIN + GROUP BY + COUNT
DIFFICULTY: Intermediate

QUESTION:
Generate a report showing how many scholarship awards each degree program has received.

DISPLAY:
1. program_name
2. total_awards
3. total_award_amount

REQUIREMENTS:
1. Include every degree program, even if it has no scholarship awards.
2. Count only awards with status 'Disbursed'.
3. Calculate the total amount of disbursed awards.
4. Use LEFT JOIN.
5. Display 0 instead of NULL when a program has no disbursed awards.
6. Group the results by degree program.
7. Sort by total_award_amount in descending order.

TABLES:
degree_programs
learners
grant_awards
*/


select
	dp.program_name,
	count(distinct ga.award_id) as total_awards,
	isnull(sum(ga.award_amount),0) as total_award_amount 
from degree_programs dp
left join learners l
ON dp.program_id = l.program_id
left join grant_awards ga
on l.learner_id=ga.learner_id and ga.award_status = 'disbursed'
group by dp.program_name
order by total_award_amount desc