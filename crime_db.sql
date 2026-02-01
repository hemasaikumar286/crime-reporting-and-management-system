CREATE DATABASE IF NOT EXISTS crms_fp;
USE crms_fp;

-- =========================
-- ILF (INTERNAL LOGICAL FILES) – 6
-- =========================

-- 1. USERS FILE
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    role VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. CASES FILE
CREATE TABLE cases (
    case_id INT AUTO_INCREMENT PRIMARY KEY,
    crime_type VARCHAR(100),
    description TEXT,
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. EVIDENCE FILE
CREATE TABLE evidence (
    evidence_id INT AUTO_INCREMENT PRIMARY KEY,
    case_id INT,
    file_path VARCHAR(255),
    description TEXT
);

-- 4. CUSTODY LOG FILE
CREATE TABLE custody_log (
    custody_id INT AUTO_INCREMENT PRIMARY KEY,
    evidence_id INT,
    action VARCHAR(50),
    handler VARCHAR(100),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. CRIME TYPES FILE
CREATE TABLE crime_types (
    crime_type_id INT AUTO_INCREMENT PRIMARY KEY,
    crime_name VARCHAR(100)
);

-- 6. STATIONS FILE
CREATE TABLE stations (
    station_id INT AUTO_INCREMENT PRIMARY KEY,
    station_name VARCHAR(150),
    location VARCHAR(150)
);

-- =========================
-- EIF (EXTERNAL INTERFACE FILES) – 4
-- (Represented as VIEWS / LINKS)
-- =========================

-- 1. SMS GATEWAY (External)
CREATE VIEW eif_sms_gateway AS
SELECT 'SMS_API' AS service_name;

-- 2. EMAIL SERVER (External)
CREATE VIEW eif_email_server AS
SELECT 'SMTP_SERVICE' AS service_name;

-- 3. MAPS / GIS (External)
CREATE VIEW eif_maps_api AS
SELECT 'MAPS_API' AS service_name;

-- 4. NATIONAL ID / GOV REGISTRY (External)
CREATE VIEW eif_national_id AS
SELECT 'GOV_ID_API' AS service_name;

-- =========================
-- EQ (EXTERNAL INQUIRIES) – SAMPLE SELECTS
-- (You will call these from UI / PHP / Java etc.)
-- =========================

-- Citizen Inquiries
SELECT * FROM cases WHERE case_id = 1;                 -- Check Case Status
SELECT * FROM crime_types;                              -- View Crime Types
SELECT * FROM stations;                                 -- View Stations
SELECT status FROM cases WHERE case_id = 2;             -- Track Complaint
SELECT * FROM evidence WHERE case_id = 1;              -- Evidence Status

-- Officer Inquiries
SELECT * FROM cases WHERE status='New';                 -- New Cases
SELECT * FROM cases WHERE status='Closed';              -- Closed Cases
SELECT * FROM custody_log;                              -- Custody History
SELECT * FROM users WHERE role='Officer';               -- Officer List
SELECT COUNT(*) FROM cases;                             -- Workload Count

-- Admin Inquiries
SELECT * FROM users;                                    -- All Users
SELECT * FROM stations;                                 -- Station List
SELECT * FROM crime_types;                              -- Master Data
SELECT COUNT(*) FROM cases WHERE status='Assigned';     -- Assigned Count
SELECT * FROM cases ORDER BY created_at DESC;           -- Recent Cases
