DELIMITER //
CREATE PROCEDURE GetStudentReport(IN p_user_id INT)
BEGIN
    SELECT 
        u.name AS student_name,
        c.course_name,
        e.date_enrolled,
        e.enrollment_status,
        COUNT(DISTINCT m.id) AS total_modules,
        COUNT(DISTINCT CASE WHEN p.completion_status = 'Completed' THEN p.module_id END) AS completed_modules,
        AVG(p.score) AS average_score,
        ROUND((COUNT(DISTINCT CASE WHEN p.completion_status = 'Completed' THEN p.module_id END) * 100.0 / 
               COUNT(DISTINCT m.id)), 2) AS progress_percentage
    FROM Users u
    JOIN Enrollments e ON u.id = e.user_id
    JOIN Courses c ON e.course_id = c.id
    LEFT JOIN Modules m ON c.id = m.course_id
    LEFT JOIN Progress p ON e.id = p.enrollment_id AND m.id = p.module_id
    WHERE u.id = p_user_id
    GROUP BY u.id, u.name, c.id, c.course_name, e.date_enrolled, e.enrollment_status;
END //
DELIMITER ;
