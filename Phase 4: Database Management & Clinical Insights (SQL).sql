## PHASE 4: Database Management & SQL Clinical Analysis:

### 🎯 OVERVIEW:
This phase focuses on executing structured Exploratory Data Analysis (EDA), data verification, and advanced clinical risk stratification on the cleaned anesthesia dataset (`1,010 records`) using **MySQL** and **DBeaver** to prepare the data for machine learning optimization.

### ⚙️ KEY TECHNICAL STEPS:
1. **Database & Table Verification:** Checked schema integrity, row counts, and confirmed successful data import into `anesthesia_project_db.cleaned_anesthesia_data`.
2. **Basic Filtering & Profiling:** Filtered patient cohorts based on age, gender, and surgical categories.
3. **Aggregations & Calculations:** Computed average recovery durations (`PACU_Recovery_Time_mins`), BMI distributions, and surgical frequencies using `GROUP BY` and `ROUND()`.
4. **Risk Stratification & Segmentation:** Utilized advanced SQL clauses including `CASE WHEN` for multi-level risk categorization (e.g., elderly and obese patients) and `HAVING` to isolate high-risk ASA grades with prolonged recovery times.

### 🛠️ TECH STACKS & TOOL:
* **Database Management System:** MySQL
* **SQL IDE & Workspace:** DBeaver (Split-screen script and grid execution)
* **Dataset:** `cleaned_anesthesia_data.csv` (Featuring One-Hot Encoded categorical variables)
### ⚙️ MY QUARY CODES:
  -- =====================================================================
-- ## PHASE 4: DATA MANAGEMENT & CLINICAL INSIGHTS:
-- =====================================================================
-- Project Objective: To analyze clinical parameters, patient vitals, and 
-- anesthesia dosages to evaluate recovery times and patient safety metrics.
-- =====================================================================
-- =====================================================================
-- ## STEP 1: DATABASE SETUP & TABLE VERIFICATION
-- =====================================================================
SELECT * FROM anesthesia_project_db.cleaned_anesthesia_data LIMIT 5;
sELECT COUNT(*) AS Total_Patients FROM anesthesia_project_db.cleaned_anesthesia_data;

-- =====================================================================
-- ## STEP 2: BASIC FILTERING & SELECTION
-- =====================================================================

SELECT Patient_ID, Age, Gender_Male, Surgery_Type_C_Section_ObGyn, Surgery_Type_Wound_Debridement
FROM anesthesia_project_db.cleaned_anesthesia_data 
WHERE Age > 50 
LIMIT 5;

-- =====================================================================
-- ## STEP 3: GROUP BY & COUNT QUERIES
-- =====================================================================

SELECT Surgery_Type_Inguinal_Hernia , COUNT(*) AS Total_Surgeries 
FROM anesthesia_project_db.cleaned_anesthesia_data 
GROUP BY Surgery_Type_Inguinal_Hernia 
ORDER BY Total_Surgeries DESC;

SELECT Gender_Male, COUNT(*) AS Count 
FROM anesthesia_project_db.cleaned_anesthesia_data 

-- =====================================================================
-- ## STEP 4: ADVANCED CLINICAL & MACHINE LEARNING SUPPORT QUERIES
-- =====================================================================

SELECT 
    ASA_Grade, 
    COUNT(*) AS Total_Patients,
    ROUND(AVG(PACU_Recovery_Time_mins), 2) AS Avg_Recovery_Time
FROM anesthesia_project_db.cleaned_anesthesia_data
GROUP BY ASA_Grade
ORDER BY ASA_Grade;

SELECT 
    Surgery_Type_C_Section_ObGyn ,
    ROUND(AVG(BMI), 2) AS Avg_BMI,
    ROUND(AVG(PACU_Recovery_Time_mins), 2) AS Avg_Recovery_Time
FROM anesthesia_project_db.cleaned_anesthesia_data
GROUP BY Surgery_Type_C_Section_ObGyn 
ORDER BY Avg_Recovery_Time DESC
LIMIT 5;

SELECT 
    Patient_ID, 
    Age, 
    BMI, 
    PACU_Recovery_Time_mins,
    Urgency_Level
FROM anesthesia_project_db.cleaned_anesthesia_data
WHERE PACU_Recovery_Time_mins > 120
LIMIT 5;
GROUP BY Gender_Male, ;

-- =====================================================================
-- ## STEP 5: AVERAGE & CALCULATIONS
-- =====================================================================

SELECT 
    ROUND(AVG(Age), 2) AS Average_Age, 
    ROUND(AVG(BMI), 2) AS Average_BMI 
FROM anesthesia_project_db.cleaned_anesthesia_data;

SELECT 
    Surgery_Type_ENT_Thyroid, 
    ROUND(AVG(PACU_Recovery_Time_mins), 2) AS Avg_Recovery_Time_Mins 
FROM anesthesia_project_db.cleaned_anesthesia_data 
GROUP BY Surgery_Type_ENT_Thyroid;

-- =====================================================================
-- ## STEP 6: RISK & EMERGENCY CHECK
-- =====================================================================

SELECT Patient_ID, Age, Urgency_Level, Surgery_Type_C_Section_ObGyn  
FROM anesthesia_project_db.cleaned_anesthesia_data 
WHERE Urgency_Level = 'Emergency' 
LIMIT 5;

SELECT Patient_ID, BMI, ASA_Grade, Surgery_Type_Lap_Cholecystectomy 
FROM anesthesia_project_db.cleaned_anesthesia_data 
WHERE BMI > 30 
LIMIT 5;

-- =====================================================================
-- ## STEP 7: HIGH-LEVEL CLINICAL RISK SEGMENTATION (CASE & HAVING)
-- =====================================================================

SELECT 
    Patient_ID,
    Age,
    BMI,
    PACU_Recovery_Time_mins,
    CASE 
        WHEN Age >= 65 AND BMI > 30 THEN 'High Risk (Elderly & Obese)'
        WHEN Age >= 65 OR BMI > 30 THEN 'Moderate Risk'
        ELSE 'Standard Risk'
    END AS Clinical_Risk_Category
FROM anesthesia_project_db.cleaned_anesthesia_data
LIMIT 10;

SELECT 
    ASA_Grade,
    COUNT(*) AS Patient_Count,
    ROUND(AVG(PACU_Recovery_Time_mins), 2) AS Avg_Recovery_Mins
FROM anesthesia_project_db.cleaned_anesthesia_data
GROUP BY ASA_Grade
HAVING AVG(PACU_Recovery_Time_mins) > 90
ORDER BY Avg_Recovery_Mins DESC;

---
👉 **NEXT PHASE 5:** Proceeding to Phase 5: Tableau Visualization & Interactive Clinical Dashboards.....
