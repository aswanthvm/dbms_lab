------------------------------------------------------------
-- SQL Script: Implementation of Set Operators, Nested Queries, and Joins
-- Schema: MovieDatabase
------------------------------------------------------------

-- 1. Create Tables
------------------------------------------------------------

CREATE TABLE ACTOR (
    Act_id VARCHAR(10) PRIMARY KEY,
    Act_Name VARCHAR(50),
    Act_Gender CHAR(1)
);

CREATE TABLE DIRECTOR (
    Dir_id VARCHAR(10) PRIMARY KEY,
    Dir_Name VARCHAR(50),
    Dir_Phone VARCHAR(15)
);

CREATE TABLE MOVIES (
    Mov_id VARCHAR(10) PRIMARY KEY,
    Mov_Title VARCHAR(100),
    Mov_Year NUMBER(4),
    Mov_Lang VARCHAR(20),
    Dir_id VARCHAR(10),
    FOREIGN KEY (Dir_id) REFERENCES DIRECTOR(Dir_id)
);

CREATE TABLE MOVIE_CAST (
    Act_id VARCHAR(10),
    Mov_id VARCHAR(10),
    Role VARCHAR(50),
    FOREIGN KEY (Act_id) REFERENCES ACTOR(Act_id),
    FOREIGN KEY (Mov_id) REFERENCES MOVIES(Mov_id)
);

CREATE TABLE RATING (
    Mov_id VARCHAR(10),
    Rev_Stars NUMBER(2),
    FOREIGN KEY (Mov_id) REFERENCES MOVIES(Mov_id)
);

------------------------------------------------------------
-- 2. Insert Sample Data
------------------------------------------------------------

-- Directors
INSERT INTO DIRECTOR VALUES ('D01', 'Hitchcock', '9876543210');
INSERT INTO DIRECTOR VALUES ('D02', 'Steven Spielberg', '9876501234');
INSERT INTO DIRECTOR VALUES ('D03', 'Christopher Nolan', '9988776655');

-- Actors
INSERT INTO ACTOR VALUES ('A01', 'Tom Hanks', 'M');
INSERT INTO ACTOR VALUES ('A02', 'Leonardo DiCaprio', 'M');
INSERT INTO ACTOR VALUES ('A03', 'Kate Winslet', 'F');
INSERT INTO ACTOR VALUES ('A04', 'Matt Damon', 'M');

-- Movies
INSERT INTO MOVIES VALUES ('M01', 'Psycho', 1960, 'English', 'D01');
INSERT INTO MOVIES VALUES ('M02', 'Rear Window', 1954, 'English', 'D01');
INSERT INTO MOVIES VALUES ('M03', 'Jaws', 1975, 'English', 'D02');
INSERT INTO MOVIES VALUES ('M04', 'E.T.', 1982, 'English', 'D02');
INSERT INTO MOVIES VALUES ('M05', 'Inception', 2010, 'English', 'D03');
INSERT INTO MOVIES VALUES ('M06', 'Tenet', 2020, 'English', 'D03');

-- Movie Casts
INSERT INTO MOVIE_CAST VALUES ('A01', 'M03', 'Lead');
INSERT INTO MOVIE_CAST VALUES ('A01', 'M04', 'Support');
INSERT INTO MOVIE_CAST VALUES ('A02', 'M05', 'Lead');
INSERT INTO MOVIE_CAST VALUES ('A02', 'M06', 'Lead');
INSERT INTO MOVIE_CAST VALUES ('A03', 'M05', 'Support');
INSERT INTO MOVIE_CAST VALUES ('A04', 'M03', 'Support');
INSERT INTO MOVIE_CAST VALUES ('A04', 'M06', 'Support');

-- Ratings
INSERT INTO RATING VALUES ('M01', 4);
INSERT INTO RATING VALUES ('M02', 5);
INSERT INTO RATING VALUES ('M03', 5);
INSERT INTO RATING VALUES ('M04', 4);
INSERT INTO RATING VALUES ('M05', 5);
INSERT INTO RATING VALUES ('M06', 3);

COMMIT;

------------------------------------------------------------
-- 3. SQL Queries
------------------------------------------------------------

-- 1️⃣ List the titles of all movies directed by 'Hitchcock'
SELECT Mov_Title
FROM MOVIES m
JOIN DIRECTOR d ON m.Dir_id = d.Dir_id
WHERE d.Dir_Name = 'Hitchcock';


-- 2️⃣ Find the movie names where one or more actors acted in two or more movies
SELECT DISTINCT m.Mov_Title
FROM MOVIES m
JOIN MOVIE_CAST c ON m.Mov_id = c.Mov_id
WHERE c.Act_id IN (
    SELECT Act_id
    FROM MOVIE_CAST
    GROUP BY Act_id
    HAVING COUNT(DISTINCT Mov_id) >= 2
);


-- 3️⃣ List all actors who acted in a movie before 2000 and also in a movie after 2015 (use JOIN)
SELECT DISTINCT a.Act_Name
FROM ACTOR a
JOIN MOVIE_CAST c1 ON a.Act_id = c1.Act_id
JOIN MOVIES m1 ON c1.Mov_id = m1.Mov_id
JOIN MOVIE_CAST c2 ON a.Act_id = c2.Act_id
JOIN MOVIES m2 ON c2.Mov_id = m2.Mov_id
WHERE m1.Mov_Year < 2000
  AND m2.Mov_Year > 2015;


-- 4️⃣ Find the title of movies and number of stars for each movie that has at least one rating
--     and find the highest number of stars. Sort result by movie title.
SELECT m.Mov_Title, r.Rev_Stars
FROM MOVIES m
JOIN RATING r ON m.Mov_id = r.Mov_id
WHERE r.Rev_Stars IS NOT NULL
ORDER BY m.Mov_Title;

-- Highest rated movie(s)
SELECT Mov_Title, Rev_Stars
FROM MOVIES m
JOIN RATING r ON m.Mov_id = r.Mov_id
WHERE r.Rev_Stars = (SELECT MAX(Rev_Stars) FROM RATING);


-- 5️⃣ Update rating of all movies directed by 'Steven Spielberg' to 5
UPDATE RATING
SET Rev_Stars = 5
WHERE Mov_id IN (
    SELECT Mov_id
    FROM MOVIES
    WHERE Dir_id = (
        SELECT Dir_id FROM DIRECTOR WHERE Dir_Name = 'Steven Spielberg'
    )
);

COMMIT;

------------------------------------------------------------
-- End of Script
------------------------------------------------------------
fibonaci series::
DECLARE
    n NUMBER := 10;
    a NUMBER := 0;
    b NUMBER := 1;
    c NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE(a);
    DBMS_OUTPUT.PUT_LINE(b);
    FOR i IN 3..n LOOP
        c := a + b;
        DBMS_OUTPUT.PUT_LINE(c);
        a := b;
        b := c;
    END LOOP;
END;
/

