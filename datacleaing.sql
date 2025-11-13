Project Title

Project: Social Media and Mental Health Balance — An Analytical Study
Tools Used: SQL, Tableau, Excel
SQL DATA CLEANING PROCESS
1️⃣ Create and Load Data
CREATE TABLE social_media_mental_health (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Gender VARCHAR(20),
    Age_Group VARCHAR(20),
    Income_Group VARCHAR(50),
    Occupation VARCHAR(100),
    Education_Level VARCHAR(100),
    Social_Media_Usage_Hours FLOAT,
    Depression_Level FLOAT,
    Sleep_Duration_Hours FLOAT,
    Productivity_Score FLOAT
);
2️⃣ Check Raw Data Quality
SELECT * FROM social_media_mental_health LIMIT 10;
SELECT COUNT(*) FROM social_media_mental_health;
SELECT COUNT(DISTINCT Gender), COUNT(DISTINCT Occupation) FROM social_media_mental_health;
3️⃣ Handle Missing or Null Values
SELECT 
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS null_gender,
    SUM(CASE WHEN Age_Group IS NULL THEN 1 ELSE 0 END) AS null_age,
    SUM(CASE WHEN Depression_Level IS NULL THEN 1 ELSE 0 END) AS null_depression
FROM social_media_mental_health;

-- Delete or impute missing data 
DELETE FROM social_media_mental_health
WHERE Gender IS NULL OR Depression_Level IS NULL;
4️⃣ Handle Duplicates

-- Identify duplicates
SELECT Gender, Age_Group, Income_Group, COUNT(*) 
FROM social_media_mental_health
GROUP BY Gender, Age_Group, Income_Group
HAVING COUNT(*) > 1;

-- Remove duplicates 
DELETE t1 FROM social_media_mental_health t1
JOIN social_media_mental_health t2 
ON t1.id > t2.id 
AND t1.Gender = t2.Gender 
AND t1.Age_Group = t2.Age_Group
AND t1.Income_Group = t2.Income_Group;
5️⃣ Format and Standardize Data

UPDATE social_media_mental_health
SET Gender = TRIM(LOWER(Gender)),
    Occupation = TRIM(Occupation);
SQL ANALYSIS QUERIES
🔹 Gender and Depression
SELECT Gender, ROUND(AVG(Depression_Level),2) AS avg_depression
FROM social_media_mental_health
GROUP BY Gender
ORDER BY avg_depression DESC;
Insight: On average, females report higher depression levels than males.
🔹 Age and Social Media Usage
SELECT Age_Group, ROUND(AVG(Social_Media_Usage_Hours),2) AS avg_usage
FROM social_media_mental_health
GROUP BY Age_Group
ORDER BY avg_usage DESC;
Insight: Teenagers spend the most time on social media.
🔹 Income and Mental Health
SELECT Income_Group, ROUND(AVG(Depression_Level),2) AS avg_depression
FROM social_media_mental_health
GROUP BY Income_Group
ORDER BY avg_depression DESC;
Insight: The upper-middle income group shows higher depression levels.
🔹 Occupation and Well-being
SELECT Occupation, 
       ROUND(AVG(Sleep_Duration_Hours),2) AS avg_sleep,
       ROUND(AVG(Productivity_Score),2) AS avg_productivity
FROM social_media_mental_health
GROUP BY Occupation
ORDER BY avg_sleep DESC;
Insight: Caregiving and home-based occupations show higher sleep and productivity
🔹 Education and Gender Patterns
SELECT Gender, Education_Level, ROUND(AVG(Depression_Level),2) AS avg_depression
FROM social_media_mental_health
GROUP BY Gender, Education_Level
ORDER BY Gender, avg_depression DESC;
Insight:
Among females, depression peaks at PhD level.
Among males, it’s highest at Master’s level,







