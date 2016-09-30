##_SQL_
- useful for creating and querying relational databases.
- relational database - stores data in table, querying: SQL is most popular to create tables, select data, badges, etc.
- Invented at IBM in the 1970s, first version was called SEQUEL - structured english query language. Acronym was later changed to SQL.

- Creating a table and inserting data:

CREATE TABLE groceries (id INTEGER PRIMARY KEY, name TEXT, quantity INTEGER );
INSERT INTO groceries VALUES (1, "Bananas", 4);
INSERT INTO groceries VALUES (2, "Peanut Butter", 1);
INSERT INTO groceries VALUES (3, "dark chocolate bars", 2);
SELECT * FROM groceries;

- Querying the table:

SELECT column FROM table name
SELECT * FROM groceries WHERE aisle > 5 ORDER BY aisle;

- Aggregating data: max, minimum, sum, average

SELECT aisle, SUM(quantity) FROM groceries GROUP BY aisle;

- AND/OR Complex Queries:

To add only some of the column names you can use a different syntax:
id INTEGER PRIMARY KEY AUTOINCREMENT
INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ("biking", 30, 100, 110);
SELECT * FROM exercise_logs WHERE calories >50 ORDER BY calories;
conditions
AND   has precedence over OR in the same database
SELECT * FROM exercise_logs WHERE calories >50  AND minutes < 30;
 OR
SELECT * FROM exercise_logs WHERE calories >50 OR heart_rate >100;

- Querying IN Subqueries:

IN will check to see if particular value is in list of values. IN ("","",etc)
SELECT title FROM songs WHERE artist IN (SELECT name FROM artists WHERE genre = "Pop");
NOT IN - opposite
Subquery - always up to date with table. Replace whats in parenthesis with (SELECT type FROM drs_favorites); Always pull based on whatever is in doctor's table and keep it up to date.
Only select favorites that doc recommended for cardiovascular. IN (SELECT type FROM drs_favorites WHERE reason = "Increases cardiovascular health"); - this will only return exact matches.
LIKE - replace = with LIKE (... WHERE reason LIKE "%cardiovascular%;");

- Restricting group results with HAVING:

SELECT type, SUM(calories) FROM exercise_logs GROUP BY type
  HAVING total_calories > 150;
create a new colume by using AS - SUM(calories) AS total_calories
HAVING applies conditions to the grouped values.
SELECT type, AVG(calories) AS avg_calories FROM exercise_logs
  GROUP BY type
  HAVING avg_calories > 10
  ;
SELECT type FROM exercise_logs GROUP BY type HAVING COUNT() >= 2;

- Who issues SQL queries?:
EXAMPLE - exercise app
1. Software Engineers - build the backend (server-side logic) and the frontend (HTML, CSS, JS that renders data and forms). They would need to know how to do any queries needed by the frontend. If a user logged on and saw how much exercise they did that day, the engineer would have to figure out how to do a SELECT filtered by date and user, how to insert data an update it.
2. Data Scientists - analyze data, trying to learn more about users, coming up with suggestions about how to help them exercise more. They need a deep understanding to SELECT to analyze what percentage of users were more likely to do more exercise if they started in the morning using CASE and GROUP BY.
3. Project Managers - Decision makers at a company, the people who look at dada talk to users look at the market, and try to understand how to improve a product to get more users, make users happier, or make more money. Look at usage stats to understand what parts of product are being used the most, etc.

- Calculating results with CASE:  
```
SELECT COUNT(*) FROM exercise_logs WHERE heart_rate > 220 -30;
SELECT COUNT(*) FROM exercise_logs WHERE heart_rate > ROUND(.50 times (220-30))
AND heart_rate <= ROUND(.90 times (220-30))
```
similar to IF
```
SELECT type, heart_rate, (COUNT(*))
  CASE
    WHEN heart_rate > 220-30 THEN "above max"
    WHEN heart_rate > ROUND(.90 * (220-30))THEN "above target"
    ELSE "below target"
    END as "hr_zone"
    FROM exercise_logs
    GROUP BY hr_zone;
    ```

- Splitting data into related tables:
Preferable to make sure that a particular column of dad is only stored in a single location so there are less places to update. Make sure you use unique identifiers like a student id instead of name in case there are multiples students with the same name.

- JOINing related tables:
Cross Join -
by putting both table names after FROM.
Inner Join - implicit inner join:
SELECT * FROM student_grades, students,
  WHERE student_grades.studen_id = students.id;
Explicit inner join:
SELECT students.first_name, students.last_name, students.email, students.test, students.grade FROM students  
  JOIN student_grades
  ON students.id = student_grades.student_id;
  WHERE grade > 90

- Joining related tables with left outer joins:
SELECT student.first_name, students.last_name, students_projects.title  
  FROM students
  LEFT OUTER JOIN students_projects
  ON students.id = students_projects.student_id;
LEFT tells SQL to retain everything from left table students, and OUTER states to return value even if there's nothing in that table.

- Joining tables to themselves with self-joins:

We've created a table with all the 'Harry Potter' movies, with a sequel_id column that matches the id of the sequel for each movie. Issue a SELECT that will show the title of each movie next to its sequel's title (or NULL if it doesn't have a sequel).

```SELECT prequels.title, sequels.title
    FROM movies prequels
    LEFT OUTER JOIN movies sequels
    ON sequels.id = prequels.sequel_id;
    ```

- Combing multiple joins:
SELECT a.title, b.title FROM project_pairs
  JOIN students_projects a
  ON project_pairs.project1_id = a.id
  JOIN students_projects b
  ON project_pairs.project2_id = b.id;
