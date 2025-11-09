-- Secondary indexes separated from table DDL
CREATE INDEX idx_role            ON Users(role);
CREATE INDEX idx_email           ON Users(email);

CREATE INDEX idx_instructor      ON Courses(instructor_id);
CREATE INDEX idx_course_status   ON Courses(status);

CREATE INDEX idx_modules_course  ON Modules(course_id);

CREATE INDEX idx_enrollment_user   ON Enrollments(user_id);
CREATE INDEX idx_enrollment_course ON Enrollments(course_id);
CREATE INDEX idx_enrollment_status ON Enrollments(enrollment_status);

CREATE INDEX idx_progress_enrollment ON Progress(enrollment_id);
CREATE INDEX idx_progress_module     ON Progress(module_id);

CREATE INDEX idx_assessment_course   ON Assessments(course_id);

CREATE INDEX idx_ar_enrollment       ON Assessment_Results(enrollment_id);
CREATE INDEX idx_ar_assessment       ON Assessment_Results(assessment_id);
