CREATE OR REPLACE VIEW vw_course_analytics AS
SELECT 
    c.id AS course_id,
    c.course_name,
    c.course_code,
    u.name AS instructor_name,
    COUNT(DISTINCT e.id) AS total_students,
    COUNT(DISTINCT CASE WHEN e.enrollment_status = 'Active' THEN e.id END) AS active_students,
    COUNT(DISTINCT CASE WHEN e.enrollment_status = 'Completed' THEN e.id END) AS students_completed,
    AVG(p.score) AS average_course_score
FROM Courses c
LEFT JOIN Users u ON c.instructor_id = u.id
LEFT JOIN Enrollments e ON c.id = e.course_id
LEFT JOIN Progress p ON e.id = p.enrollment_id
GROUP BY c.id, c.course_name, c.course_code, u.name;
