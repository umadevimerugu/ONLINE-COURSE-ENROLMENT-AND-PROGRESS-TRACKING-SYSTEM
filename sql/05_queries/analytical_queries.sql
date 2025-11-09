-- Q1: Enroll a new student
INSERT INTO Enrollments (user_id, course_id, date_enrolled)
VALUES (3, 5, CURDATE());

-- Q2: Update progress for a module
UPDATE Progress 
SET completion_status = 'Completed', 
    score = 85.00, 
    completion_date = CURDATE()
WHERE enrollment_id = 1 AND module_id = 3;

-- Q3: Get all enrollments for a specific student
SELECT u.name AS student_name, 
       c.course_name, 
       e.date_enrolled, 
       e.enrollment_status
FROM Enrollments e
JOIN Users u ON e.user_id = u.id
JOIN Courses c ON e.course_id = c.id
WHERE u.id = 1;

-- Q4: Get student progress for a specific course
SELECT u.name AS student_name,
       c.course_name,
       m.module_name,
       p.completion_status,
       p.score,
       p.completion_date
FROM Progress p
JOIN Enrollments e ON p.enrollment_id = e.id
JOIN Users u ON e.user_id = u.id
JOIN Courses c ON e.course_id = c.id
JOIN Modules m ON p.module_id = m.id
WHERE e.user_id = 1 AND e.course_id = 1
ORDER BY m.module_order;

-- Q5: Average score per student
SELECT u.name AS student_name,
       AVG(p.score) AS avg_score,
       COUNT(p.id) AS modules_completed
FROM Users u
JOIN Enrollments e ON u.id = e.user_id
JOIN Progress p ON e.id = p.enrollment_id
WHERE p.completion_status = 'Completed' AND p.score IS NOT NULL
GROUP BY u.id, u.name
ORDER BY avg_score DESC;

-- Q6: Course completion rates
SELECT c.course_name,
       COUNT(DISTINCT e.id) AS total_enrollments,
       COUNT(DISTINCT CASE WHEN e.enrollment_status = 'Completed' THEN e.id END) AS completed,
       ROUND((COUNT(DISTINCT CASE WHEN e.enrollment_status = 'Completed' THEN e.id END) * 100.0 / 
              COUNT(DISTINCT e.id)), 2) AS completion_rate_percentage
FROM Courses c
LEFT JOIN Enrollments e ON c.id = e.course_id
GROUP BY c.id, c.course_name;

-- Q7: Top performing students
SELECT u.name AS student_name,
       c.course_name,
       AVG(p.score) AS average_score
FROM Users u
JOIN Enrollments e ON u.id = e.user_id
JOIN Courses c ON e.course_id = c.id
JOIN Progress p ON e.id = p.enrollment_id
WHERE p.score IS NOT NULL
GROUP BY u.id, u.name, c.id, c.course_name
HAVING AVG(p.score) >= 85
ORDER BY average_score DESC;

-- Q8: Instructor workload
SELECT u.name AS instructor_name,
       COUNT(DISTINCT c.id) AS courses_taught,
       COUNT(DISTINCT e.id) AS total_students
FROM Users u
JOIN Courses c ON u.id = c.instructor_id
LEFT JOIN Enrollments e ON c.id = e.course_id
WHERE u.role = 'Instructor'
GROUP BY u.id, u.name;
