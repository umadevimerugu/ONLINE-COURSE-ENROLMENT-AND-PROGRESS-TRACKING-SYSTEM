CREATE OR REPLACE VIEW vw_student_performance AS
SELECT 
    u.id AS student_id,
    u.name AS student_name,
    u.email,
    COUNT(DISTINCT e.id) AS total_enrollments,
    COUNT(DISTINCT CASE WHEN e.enrollment_status = 'Completed' THEN e.id END) AS courses_completed,
    AVG(p.score) AS overall_average_score,
    MAX(p.completion_date) AS last_activity_date
FROM Users u
LEFT JOIN Enrollments e ON u.id = e.user_id
LEFT JOIN Progress p ON e.id = p.enrollment_id
WHERE u.role = 'Student'
GROUP BY u.id, u.name, u.email;
