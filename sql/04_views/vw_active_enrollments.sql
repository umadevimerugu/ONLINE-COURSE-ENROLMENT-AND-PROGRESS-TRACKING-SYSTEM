CREATE OR REPLACE VIEW vw_active_enrollments AS
SELECT 
    u.name AS student_name,
    u.email,
    c.course_name,
    e.date_enrolled,
    DATEDIFF(CURDATE(), e.date_enrolled) AS days_enrolled,
    COUNT(DISTINCT p.module_id) AS modules_started,
    COUNT(DISTINCT CASE WHEN p.completion_status = 'Completed' THEN p.module_id END) AS modules_completed,
    AVG(p.score) AS current_average
FROM Enrollments e
JOIN Users u ON e.user_id = u.id
JOIN Courses c ON e.course_id = c.id
LEFT JOIN Progress p ON e.id = p.enrollment_id
WHERE e.enrollment_status = 'Active'
GROUP BY u.id, u.name, u.email, c.id, c.course_name, e.date_enrolled;
