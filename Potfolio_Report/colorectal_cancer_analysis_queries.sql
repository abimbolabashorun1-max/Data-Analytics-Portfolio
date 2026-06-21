use healthcare_db;
DROP table if exists colorectal_cancer_prediction;
show tables;
select count(*) from colorectal_cancer_prediction;
describe colorectal_cancer_prediction;
select * from colorectal_cancer_prediction limit 5;
SELECT gender, race, COUNT(*) AS total_patients, ROUND(AVG(age), 1) AS avg_age, MIN(age) AS youngest, MAX(age) AS oldest FROM colorectal_cancer_prediction GROUP BY gender, race ORDER BY total_patients DESC;
SELECT CASE WHEN Age < 50 THEN 'Under 50' WHEN Age BETWEEN 50 AND 59 THEN '50-59' WHEN Age BETWEEN 60 AND 69 THEN '60-69' WHEN Age BETWEEN 70 AND 79 THEN '70-79' ELSE '80+' END AS age_group, COUNT(*) AS total_patients, SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    SUM(CASE WHEN Survival_Status = 'Survived' THEN 1 ELSE 0 END) AS survivors,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate_percent
FROM colorectal_cancer_prediction
GROUP BY age_group
ORDER BY age_group;
SELECT 
    Gender,
    Race,
    COUNT(*) AS total,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Gender, Race
ORDER BY mortality_rate DESC;
SELECT 
    Stage_at_Diagnosis,
    COUNT(*) AS patients,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM colorectal_cancer_prediction), 2) AS percentage
FROM colorectal_cancer_prediction
GROUP BY Stage_at_Diagnosis
ORDER BY Stage_at_Diagnosis;
SELECT 
    Stage_at_Diagnosis,
    COUNT(*) AS total,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Stage_at_Diagnosis
ORDER BY Stage_at_Diagnosis;
SELECT 
    Stage_at_Diagnosis,
    COUNT(*) AS total,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Stage_at_Diagnosis
ORDER BY Stage_at_Diagnosis;
SELECT 
    Surgery_Received,
    Chemotherapy_Received,
    COUNT(*) AS total,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Survived' THEN 1 ELSE 0 END) / COUNT(*), 2) AS survival_rate
FROM colorectal_cancer_prediction
GROUP BY Surgery_Received, Chemotherapy_Received
ORDER BY survival_rate DESC;
SELECT 
    Urban_or_Rural,
    COUNT(*) AS total,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Survived' THEN 1 ELSE 0 END) / COUNT(*), 2) AS survival_rate,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Urban_or_Rural;
SELECT 
    Socioeconomic_Status,
    COUNT(*) AS total,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Survived' THEN 1 ELSE 0 END) / COUNT(*), 2) AS survival_rate,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Socioeconomic_Status
ORDER BY Socioeconomic_Status;
SELECT 
    family_history,
    COUNT(*) AS total,
    ROUND(100.0 * SUM(CASE WHEN mortality = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY family_history;
SELECT 
    Gender,
    Race,
    COUNT(*) AS total_patients,
    ROUND(AVG(Age), 1) AS avg_age,
    MIN(Age) AS youngest,
    MAX(Age) AS oldest
FROM colorectal_cancer_prediction
GROUP BY Gender, Race
ORDER BY total_patients DESC;
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
SELECT 
    Gender,
    Race,
    COUNT(*) AS total,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Gender, Race
ORDER BY mortality_rate DESC;
SELECT 
    Stage_at_Diagnosis,
    COUNT(*) AS patients,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM colorectal_cancer_prediction), 2) AS percentage
FROM colorectal_cancer_prediction
GROUP BY Stage_at_Diagnosis
ORDER BY Stage_at_Diagnosis;
SELECT 
    Stage_at_Diagnosis,
    COUNT(*) AS total,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Stage_at_Diagnosis
ORDER BY mortality_rate DESC;
SELECT 
    Family_History,
    COUNT(*) AS total,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Family_History;
SELECT 
    Urban_or_Rural,
    COUNT(*) AS total,
    ROUND(AVG(Age), 1) AS avg_age,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Urban_or_Rural;
SELECT 
    Region,
    COUNT(*) AS patients,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Region
ORDER BY mortality_rate DESC;
SELECT 
    Socioeconomic_Status,
    COUNT(*) AS total,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Socioeconomic_Status
ORDER BY mortality_rate DESC;
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
SELECT 
    Smoking_Status,
    COUNT(*) AS total,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Smoking_Status
ORDER BY mortality_rate DESC;
SELECT 
    Time_to_Diagnosis,
    COUNT(*) AS total,
    SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) AS deaths,
    ROUND(100.0 * SUM(CASE WHEN Survival_Status = 'Deceased' THEN 1 ELSE 0 END) / COUNT(*), 2) AS mortality_rate
FROM colorectal_cancer_prediction
GROUP BY Time_to_Diagnosis;
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
