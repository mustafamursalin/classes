-- =============================================
-- STEP 1: Drop tables in reverse order (to avoid foreign key errors)
-- =============================================
DROP TABLE IF EXISTS billings;
DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS admissions;
DROP TABLE IF EXISTS doctors;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS patients;
DROP TABLE IF EXISTS departments;

-- =============================================
-- STEP 2: Create Parent Tables (No Foreign Keys)
-- =============================================

-- 1. Departments Table (Parent of Doctors)
CREATE TABLE departments (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Patients Table (Parent of Appointments, Billings, Admissions)
CREATE TABLE patients (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT(3),
    gender VARCHAR(10),
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Rooms Table (Parent of Admissions)
CREATE TABLE rooms (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    room_no VARCHAR(20) NOT NULL,
    room_type VARCHAR(50) DEFAULT 'General',
    status VARCHAR(20) DEFAULT 'Available'
);

-- =============================================
-- STEP 3: Create Child Tables (With Foreign Keys)
-- =============================================

-- 4. Doctors Table (Child of Departments)
CREATE TABLE doctors (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    dept_id INT(11),
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (dept_id) REFERENCES departments(id) ON DELETE SET NULL
);

-- 5. Admissions Table (Child of Patients and Rooms)
CREATE TABLE admissions (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    patient_id INT(11) NOT NULL,
    room_id INT(11) NOT NULL,
    admit_date DATE NOT NULL,
    discharge_date DATE NULL,
    status VARCHAR(20) DEFAULT 'Admitted',
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE
);

-- 6. Appointments Table (Child of Patients and Doctors)
CREATE TABLE appointments (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    patient_id INT(11) NOT NULL,
    doctor_id INT(11) NOT NULL,
    appointment_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Scheduled',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE
);

-- 7. Billings Table (Child of Patients and Admissions - Optional)
CREATE TABLE billings (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    patient_id INT(11) NOT NULL,
    admission_id INT(11) NULL,
    amount DECIMAL(10,2) NOT NULL,
    bill_date DATE NOT NULL,
    description TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (admission_id) REFERENCES admissions(id) ON DELETE SET NULL
);















-- =========================================
-- Dummy Data
-- =========================================

-- =========================================
-- ১. Department এ ডেটা
-- =========================================
INSERT INTO departments (name, description) VALUES
('Cardiology', 'Heart related diseases'),
('Neurology', 'Brain and nervous system');

-- =========================================
-- ২. Doctors এ ডেটা (dept_id 1 বা 2)
-- =========================================
INSERT INTO doctors (dept_id, name, specialization, phone, email) VALUES
(1, 'Dr. Shahidul Rahman', 'Cardiologist', '01711111111', 'dr.rahman@hospital.com'),
(2, 'Dr. Nazma Akhtar', 'Neurologist', '01722222222', 'dr.akhtar@hospital.com');

-- =========================================
-- ৩. Patients এ ডেটা (রোগী)
-- =========================================
INSERT INTO patients (name, age, gender, phone, address) VALUES
('Md. Rahim Mia', 45, 'Male', '01911111111', 'Dhaka, Bangladesh'),
('Ms. Salma Khatun', 30, 'Female', '01922222222', 'Chittagong, Bangladesh'),
('Md. Kamal Hossain', 60, 'Male', '01933333333', 'Rajshahi, Bangladesh');

-- =========================================
-- ৪. Appointments এ ডেটা (অ্যাপয়েন্টমেন্ট)
-- =========================================
INSERT INTO appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2026-06-18', 'Scheduled'),
(2, 2, '2026-06-19', 'Completed'),
(1, 2, '2026-06-20', 'Scheduled');

-- =========================================
-- ৫. Billings এ ডেটা (admission_id NULL রাখলাম, কারণ OPD বিল)
-- =========================================
INSERT INTO billings (patient_id, admission_id, amount, bill_date, description) VALUES
(1, NULL, 5000.00, '2026-06-18', 'OPD Consultation & ECG'),
(2, NULL, 12000.00, '2026-06-19', 'MRI Scan & Medicine'),
(3, NULL, 2500.00, '2026-06-17', 'General Checkup');