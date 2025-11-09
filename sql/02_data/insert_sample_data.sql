-- Insert Users
INSERT INTO Users (name, email, role, date_registered) VALUES
('Alice Johnson', 'alice.j@email.com', 'Student', '2024-09-01'),
('Bob Smith', 'bob.s@email.com', 'Student', '2024-09-05'),
('Charlie Davis', 'charlie.d@email.com', 'Student', '2024-09-10'),
('Diana Kumar', 'diana.k@email.com', 'Student', '2024-09-12'),
('Eve Martinez', 'eve.m@email.com', 'Student', '2024-09-15'),
('Dr. Frank Wilson', 'frank.w@email.com', 'Instructor', '2024-08-01'),
('Dr. Grace Lee', 'grace.l@email.com', 'Instructor', '2024-08-01'),
('Admin User', 'admin@email.com', 'Admin', '2024-08-01');

-- Insert Courses
INSERT INTO Courses (course_name, course_code, description, instructor_id, duration_hours, max_students) VALUES
('Introduction to Python Programming', 'PY101', 'Learn Python basics and programming fundamentals', 6, 40, 50),
('Web Development with HTML/CSS', 'WD101', 'Master front-end web development', 6, 35, 40),
('Database Management Systems', 'DB101', 'Learn SQL and database design principles', 7, 45, 45),
('Data Structures and Algorithms', 'DSA101', 'Core concepts of DSA', 7, 50, 40),
('Machine Learning Basics', 'ML101', 'Introduction to ML concepts', 6, 60, 30);

-- Insert Modules
INSERT INTO Modules (course_id, module_name, module_order, duration_hours) VALUES
(1, 'Python Basics', 1, 10),
(1, 'Control Flow and Functions', 2, 10),
(1, 'Data Structures in Python', 3, 10),
(1, 'Object-Oriented Programming', 4, 10),
(2, 'HTML Fundamentals', 1, 12),
(2, 'CSS Styling', 2, 12),
(2, 'Responsive Design', 3, 11),
(3, 'Introduction to Databases', 1, 10),
(3, 'SQL Queries', 2, 15),
(3, 'Database Design', 3, 12),
(3, 'Advanced SQL', 4, 8);

-- Insert Enrollments
INSERT INTO Enrollments (user_id, course_id, date_enrolled, enrollment_status) VALUES
(1, 1, '2024-09-10', 'Active'),
(1, 3, '2024-09-15', 'Active'),
(2, 1, '2024-09-12', 'Active'),
(2, 2, '2024-09-20', 'Active'),
(3, 3, '2024-09-18', 'Completed'),
(3, 4, '2024-10-01', 'Active'),
(4, 1, '2024-09-16', 'Active'),
(4, 5, '2024-09-25', 'Active'),
(5, 2, '2024-09-22', 'Active'),
(5, 3, '2024-09-28', 'Active');

-- Insert Progress
INSERT INTO Progress (enrollment_id, module_id, completion_status, score, start_date, completion_date, attempts) VALUES
(1, 1, 'Completed', 95.00, '2024-09-10', '2024-09-15', 1),
(1, 2, 'Completed', 88.00, '2024-09-16', '2024-09-22', 1),
(1, 3, 'In Progress', 75.00, '2024-09-23', NULL, 1),
(1, 4, 'Not Started', NULL, NULL, NULL, 0),
(2, 8, 'Completed', 92.00, '2024-09-15', '2024-09-25', 1),
(2, 9, 'Completed', 85.00, '2024-09-26', '2024-10-05', 1),
(2, 10, 'In Progress', NULL, '2024-10-06', NULL, 1),
(3, 1, 'Completed', 78.00, '2024-09-12', '2024-09-18', 2),
(3, 2, 'Completed', 82.00, '2024-09-19', '2024-09-25', 1),
(3, 3, 'Completed', 90.00, '2024-09-26', '2024-10-01', 1),
(5, 8, 'Completed', 88.00, '2024-09-28', '2024-10-08', 1),
(5, 9, 'In Progress', NULL, '2024-10-09', NULL, 1);

-- Insert Assessments
INSERT INTO Assessments (course_id, assessment_name, assessment_type, max_score, passing_score) VALUES
(1, 'Python Basics Quiz', 'Quiz', 100, 60),
(1, 'Final Python Project', 'Project', 100, 70),
(3, 'SQL Mid-term Exam', 'Final Exam', 100, 65),
(3, 'Database Design Assignment', 'Assignment', 100, 60);

-- Insert Assessment Results
INSERT INTO Assessment_Results (enrollment_id, assessment_id, score_obtained, submission_date) VALUES
(1, 1, 95.00, '2024-09-22 14:30:00'),
(3, 1, 78.00, '2024-09-25 16:45:00'),
(2, 3, 92.00, '2024-10-05 10:20:00'),
(5, 3, 88.00, '2024-10-08 11:15:00');
