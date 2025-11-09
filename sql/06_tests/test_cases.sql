-- Test 1: Verify enrollment works
CALL EnrollStudent(4, 2);

-- Test 2: Update student progress
CALL UpdateModuleProgress(1, 4, 92.00, 'Completed');

-- Test 3: Generate student report
CALL GetStudentReport(1);

-- Test 4: View student performance
SELECT * FROM vw_student_performance;

-- Test 5: View course analytics
SELECT * FROM vw_course_analytics;

-- Test 6: Check module completion rates
SELECT * FROM vw_module_completion WHERE course_name = 'Database Management Systems';

-- Test 7: View active enrollments
SELECT * FROM vw_active_enrollments;

-- Test 8: Students at risk (low or no scores)
SELECT
    u.name AS student_name,
    c.course_name,
    COUNT(p.id) AS total_modules_attempted,
    COUNT(CASE WHEN p.score IS NOT NULL THEN 1 END) AS modules_with_scores,
    COUNT(CASE WHEN p.score IS NULL THEN 1 END) AS modules_without_scores,
    ROUND(AVG(p.score), 2) AS avg_score,
    CASE
        WHEN AVG(p.score) IS NULL THEN 'No Progress - High Risk'
        WHEN AVG(p.score) < 60 THEN 'Critical Risk'
        WHEN AVG(p.score) BETWEEN 60 AND 74.99 THEN 'At Risk'
        WHEN AVG(p.score) BETWEEN 75 AND 89.99 THEN 'Normal'
        WHEN AVG(p.score) >= 90 THEN 'Excellent'
        ELSE 'Unknown'
    END AS risk_level,
    e.date_enrolled,
    DATEDIFF(CURDATE(), e.date_enrolled) AS days_enrolled
FROM Users u
JOIN Enrollments e ON u.id = e.user_id
JOIN Courses c ON e.course_id = c.id
LEFT JOIN Progress p ON e.id = p.enrollment_id
WHERE e.enrollment_status = 'Active' 
  AND u.role = 'Student'
GROUP BY u.id, u.name, c.id, c.course_name, e.date_enrolled
ORDER BY
    CASE
        WHEN AVG(p.score) IS NULL THEN 1
        WHEN AVG(p.score) < 60 THEN 2
        WHEN AVG(p.score) BETWEEN 60 AND 74.99 THEN 3
        WHEN AVG(p.score) BETWEEN 75 AND 89.99 THEN 4
        WHEN AVG(p.score) >= 90 THEN 5
    END,
    avg_score ASC;
