-- ============================================================
-- COLORECTAL CANCER SURVIVAL ANALYTICS
-- Complete SQL Analysis Queries
-- Database: healthcare_db
-- Table: colorectal_cancer_prediction
-- ============================================================

-- ============================================================
-- SECTION 1: DATABASE SETUP AND EXPLORATION
-- ============================================================

-- 1.1 Use the database
USE healthcare_db;

-- 1.2 Show all tables
SHOW TABLES;

-- 1.3 Count total records
SELECT COUNT(*) AS total_patients 
FROM colorectal_cancer_prediction;

-- 1.4 View table structure
DESCRIBE colorectal_cancer_prediction;

-- 1.5 Preview first 5 rows
SELECT * 
FROM colorectal_cancer_prediction 
LIMIT 5;


-- ============================================================
-- SECTION 2: DEMOGRAPHIC ANALYSIS
-- ============================================================

-- 2.1 Patient Demographics Summary
SELECT 
    gender, 
    race, 
    COUNT(*) AS total_patients, 
    ROUND(AVG(age), 1) AS avg_age, 
    MIN(age) AS youngest, 
    MAX(age) AS oldest
FROM colorectal_cancer_prediction
GROUP BY gender, race
ORDER BY total_patients DESC;

-- 2.2 Survival by Age Group
SELECT 
    CASE 
        WHEN Age < 50 THEN 'Under 50'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        WHEN Age BETWEEN 60 AND 69 THEN '60-69'
        WHEN Age BETWEEN 70 AND 79 THEN '70-79'
        ELSE '80+'
    END AS age_group,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    SUM(CASE WHEN Survival_Status = 'Survived' THEN 1 ELSE 0 END) AS survivors,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate_percent
FROM colorectal_cancer_prediction
GROUP BY age_group
ORDER BY age_group;

-- 2.3 Survival by Gender and Race
SELECT 
    Gender,
    Race,
    COUNT(*) AS total,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Gender, Race
ORDER BY mortality_rate DESC;


-- ============================================================
-- SECTION 3: CLINICAL ANALYSIS
-- ============================================================

-- 3.1 Stage at Diagnosis Distribution
SELECT 
    Stage_at_Diagnosis,
    COUNT(*) AS patients,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM colorectal_cancer_prediction), 2) AS percentage
FROM colorectal_cancer_prediction
GROUP BY Stage_at_Diagnosis
ORDER BY Stage_at_Diagnosis;

-- 3.2 Survival by Stage at Diagnosis
SELECT 
    Stage_at_Diagnosis,
    COUNT(*) AS total,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Stage_at_Diagnosis
ORDER BY Stage_at_Diagnosis;

-- 3.3 Survival by Stage (Ordered by Mortality Rate)
SELECT 
    Stage_at_Diagnosis,
    COUNT(*) AS total,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Stage_at_Diagnosis
ORDER BY mortality_rate DESC;


-- ============================================================
-- SECTION 4: TREATMENT ANALYSIS
-- ============================================================

-- 4.1 Treatment Effectiveness (Surgery + Chemotherapy)
SELECT 
    Surgery_Received,
    Chemotherapy_Received,
    COUNT(*) AS total,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Survived' THEN 1 ELSE 0 END) / COUNT(*), 2) AS survival_rate
FROM colorectal_cancer_prediction
GROUP BY Surgery_Received, Chemotherapy_Received
ORDER BY survival_rate DESC;

-- 4.2 Comprehensive Treatment Analysis (Stage + Chemotherapy + Surgery)
SELECT 
    Stage_at_Diagnosis,
    Chemotherapy_Received,
    Surgery_Received,
    COUNT(*) AS patients,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Stage_at_Diagnosis, Chemotherapy_Received, Surgery_Received
ORDER BY Stage_at_Diagnosis, mortality_rate;

-- 4.3 Treatment Combination Analysis
SELECT 
    Chemotherapy_Received,
    Radiotherapy_Received,
    Surgery_Received,
    COUNT(*) AS patients,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Chemotherapy_Received, Radiotherapy_Received, Surgery_Received
ORDER BY mortality_rate;


-- ============================================================
-- SECTION 5: GEOGRAPHIC ANALYSIS
-- ============================================================

-- 5.1 Urban vs Rural Outcomes
SELECT 
    Urban_or_Rural,
    COUNT(*) AS total,
    ROUND(AVG(Age), 1) AS avg_age,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Urban_or_Rural;

-- 5.2 Region Analysis
SELECT 
    Region,
    COUNT(*) AS patients,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Region
ORDER BY mortality_rate DESC;


-- ============================================================
-- SECTION 6: SOCIOECONOMIC AND SOCIAL FACTORS
-- ============================================================

-- 6.1 Socioeconomic Status Impact
SELECT 
    Socioeconomic_Status,
    COUNT(*) AS total,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Socioeconomic_Status
ORDER BY mortality_rate DESC;

-- 6.2 Family History Impact
SELECT 
    Family_History,
    COUNT(*) AS total,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Family_History;


-- ============================================================
-- SECTION 7: LIFESTYLE FACTORS
-- ============================================================

-- 7.1 BMI and Survival
SELECT 
    CASE 
        WHEN BMI < 18.5 THEN 'Underweight'
        WHEN BMI BETWEEN 18.5 AND 24.9 THEN 'Normal'
        WHEN BMI BETWEEN 25 AND 29.9 THEN 'Overweight'
        WHEN BMI >= 30 THEN 'Obese'
    END AS bmi_category,
    COUNT(*) AS total,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY bmi_category
ORDER BY mortality_rate DESC;

-- 7.2 Smoking and Survival
SELECT 
    Smoking_Status,
    COUNT(*) AS total,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Smoking_Status
ORDER BY mortality_rate DESC;

-- 7.3 Time to Diagnosis Impact
SELECT 
    Time_to_Diagnosis,
    COUNT(*) AS total,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Time_to_Diagnosis;


-- ============================================================
-- SECTION 8: HIGH-RISK PATIENT PROFILES
-- ============================================================

-- 8.1 High-Risk Patient Profile Query
SELECT 
    Age,
    Gender,
    Stage_at_Diagnosis,
    Tumor_Aggressiveness,
    Family_History,
    Socioeconomic_Status,
    Urban_or_Rural,
    Survival_Status
FROM colorectal_cancer_prediction
WHERE Age > 65 
  AND Stage_at_Diagnosis IN ('III', 'IV')
  AND Family_History = 'Yes'
ORDER BY Age DESC
LIMIT 20;


-- ============================================================
-- END OF SQL QUERY FILE
-- ============================================================
