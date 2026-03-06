-- ## SQL Names

-- Save a script containing the query you used to answer each question.

-- 1. How many rows are in the names table? 1,957,046 rows
SELECT COUNT(*)
FROM names;


-- 2. How many total registered people appear in the dataset? (ANSWER: 351,653,025 total registered people)
SELECT sum(num_registered) AS total_registered
FROM names;


-- 3. Which name had the most appearances in a single year in the dataset? (ANSWER: The most appearances was Linda in 1947 with 99,689)
SELECT *
FROM names
ORDER BY num_registered DESC
LIMIT 1;
-- Will learn later it may have issues with ties, and we'll use rank


-- 4. What range of years are included? (ANSWER: 1880 to 2018)
SELECT min(year) AS min_year, max(year) AS max_year
FROM names;


-- 5. What year has the largest number of registrations? (ANSWER: 1957 has the largest number of registrations at 4,200,022)
SELECT year, sum(num_registered) AS total_registered
FROM names
GROUP BY year
ORDER BY total_registered DESC
LIMIT 1;


-- 6. How many different (distinct) names are contained in the dataset? (ANSWER: There are 98,400 distinct names)
SELECT COUNT(DISTINCT name) AS num_names
FROM names;


-- 7. Are there more males or more females registered? (ANSWER: There are more males registered (177,573,793) than females (174,079,232))
SELECT gender, SUM(num_registered) AS total_registered
FROM names
GROUP BY gender;


-- 8. What are the most popular male and female names overall (i.e., the most total registrations)? (ANSWER: Female=Mary(4,125,675); Male=James(5,164,280))
SELECT name, SUM(num_registered) AS total_registered
FROM names
WHERE gender='F'
GROUP BY name
ORDER BY total_registered DESC
LIMIT 1;

SELECT name, SUM(num_registered) AS total_registered
FROM names
WHERE gender='M'
GROUP BY name
ORDER BY total_registered DESC
LIMIT 1;

SELECT DISTINCT ON (gender) gender, name, SUM(num_registered) as total_registered   --DISTINCT ON picks TOP name per gender
FROM names
GROUP BY name, gender
ORDER BY gender ,total_registered DESC


-- 9. What are the most popular boy and girl names of the first decade of the 2000s (2000 - 2009)? (ANSWER: Female=Emily(223,690); Male=Jacob(273,844))
SELECT name, SUM(num_registered) AS total_registered
FROM names
WHERE year BETWEEN 2000 AND 2009
AND gender='F'
GROUP BY name
ORDER BY total_registered DESC
LIMIT 1;

SELECT name, SUM(num_registered) AS total_registered
FROM names
WHERE year BETWEEN 2000 AND 2009
AND gender='M'
GROUP BY name
ORDER BY total_registered DESC
LIMIT 1;

SELECT DISTINCT ON (gender) gender, name, SUM(num_registered) as total_registered   --DISTINCT ON picks TOP name per gender
FROM names
WHERE year BETWEEN 2000 AND 2009
GROUP BY name, gender
ORDER BY gender ,total_registered DESC

-- 10. Which year had the most variety in names (i.e. had the most distinct names)? (ANSWER: 2008 had the most distinct names with 32,518)
SELECT year, COUNT(DISTINCT name) AS num_names
FROM names
GROUP BY year
ORDER BY num_names DESC
LIMIT 1;


-- 11. What is the most popular name for a girl that starts with the letter X? (ANSWER: Ximena is the most popular girl name that starts with 'X' with 26,145)
SELECT name, SUM(num_registered) as total_registered
FROM names
WHERE gender='F'
AND name LIKE 'X%'
GROUP BY name
ORDER BY total_registered DESC
LIMIT 1;


-- 12. Write a query to find all (distinct) names that start with a 'Q' but whose second letter is not 'u'. (ANSWER: 46 results)
SELECT DISTINCT name
FROM names
WHERE name LIKE 'Q%'
AND name NOT LIKE '_u%'
ORDER BY name;
-- ILIKE (case insensitive)

SELECT DISTINCT name
FROM names 
WHERE name LIKE 'Q%'
 AND substring(name, 2, 1) <> 'u';


-- 13. Which is the more popular spelling between "Stephen" and "Steven"? Use a single query to answer this question. (ANSWER: Steven=1,286,951 : Stephen=860,972)
SELECT name, SUM(num_registered) AS total_registered
FROM names
WHERE name = 'Stephen'
OR name = 'Steven'
GROUP BY name;

SELECT name, SUM(num_registered)
FROM names
WHERE name IN ('Stephen', 'Steven')
GROUP BY name
ORDER BY SUM(num_registered) DESC;


-- 14. Find all names that are "unisex" - that is all names that have been used both for boys and for girls. (ANSWER: 10,773 unixex names)
SELECT name
FROM names
GROUP BY name
HAVING COUNT(DISTINCT gender) > 1
ORDER BY name;


-- 15. Find all names that have made an appearance in every single year since 1880. (ANSWER: 921 rows)
SELECT name
FROM names
GROUP BY name
HAVING COUNT(DISTINCT year) > 2018 - 1880
ORDER BY name;


-- 16. Find all names that have only appeared in one year. (ANSWER: 21,123 rows)
SELECT name
FROM names
GROUP BY name
HAVING COUNT(DISTINCT year) = 1
ORDER BY name;


-- 17. Find all names that only appeared in the 1950s. (ANSWER: 661 rows)
SELECT name, MIN(year) AS min_year, MAX(year) AS max_year
FROM names
GROUP BY name
HAVING MIN(year) >= 1950 AND MAX(year) <= 1959
ORDER BY name;


-- 18. Find all names that made their first appearance in the 2010s. (ANSWER: 11,270 rows)
SELECT name, MIN(year) AS min_year
FROM names
GROUP BY name
HAVING MIN(year) BETWEEN 2010 AND 2019
ORDER BY min_year, name;


-- 19. Find the names that have not be used in the longest. (ANSWER: Roll 1881 145yrs and Zilpah 1881 145yrs)
SELECT name, MAX(year) AS max_year, (2026 - MAX(year)) AS years_old
FROM names
GROUP BY name
ORDER BY years_old DESC, name
LIMIT 5;


-- 20. Come up with a question that you would like to answer using this dataset. Then write a query to answer this question.
-- Is 'Shannon' more commonly male or female? (ANSWER: 'Shannon' is more commonly Female)
SELECT name, gender, sum(num_registered)
FROM names
WHERE name = 'Shannon'
GROUP BY name, gender;

-- What are other spellings of 'Shannon'? (ANSWER: 32 rows)
SELECT DISTINCT name
FROM names
WHERE name LIKE 'Sh_n%n'
ORDER BY name;
