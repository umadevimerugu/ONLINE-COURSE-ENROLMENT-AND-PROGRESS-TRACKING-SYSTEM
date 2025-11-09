CREATE OR REPLACE VIEW vw_module_completion AS
SELECT 
    c.course_name,
    m.module_name,
    m.module_order,
    COUNT(DISTINCT e.id) AS enrolled_students,
    COUNT(DISTINCT CASE WHEN p.completion_status = 'Completed' THEN p.enrollment_id END) AS students_completed,
    ROUND((COUNT(DISTINCT CASE WHEN p.completion_status = 'Completed' THEN p.enrollment_id END) * 100.0 / 
           COUNT(DISTINCT e.id)), 2) AS completion_rate,
    AVG(p.score) AS average_score
FROM Modules m
JOIN Courses c ON m.course_id = c.id
LEFT JOIN Enrollments e ON c.id = e.course_id
LEFT JOIN Progress p ON m.id = p.module_id AND e.id = p.enrollment_id
GROUP BY c.id, c.course_name, m.id, m.module_name, m.module_order
ORDER BY c.course_name, m.module_order;
