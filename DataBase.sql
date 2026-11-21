
CREATE DATABASE UniversityAnalyticsDB;
GO

USE UniversityAnalyticsDB;
GO

-- 1. Departments
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100),
    building VARCHAR(50)
);

-- 2. Degree programs
CREATE TABLE degree_programs (
    program_id INT PRIMARY KEY,
    program_name VARCHAR(100),
    degree_level VARCHAR(30),
    duration_years INT,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 3. Learners
CREATE TABLE learners (
    learner_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    admission_date DATE,
    program_id INT,
    cohort_year INT,
    learner_status VARCHAR(30),
    FOREIGN KEY (program_id) REFERENCES degree_programs(program_id)
);

-- 4. Instructors
CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY,
    instructor_name VARCHAR(100),
    academic_rank VARCHAR(50),
    dept_id INT,
    hire_date DATE,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 5. Modules
CREATE TABLE modules (
    module_id INT PRIMARY KEY,
    module_title VARCHAR(100),
    credit_units INT,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 6. Academic terms
CREATE TABLE academic_terms (
    term_id INT PRIMARY KEY,
    term_name VARCHAR(50),
    academic_year VARCHAR(20),
    start_date DATE,
    end_date DATE
);

-- 7. Class sections
CREATE TABLE class_sections (
    section_id INT PRIMARY KEY,
    module_id INT,
    term_id INT,
    instructor_id INT,
    section_code VARCHAR(20),
    seat_limit INT,
    FOREIGN KEY (module_id) REFERENCES modules(module_id),
    FOREIGN KEY (term_id) REFERENCES academic_terms(term_id),
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);

-- 8. Registrations
CREATE TABLE registrations (
    registration_id INT PRIMARY KEY,
    learner_id INT,
    section_id INT,
    registration_date DATE,
    registration_status VARCHAR(30),
    FOREIGN KEY (learner_id) REFERENCES learners(learner_id),
    FOREIGN KEY (section_id) REFERENCES class_sections(section_id)
);

-- 9. Evaluations
CREATE TABLE evaluations (
    evaluation_id INT PRIMARY KEY,
    section_id INT,
    evaluation_name VARCHAR(100),
    evaluation_type VARCHAR(30),
    max_score DECIMAL(6,2),
    weight_percentage DECIMAL(5,2),
    FOREIGN KEY (section_id) REFERENCES class_sections(section_id)
);

-- 10. Marks
CREATE TABLE marks (
    mark_id INT PRIMARY KEY,
    evaluation_id INT,
    learner_id INT,
    obtained_score DECIMAL(6,2),
    submission_date DATE,
    FOREIGN KEY (evaluation_id) REFERENCES evaluations(evaluation_id),
    FOREIGN KEY (learner_id) REFERENCES learners(learner_id)
);

-- 11. Class sessions
CREATE TABLE class_sessions (
    session_id INT PRIMARY KEY,
    section_id INT,
    session_date DATE,
    topic_covered VARCHAR(150),
    FOREIGN KEY (section_id) REFERENCES class_sections(section_id)
);

-- 12. Attendance logs
CREATE TABLE attendance_logs (
    attendance_id INT PRIMARY KEY,
    session_id INT,
    learner_id INT,
    attendance_status VARCHAR(20),
    FOREIGN KEY (session_id) REFERENCES class_sessions(session_id),
    FOREIGN KEY (learner_id) REFERENCES learners(learner_id)
);

-- 13. Grant awards
CREATE TABLE grant_awards (
    award_id INT PRIMARY KEY,
    learner_id INT,
    award_name VARCHAR(100),
    award_amount DECIMAL(10,2),
    award_date DATE,
    award_status VARCHAR(30),
    FOREIGN KEY (learner_id) REFERENCES learners(learner_id)
);





USE UniversityAnalyticsDB;
GO

SET NOCOUNT ON;

--------------------------------------------------
-- 1. DEPARTMENTS (6 RECORDS)
--------------------------------------------------

INSERT INTO departments VALUES
(101, 'Computer Science', 'Block A'),
(102, 'Data Science', 'Block B'),
(103, 'Information Technology', 'Block C'),
(104, 'Electronics', 'Block D'),
(105, 'Mathematics', 'Block E'),
(106, 'Business Analytics', 'Block F');


--------------------------------------------------
-- 2. DEGREE PROGRAMS (8 RECORDS)
--------------------------------------------------

INSERT INTO degree_programs VALUES
(201, 'BSc Computer Science', 'Undergraduate', 3, 101),
(202, 'BTech Computer Science', 'Undergraduate', 4, 101),
(203, 'BSc Data Science', 'Undergraduate', 3, 102),
(204, 'MSc Data Science', 'Postgraduate', 2, 102),
(205, 'BCA', 'Undergraduate', 3, 103),
(206, 'BTech Electronics', 'Undergraduate', 4, 104),
(207, 'MSc Mathematics', 'Postgraduate', 2, 105),
(208, 'MBA Business Analytics', 'Postgraduate', 2, 106);


--------------------------------------------------
-- 3. INSTRUCTORS (18 RECORDS)
--------------------------------------------------

INSERT INTO instructors VALUES
(401, 'Amit Sharma', 'Professor', 101, '2015-06-10'),
(402, 'Neha Verma', 'Associate Professor', 101, '2018-07-15'),
(403, 'Rahul Mehta', 'Assistant Professor', 101, '2020-01-20'),
(404, 'Priya Nair', 'Professor', 102, '2014-08-12'),
(405, 'Karan Patel', 'Associate Professor', 102, '2019-03-10'),
(406, 'Sneha Rao', 'Assistant Professor', 102, '2021-06-18'),
(407, 'Vikram Das', 'Professor', 103, '2013-05-22'),
(408, 'Anjali Menon', 'Associate Professor', 103, '2017-09-14'),
(409, 'Rohit Kumar', 'Assistant Professor', 103, '2022-02-11'),
(410, 'Deepa Iyer', 'Professor', 104, '2012-04-16'),
(411, 'Arjun Reddy', 'Associate Professor', 104, '2018-11-05'),
(412, 'Meera Shah', 'Assistant Professor', 104, '2021-01-25'),
(413, 'Sanjay Rao', 'Professor', 105, '2011-07-19'),
(414, 'Kavya Joshi', 'Associate Professor', 105, '2016-12-01'),
(415, 'Manoj Gupta', 'Assistant Professor', 105, '2022-08-08'),
(416, 'Divya Thomas', 'Professor', 106, '2014-02-17'),
(417, 'Nitin Kapoor', 'Associate Professor', 106, '2019-10-21'),
(418, 'Asha Pillai', 'Assistant Professor', 106, '2023-01-09');


--------------------------------------------------
-- 4. MODULES (24 RECORDS)
--------------------------------------------------

INSERT INTO modules VALUES
(301, 'Python Programming', 4, 101),
(302, 'Data Structures', 4, 101),
(303, 'Database Management', 4, 101),
(304, 'Operating Systems', 3, 101),
(305, 'Computer Networks', 3, 101),
(306, 'Software Engineering', 3, 101),
(307, 'Statistics', 4, 102),
(308, 'Machine Learning', 4, 102),
(309, 'Deep Learning', 4, 102),
(310, 'Data Visualization', 3, 102),
(311, 'Big Data Analytics', 4, 102),
(312, 'Natural Language Processing', 4, 102),
(313, 'Web Development', 3, 103),
(314, 'Cloud Computing', 4, 103),
(315, 'Cyber Security', 3, 103),
(316, 'Computer Architecture', 3, 104),
(317, 'Digital Electronics', 4, 104),
(318, 'Signal Processing', 3, 104),
(319, 'Linear Algebra', 4, 105),
(320, 'Probability Theory', 4, 105),
(321, 'Calculus', 3, 105),
(322, 'Business Intelligence', 4, 106),
(323, 'Financial Analytics', 3, 106),
(324, 'Predictive Analytics', 4, 106);


--------------------------------------------------
-- 5. ACADEMIC TERMS (6 RECORDS)
--------------------------------------------------

INSERT INTO academic_terms VALUES
(501, 'Semester 1', '2022-2023', '2022-08-01', '2022-12-15'),
(502, 'Semester 2', '2022-2023', '2023-01-10', '2023-05-20'),
(503, 'Semester 1', '2023-2024', '2023-08-01', '2023-12-15'),
(504, 'Semester 2', '2023-2024', '2024-01-10', '2024-05-20'),
(505, 'Semester 1', '2024-2025', '2024-08-01', '2024-12-15'),
(506, 'Semester 2', '2024-2025', '2025-01-10', '2025-05-20');


--------------------------------------------------
-- 6. LEARNERS (48 RECORDS)
--------------------------------------------------

;WITH N AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM N
    WHERE n < 48
),
FirstNames AS (
    SELECT *
    FROM (VALUES
        (1, 'Aarav'), (2, 'Diya'),
        (3, 'Rohan'), (4, 'Ananya'),
        (5, 'Ishaan'), (6, 'Meera'),
        (7, 'Kabir'), (8, 'Saanvi')
    ) v(id, first_name)
),
LastNames AS (
    SELECT *
    FROM (VALUES
        (1, 'Sharma'), (2, 'Reddy'),
        (3, 'Patel'), (4, 'Nair'),
        (5, 'Gupta'), (6, 'Rao')
    ) v(id, last_name)
)
INSERT INTO learners
SELECT
    1000 + N.n,
    F.first_name,
    L.last_name,
    DATEADD(DAY, -(18 * 365 + N.n * 37), CAST('2005-01-01' AS DATE)),
    DATEFROMPARTS(2022 + (N.n % 4), 8, 1),
    201 + ((N.n - 1) % 8),
    2022 + (N.n % 4),
    CASE
        WHEN N.n % 13 = 0 THEN 'Withdrawn'
        WHEN N.n % 11 = 0 THEN 'On Leave'
        WHEN N.n % 7 = 0 THEN 'Graduated'
        ELSE 'Active'
    END
FROM N
JOIN FirstNames F
    ON F.id = ((N.n - 1) % 8) + 1
JOIN LastNames L
    ON L.id = (((N.n - 1) / 8) % 6) + 1
OPTION (MAXRECURSION 100);


--------------------------------------------------
-- 7. CLASS SECTIONS (36 RECORDS)
--------------------------------------------------

;WITH N AS (
    SELECT 0 AS n
    UNION ALL
    SELECT n + 1
    FROM N
    WHERE n < 35
)
INSERT INTO class_sections
SELECT
    10001 + n,
    301 + (n % 24),
    501 + (n % 6),
    401 + (n % 18),
    'SEC' + RIGHT('000' + CAST(n + 1 AS VARCHAR(3)), 3),
    30 + ((n * 7) % 31)
FROM N
OPTION (MAXRECURSION 100);


--------------------------------------------------
-- 8. REGISTRATIONS (192 RECORDS)
--------------------------------------------------

;WITH Slots AS (
    SELECT slot
    FROM (VALUES (1), (2), (3), (4)) v(slot)
),
RegistrationData AS (
    SELECT
        l.learner_id,
        s.slot,
        10001 + (
            ((l.learner_id - 1001) * 5 + s.slot * 7) % 36
        ) AS section_id
    FROM learners l
    CROSS JOIN Slots s
)
INSERT INTO registrations
SELECT
    20001 + ROW_NUMBER() OVER (
        ORDER BY learner_id, slot
    ),
    learner_id,
    section_id,
    DATEADD(
        DAY,
        (learner_id + slot * 3) % 45,
        CAST('2024-08-01' AS DATE)
    ),
    CASE
        WHEN (learner_id + slot) % 17 = 0 THEN 'Dropped'
        WHEN (learner_id + slot) % 5 = 0 THEN 'Completed'
        ELSE 'Enrolled'
    END
FROM RegistrationData;


--------------------------------------------------
-- 9. EVALUATIONS (108 RECORDS)
--------------------------------------------------

;WITH EvaluationTypes AS (
    SELECT *
    FROM (VALUES
        (1, 'Quiz', 20.00, 20.00),
        (2, 'Midterm', 50.00, 30.00),
        (3, 'Final Exam', 100.00, 50.00)
    ) v(slot, evaluation_name, max_score, weight_percentage)
)
INSERT INTO evaluations
SELECT
    30001 + ROW_NUMBER() OVER (
        ORDER BY cs.section_id, et.slot
    ),
    cs.section_id,
    et.evaluation_name,
    et.evaluation_name,
    et.max_score,
    et.weight_percentage
FROM class_sections cs
CROSS JOIN EvaluationTypes et;


--------------------------------------------------
-- 10. MARKS (576 RECORDS)
--------------------------------------------------

;WITH MarkData AS (
    SELECT
        r.learner_id,
        e.evaluation_id,
        e.max_score,
        r.registration_id
    FROM registrations r
    JOIN evaluations e
        ON e.section_id = r.section_id
)
INSERT INTO marks
SELECT
    40001 + ROW_NUMBER() OVER (
        ORDER BY learner_id, evaluation_id
    ),
    evaluation_id,
    learner_id,
    CAST(
        (
            (registration_id * 7 + evaluation_id * 3) % 101
        ) * max_score / 100.0
        AS DECIMAL(6,2)
    ),
    DATEADD(
        DAY,
        evaluation_id % 60,
        CAST('2024-10-01' AS DATE)
    )
FROM MarkData;


--------------------------------------------------
-- 11. CLASS SESSIONS (180 RECORDS)
--------------------------------------------------

;WITH SessionNumbers AS (
    SELECT session_no
    FROM (VALUES (0), (1), (2), (3), (4)) v(session_no)
)
INSERT INTO class_sessions
SELECT
    50001 + ROW_NUMBER() OVER (
        ORDER BY cs.section_id, sn.session_no
    ),
    cs.section_id,
    DATEADD(
        DAY,
        sn.session_no * 7,
        t.start_date
    ),
    CASE sn.session_no
        WHEN 0 THEN 'Introduction'
        WHEN 1 THEN 'Fundamentals'
        WHEN 2 THEN 'Practical Concepts'
        WHEN 3 THEN 'Advanced Topics'
        ELSE 'Revision and Discussion'
    END
FROM class_sections cs
JOIN academic_terms t
    ON t.term_id = cs.term_id
CROSS JOIN SessionNumbers sn;


--------------------------------------------------
-- 12. ATTENDANCE LOGS (960 RECORDS)
--------------------------------------------------

INSERT INTO attendance_logs
SELECT
    60001 + ROW_NUMBER() OVER (
        ORDER BY r.learner_id, s.session_id
    ),
    s.session_id,
    r.learner_id,
    CASE
        WHEN (r.learner_id + s.session_id) % 10 IN (0, 1)
            THEN 'Absent'
        WHEN (r.learner_id + s.session_id) % 10 = 2
            THEN 'Late'
        ELSE 'Present'
    END
FROM registrations r
JOIN class_sessions s
    ON s.section_id = r.section_id;


--------------------------------------------------
-- 13. GRANT AWARDS (24 RECORDS)
--------------------------------------------------

;WITH N AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM N
    WHERE n < 24
)
INSERT INTO grant_awards
SELECT
    70001 + n,
    1001 + ((n * 2) % 48),
    CASE n % 4
        WHEN 0 THEN 'Merit Scholarship'
        WHEN 1 THEN 'Academic Excellence Grant'
        WHEN 2 THEN 'Research Grant'
        ELSE 'Financial Assistance'
    END,
    CASE n % 4
        WHEN 0 THEN 25000
        WHEN 1 THEN 40000
        WHEN 2 THEN 15000
        ELSE 10000
    END,
    DATEADD(DAY, n * 13, CAST('2024-08-01' AS DATE)),
    CASE
        WHEN n % 5 = 0 THEN 'Pending'
        WHEN n % 3 = 0 THEN 'Approved'
        ELSE 'Disbursed'
    END
FROM N
OPTION (MAXRECURSION 100);

GO





-- A few learners have missing birth dates
UPDATE learners
SET date_of_birth = NULL
WHERE learner_id IN (1005, 1017, 1032);

-- Some assessment scores are missing
UPDATE marks
SET obtained_score = NULL,
    submission_date = NULL
WHERE mark_id IN (40010, 40125, 40350, 40575);

-- Some scholarship decisions are pending without a status recorded
UPDATE grant_awards
SET award_status = NULL
WHERE award_id IN (70005, 70012);




SELECT 'departments' AS table_name, COUNT(*) AS total_records FROM departments
UNION ALL
SELECT 'degree_programs', COUNT(*) FROM degree_programs
UNION ALL
SELECT 'learners', COUNT(*) FROM learners
UNION ALL
SELECT 'instructors', COUNT(*) FROM instructors
UNION ALL
SELECT 'modules', COUNT(*) FROM modules
UNION ALL
SELECT 'academic_terms', COUNT(*) FROM academic_terms
UNION ALL
SELECT 'class_sections', COUNT(*) FROM class_sections
UNION ALL
SELECT 'registrations', COUNT(*) FROM registrations
UNION ALL
SELECT 'evaluations', COUNT(*) FROM evaluations
UNION ALL
SELECT 'marks', COUNT(*) FROM marks
UNION ALL
SELECT 'class_sessions', COUNT(*) FROM class_sessions
UNION ALL
SELECT 'attendance_logs', COUNT(*) FROM attendance_logs
UNION ALL
SELECT 'grant_awards', COUNT(*) FROM grant_awards
ORDER BY table_name;
