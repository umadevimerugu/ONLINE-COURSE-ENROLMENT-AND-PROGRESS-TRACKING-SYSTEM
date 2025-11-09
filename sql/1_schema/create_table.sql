-- Users (Students, Instructors, Admins)
CREATE TABLE Users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role ENUM('Student', 'Instructor', 'Admin') NOT NULL,
    date_registered DATE NOT NULL DEFAULT (CURRENT_DATE),
    status ENUM('Active', 'Inactive') DEFAULT 'Active'
);

-- Courses
CREATE TABLE Courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(200) NOT NULL,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    description TEXT,
    instructor_id INT,
    duration_hours INT,
    max_students INT DEFAULT 100,
    created_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    status ENUM('Active', 'Inactive', 'Completed') DEFAULT 'Active',
    FOREIGN KEY (instructor_id) REFERENCES Users(id) ON DELETE SET NULL
);

-- Modules (Course Content Breakdown)
CREATE TABLE Modules (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    module_name VARCHAR(200) NOT NULL,
    module_order INT NOT NULL,
    duration_hours DECIMAL(5,2),
    description TEXT,
    FOREIGN KEY (course_id) REFERENCES Courses(id) ON DELETE CASCADE,
    UNIQUE KEY unique_module_order (course_id, module_order)
);

-- Enrollments
CREATE TABLE Enrollments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    course_id INT NOT NULL,
    date_enrolled DATE NOT NULL DEFAULT (CURRENT_DATE),
    enrollment_status ENUM('Active', 'Completed', 'Dropped', 'Suspended') DEFAULT 'Active',
    completion_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(id) ON DELETE CASCADE,
    UNIQUE KEY unique_enrollment (user_id, course_id)
);

-- Progress (Module-wise tracking)
CREATE TABLE Progress (
    id INT PRIMARY KEY AUTO_INCREMENT,
    enrollment_id INT NOT NULL,
    module_id INT NOT NULL,
    completion_status ENUM('Not Started', 'In Progress', 'Completed') DEFAULT 'Not Started',
    score DECIMAL(5,2) CHECK (score >= 0 AND score <= 100),
    start_date DATE,
    completion_date DATE,
    attempts INT DEFAULT 1,
    FOREIGN KEY (enrollment_id) REFERENCES Enrollments(id) ON DELETE CASCADE,
    FOREIGN KEY (module_id) REFERENCES Modules(id) ON DELETE CASCADE,
    UNIQUE KEY unique_progress (enrollment_id, module_id)
);

-- Assessments
CREATE TABLE Assessments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    assessment_name VARCHAR(200) NOT NULL,
    assessment_type ENUM('Quiz', 'Assignment', 'Final Exam', 'Project') NOT NULL,
    max_score DECIMAL(5,2) NOT NULL,
    passing_score DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (course_id) REFERENCES Courses(id) ON DELETE CASCADE
);

-- Assessment Results
CREATE TABLE Assessment_Results (
    id INT PRIMARY KEY AUTO_INCREMENT,
    enrollment_id INT NOT NULL,
    assessment_id INT NOT NULL,
    score_obtained DECIMAL(5,2),
    submission_date DATETIME,
    feedback TEXT,
    FOREIGN KEY (enrollment_id) REFERENCES Enrollments(id) ON DELETE CASCADE,
    FOREIGN KEY (assessment_id) REFERENCES Assessments(id) ON DELETE CASCADE
);
