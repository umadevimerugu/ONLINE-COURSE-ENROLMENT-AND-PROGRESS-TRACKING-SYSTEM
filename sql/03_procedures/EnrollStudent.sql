DELIMITER //
CREATE PROCEDURE EnrollStudent(IN p_user_id INT, IN p_course_id INT)
BEGIN
    DECLARE enrollment_exists INT;
    SELECT COUNT(*) INTO enrollment_exists
    FROM Enrollments
    WHERE user_id = p_user_id AND course_id = p_course_id;

    IF enrollment_exists > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student already enrolled in this course';
    ELSE
        INSERT INTO Enrollments (user_id, course_id, date_enrolled)
        VALUES (p_user_id, p_course_id, CURDATE());
        SELECT 'Enrollment successful' AS message;
    END IF;
END //
DELIMITER ;
