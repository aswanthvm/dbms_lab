------------------------------------------------------------
-- SQL Script: Implementation of Aggregate Functions
------------------------------------------------------------

-- 1. Create Tables
------------------------------------------------------------

CREATE TABLE Faculty (
    FacultyCode VARCHAR(10) PRIMARY KEY,
    FacultyName VARCHAR(50)
);

CREATE TABLE Subject (
    SubjectCode VARCHAR(10) PRIMARY KEY,
    SubjectName VARCHAR(50),
    MaxMark NUMBER(3),
    FacultyCode VARCHAR(10),
    FOREIGN KEY (FacultyCode) REFERENCES Faculty(FacultyCode)
);

CREATE TABLE Student (
    StudentCode VARCHAR(10) PRIMARY KEY,
    StudentName VARCHAR(50),
    DOB DATE,
    StudentsBranch VARCHAR(10),
    AdmissionDate DATE
);

CREATE TABLE M_Mark (
    StudentCode VARCHAR(10),
    SubjectCode VARCHAR(10),
    Mark NUMBER(3),
    FOREIGN KEY (StudentCode) REFERENCES Student(StudentCode),
    FOREIGN KEY (SubjectCode) REFERENCES Subject(SubjectCode)
);

------------------------------------------------------------
-- 2. Insert Sample Data
------------------------------------------------------------

-- Faculty Table
INSERT INTO Faculty VALUES ('F01', 'Dr. Ram');
INSERT INTO Faculty VALUES ('F02', 'Dr. Meena');
INSERT INTO Faculty VALUES ('F03', 'Prof. Arjun');

-- Subject Table
INSERT INTO Subject VALUES ('S01', 'Mathematics', 100, 'F01');
INSERT INTO Subject VALUES ('S02', 'Physics', 100, 'F02');
INSERT INTO Subject VALUES ('S03', 'Chemistry', 100, 'F02');
INSERT INTO Subject VALUES ('S04', 'Computer Science', 100, 'F03');

-- Student Table
INSERT INTO Student VALUES ('ST01', 'John', TO_DATE('2003-01-10','YYYY-MM-DD'), 'CS', TO_DATE('2021-07-01','YYYY-MM-DD'));
INSERT INTO Student VALUES ('ST02', 'Priya', TO_DATE('2002-12-05','YYYY-MM-DD'), 'EE', TO_DATE('2021-07-01','YYYY-MM-DD'));
INSERT INTO Student VALUES ('ST03', 'Kiran', TO_DATE('2003-03-20','YYYY-MM-DD'), 'ME', TO_DATE('2021-07-01','YYYY-MM-DD'));
INSERT INTO Student VALUES ('ST04', 'Asha', TO_DATE('2003-06-15','YYYY-MM-DD'), 'CS', TO_DATE('2021-07-01','YYYY-MM-DD'));

-- Marks Table
INSERT INTO M_Mark VALUES ('ST01', 'S01', 85);
INSERT INTO M_Mark VALUES ('ST01', 'S02', 75);
INSERT INTO M_Mark VALUES ('ST01', 'S03', 55);
INSERT INTO M_Mark VALUES ('ST01', 'S04', 95);

INSERT INTO M_Mark VALUES ('ST02', 'S01', 35);
INSERT INTO M_Mark VALUES ('ST02', 'S02', 45);
INSERT INTO M_Mark VALUES ('ST02', 'S03', 60);
INSERT INTO M_Mark VALUES ('ST02', 'S04', 50);

INSERT INTO M_Mark VALUES ('ST03', 'S01', 65);
INSERT INTO M_Mark VALUES ('ST03', 'S02', 30);
INSERT INTO M_Mark VALUES ('ST03', 'S03', 40);
INSERT INTO M_Mark VALUES ('ST03', 'S04', 80);

INSERT INTO M_Mark VALUES ('ST04', 'S01', 90);
INSERT INTO M_Mark VALUES ('ST04', 'S02', 92);
INSERT INTO M_Mark VALUES ('ST04', 'S03', 88);
INSERT INTO M_Mark VALUES ('ST04', 'S04', 78);

COMMIT;

------------------------------------------------------------
-- 3. Queries
------------------------------------------------------------

-- a) Display the number of faculties
SELECT COUNT(*) AS Number_of_Faculties
FROM Faculty;


-- b) Display the total mark for each student
SELECT s.StudentCode, s.StudentName, SUM(m.Mark) AS Total_Mark
FROM Student s
JOIN M_Mark m ON s.StudentCode = m.StudentCode
GROUP BY s.StudentCode, s.StudentName;


-- c) Display the subject and average mark for each subject
SELECT sub.SubjectName, AVG(m.Mark) AS Average_Mark
FROM Subject sub
JOIN M_Mark m ON sub.SubjectCode = m.SubjectCode
GROUP BY sub.SubjectName;


-- d) Display the name of subjects for which at least one student got below 40%
SELECT DISTINCT sub.SubjectName
FROM Subject sub
JOIN M_Mark m ON sub.SubjectCode = m.SubjectCode
WHERE (m.Mark / sub.MaxMark) * 100 < 40;


-- e) Display the name, subject, and percentage of marks of students who got below 40%
SELECT s.StudentName, sub.SubjectName,
       ROUND((m.Mark / sub.MaxMark) * 100, 2) AS Percentage
FROM Student s
JOIN M_Mark m ON s.StudentCode = m.StudentCode
JOIN Subject sub ON m.SubjectCode = sub.SubjectCode
WHERE (m.Mark / sub.MaxMark) * 100 < 40;


-- f) Display the faculties and allotted subjects for each faculty
SELECT f.FacultyName, sub.SubjectName
FROM Faculty f
JOIN Subject sub ON f.FacultyCode = sub.FacultyCode
ORDER BY f.FacultyName;


-- g) Display the name of faculties who take more than one subject
SELECT f.FacultyName, COUNT(sub.SubjectCode) AS No_of_Subjects
FROM Faculty f
JOIN Subject sub ON f.FacultyCode = sub.FacultyCode
GROUP BY f.FacultyName
HAVING COUNT(sub.SubjectCode) > 1;


-- h) Display name, subject, mark, and % of mark in ascending order of mark
SELECT s.StudentName, sub.SubjectName, m.Mark,
       ROUND((m.Mark / sub.MaxMark) * 100, 2) AS Percentage
FROM Student s
JOIN M_Mark m ON s.StudentCode = m.StudentCode
JOIN Subject sub ON m.SubjectCode = sub.SubjectCode
ORDER BY m.Mark ASC;

------------------------------------------------------------
-- End of Script
------------------------------------------------------------
