DELIMITER //
CREATE PROCEDURE UpdateModuleProgress(
    IN p_enrollment_id INT,
    IN p_module_id INT,
    IN p_score DECIMAL(5,2),
    IN p_status VARCHAR(20)
)
BEGIN
    DECLARE progress_exists INT;

    SELECT COUNT(*) INTO progress_exists
    FROM Progress
    WHERE enrollment_id = p_enrollment_id AND module_id = p_module_id;

    IF progress_exists > 0 THEN
        UPDATE Progress
        SET completion_status = p_status,
            score = p_score,
            completion_date = IF(p_status = 'Completed', CURDATE(), completion_date)
        WHERE enrollment_id = p_enrollment_id AND module_id = p_module_id;
    ELSE
        INSERT INTO Progress (enrollment_id, module_id, completion_status, score, start_date)
        VALUES (p_enrollment_id, p_module_id, p_status, p_score, CURDATE());
    END IF;

    SELECT 'Progress updated successfully' AS message;
END //
DELIMITER ;
