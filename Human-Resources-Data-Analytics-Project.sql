SHOW DATABASES;

USE HRproject;

SHOW TABLES;

CREATE TABLE HRdata (
   Age INT NOT NULL,
   Attrition VARCHAR(255) NOT NULL,
   BusinessTravel VARCHAR(255) NOT NULL,
   DailyRate INT NOT NULL,
   Department VARCHAR(255) NOT NULL,
   DistanceFromHome INT NOT NULL,
   Education INT NOT NULL,
   EducationField VARCHAR(255) NOT NULL,
   EmployeeCount INT NOT NULL,
   EmployeeNumber INT NOT NULL,
   EnvironmentSatisfaction INT NOT NULL,
   Gender VARCHAR(255) NOT NULL,
   HourlyRate INT NOT NULL,
   JobInvolvement INT NOT NULL,
   JobLevel INT NOT NULL,
   JobRole VARCHAR(255) NOT NULL,
   JobSatisfaction INT NOT NULL,
   MaritalStatus VARCHAR(255) NOT NULL,
   MonthlyIncome INT NOT NULL,
   MonthlyRate INT NOT NULL,
   NumCompaniesWorked INT NOT NULL,
   Over18 VARCHAR(255) NOT NULL,
   OverTime VARCHAR(255) NOT NULL,
   PercentSalaryHike INT NOT NULL,
   PerformanceRating INT NOT NULL,
   RelationshipSatisfaction INT NOT NULL,
   StandardHours INT NOT NULL,
   StockOptionLevel INT NOT NULL,
   TotalWorkingYears INT NOT NULL,
   TrainingTimesLastYear INT NOT NULL,
   WorkLifeBalance INT NOT NULL,
   YearsAtCompany INT NOT NULL,
   YearsInCurrentRole INT NOT NULL,
   YearsSinceLastPromotion INT NOT NULL,
   YearsWithCurrManager INT NOT NULL
);

USE HRproject;

SELECT *
FROM HRdata;

-- Importing data from csv file 

LOAD DATA INFILE '/Users/kiitanolu44/Portfolio/HRdata.csv' INTO TABLE HRdata
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Attrition Calculation for the period

SELECT COUNT(*) AS 'Total Number of Employees',
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Number of Employees Who Left',
       (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)/COUNT(*)) * 100 AS 'Attrition Percentage (%)'
FROM HRdata;

-- Attrition Percentages vs Employees by Job Role

SELECT JobRole, COUNT(*) AS 'Employees',
		(COUNT(*) / (SELECT COUNT(*) FROM HRdata)) * 100 AS 'Percentage of Employees (%)',
		SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Employees Who Left',
		(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS 'Attrition Percentage (%)'
FROM HRdata
GROUP BY JobRole
ORDER BY 'Employees Who Left' DESC;

-- Age Spread vs Attrition

SELECT 
    CASE 
        WHEN Age >= 18 AND Age <= 20 THEN '18 - 20'
        WHEN Age >= 21 AND Age <= 23 THEN '21 - 23'
        WHEN Age >= 24 AND Age <= 26 THEN '24 - 26'
        WHEN Age >= 27 AND Age <= 29 THEN '27 - 29'
        WHEN Age >= 30 AND Age <= 32 THEN '30 - 32'
        WHEN Age >= 33 AND Age <= 35 THEN '33 - 35'
        WHEN Age >= 36 AND Age <= 38 THEN '36 - 38'
        WHEN Age >= 39 AND Age <= 41 THEN '39 - 41'
        WHEN Age >= 42 AND Age <= 44 THEN '42 - 44'
        WHEN Age >= 45 AND Age <= 47 THEN '45 - 47'
        WHEN Age >= 48 AND Age <= 50 THEN '48 - 50'
        WHEN Age >= 51 AND Age <= 53 THEN '51 - 53'
        WHEN Age >= 54 AND Age <= 56 THEN '54 - 56'
        WHEN Age >= 57 THEN '57+'
    END AS Age_Range,
    COUNT(*) AS Employee_Count
FROM HRdata
WHERE Attrition = 'Yes'
GROUP BY Age_Range
ORDER BY Age_Range;

-- High Performers vs Attrition by Job Role

SELECT JobRole,
		COUNT(*) AS Employees,
		SUM(CASE WHEN PerformanceRating = 4 THEN 1 ELSE 0 END) AS 'High Performer',
        SUM(CASE WHEN PerformanceRating = 4 AND Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'High Performer + Left',
        (SUM(CASE WHEN PerformanceRating = 4 AND Attrition = 'Yes' THEN 1 ELSE 0 END)/SUM(CASE WHEN PerformanceRating = 4 THEN 1 ELSE 0 END)) * 100 AS 'Percentage of High Performers who Left (%)'
FROM HRdata
GROUP BY JobRole; 

-- Overtime vs Attrition by Job Role

SELECT JobRole,
		COUNT(*) AS Employees,
		SUM(CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) AS 'Worked Overtime',
		SUM(CASE WHEN OverTime = 'Yes' AND Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Worked Overtime + Left',
		(SUM(CASE WHEN OverTime = 'Yes' AND Attrition = 'Yes' THEN 1 ELSE 0 END)/SUM(CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END)) * 100 AS 'Percentage of Employees who Worked Overtime + Left (%)'
FROM HRdata
GROUP BY JobRole;

-- WorkLifeBalance vs Attrition by Job Role        
  
SELECT JobRole,
		COUNT(*) AS Employees,
		SUM(CASE WHEN WorkLifeBalance <= 2 THEN 1 ELSE 0 END) AS 'Bad Work/Life balance',
        SUM(CASE WHEN WorkLifeBalance <= 2 AND Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Bad Work/Life balance + Left',
        (SUM(CASE WHEN WorkLifeBalance <= 2 AND Attrition = 'Yes' THEN 1 ELSE 0 END)/SUM(CASE WHEN WorkLifeBalance <= 2 THEN 1 ELSE 0 END)) * 100 AS 'Percentage of Employees with Bad Work/Life balance + left (%)'
FROM HRdata
GROUP BY JobRole;

-- Job Involvement Rating vs Attrition by Job Role

SELECT JobRole,
		COUNT(*) AS Employees,
		SUM(CASE WHEN JobInvolvement <= 2 THEN 1 ELSE 0 END) AS 'Bad Job Involvement',
        SUM(CASE WHEN JobInvolvement <= 2 AND Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Bad Job Involvement + Left',
        (SUM(CASE WHEN JobInvolvement <= 2 AND Attrition = 'Yes' THEN 1 ELSE 0 END)/SUM(CASE WHEN JobInvolvement <= 2 THEN 1 ELSE 0 END)) * 100 AS 'Percentage of Bad Job Involvement + Left (%)'
FROM HRdata
GROUP BY JobRole;

-- Environment Satisfaction Rating vs Attrition by Job Role

SELECT JobRole,
		COUNT(*) AS Employees,
		SUM(CASE WHEN EnvironmentSatisfaction <= 2 THEN 1 ELSE 0 END) AS 'Bad Environment Satisfaction',
        SUM(CASE WHEN EnvironmentSatisfaction <= 2 AND Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Bad Environment Satisfaction + Left',
        (SUM(CASE WHEN EnvironmentSatisfaction <= 2 AND Attrition = 'Yes' THEN 1 ELSE 0 END)/SUM(CASE WHEN EnvironmentSatisfaction <= 2 THEN 1 ELSE 0 END)) * 100 AS 'Percentage of Bad Environment Satisfaction + Left (%)'
FROM HRdata
GROUP BY JobRole;

-- Job Satisfaction Rating vs Attrition by Job Role

SELECT JobRole,
		COUNT(*) AS Employees,
		SUM(CASE WHEN JobSatisfaction <= 2 THEN 1 ELSE 0 END) AS 'Bad Job Satisfaction',
        SUM(CASE WHEN JobSatisfaction <= 2 AND Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Bad Job Satisfaction + left',
        (SUM(CASE WHEN JobSatisfaction <= 2 AND Attrition = 'Yes' THEN 1 ELSE 0 END)/SUM(CASE WHEN JobSatisfaction <= 2 THEN 1 ELSE 0 END)) * 100 AS 'Percentage of Employees with Bad Job Satisfaction ratings + left (%)'
FROM HRdata
GROUP BY JobRole;

-- Frequent Travellers vs Attrition by Job Role

SELECT JobRole,
		COUNT(*) AS Employees,
		SUM(CASE WHEN BusinessTravel = 'Travel_Frequently' THEN 1 ELSE 0 END) AS 'Frequent Travellers',
        SUM(CASE WHEN BusinessTravel = 'Travel_Frequently' AND Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Frequent Travellers who left',
        (SUM(CASE WHEN BusinessTravel = 'Travel_Frequently' AND Attrition = 'Yes' THEN 1 ELSE 0 END)/SUM(CASE WHEN BusinessTravel = 'Travel_Frequently' THEN 1 ELSE 0 END)) * 100 AS 'Percentage of Frequent Travellers who left (%)'
FROM HRdata
GROUP BY JobRole;  

-- YearsInCurrentRole vs Attrition by Job Role      
                       
SELECT JobRole,
		COUNT(*) AS Employees,
		SUM(CASE WHEN YearsInCurrentRole > 5 THEN 1 ELSE 0 END) AS 'Long-Term Unpromoted',
        SUM(CASE WHEN YearsInCurrentRole > 5 AND Attrition = 'Yes' THEN 1 ELSE 0 END) AS 'Long-Term Unpromoted + Left',
        (SUM(CASE WHEN YearsInCurrentRole > 5 AND Attrition = 'Yes' THEN 1 ELSE 0 END)/SUM(CASE WHEN YearsInCurrentRole > 5 THEN 1 ELSE 0 END)) * 100 AS 'Percentage of Long-Term Unpromoted + Left (%)'
FROM HRdata
GROUP BY JobRole;

-- HourlyRate vs JobRole

SELECT JobRole, AVG(HourlyRate) AS 'Average Hourly Rate'
FROM HRdata
WHERE Attrition = 'Yes'
GROUP BY JobRole;

-- DistanceFromHome vs JobRole

SELECT JobRole, AVG(DistanceFromHome) AS 'Average Distance From Home'
FROM HRdata
WHERE Attrition = 'Yes'
GROUP BY JobRole;

SELECT JobRole, AVG(DistanceFromHome) AS 'Average Distance From Home'
FROM HRdata
WHERE Attrition = 'No'
GROUP BY JobRole;

-- TrainingTimesLastYear vs JobRole

SELECT JobRole, AVG(TrainingTimesLastYear) AS 'Training Times Last Year'
FROM HRdata
WHERE Attrition = 'Yes'
GROUP BY JobRole;

SELECT JobRole, AVG(TrainingTimesLastYear) AS 'Training Times Last Year'
FROM HRdata
WHERE Attrition = 'No'
GROUP BY JobRole;

-- NumCompaniesWorked vs JobRole

SELECT JobRole, AVG(NumCompaniesWorked) AS 'Average No. of Previous Companies'
FROM HRdata
WHERE Attrition = 'Yes'
GROUP BY JobRole;

SELECT JobRole, AVG(NumCompaniesWorked) AS 'Average No. of Previous Companies'
FROM HRdata
WHERE Attrition = 'No'
GROUP BY JobRole;

-- Education Level vs Attrition

SELECT Education, COUNT(*) AS 'Count of Attrition', 
		(COUNT(*)/(SELECT COUNT(*) FROM HRdata WHERE Attrition = 'Yes')) * 100 AS 'Percentage of total'
FROM HRdata
WHERE Attrition = 'Yes'
GROUP BY Education
ORDER BY Education;

-- Education Level (College & Below) by Job Role

SELECT JobRole, COUNT(*) AS 'Count of Attrition',
		(COUNT(*)/(SELECT COUNT(*) FROM HRdata WHERE Attrition = 'Yes' AND Education <= 2)) * 100 AS 'Percentage of total'
FROM HRdata
WHERE Attrition = 'Yes'
AND Education <= 2
GROUP BY JobRole
ORDER BY JobRole;

-- Education Level (Master's & Above) by Job Role

SELECT JobRole, COUNT(*) AS 'Count of Attrition',
		(COUNT(*)/(SELECT COUNT(*) FROM HRdata WHERE Attrition = 'Yes' AND Education >= 4)) * 100 AS 'Percentage of total'
FROM HRdata
WHERE Attrition = 'Yes'
AND Education >= 4
GROUP BY JobRole
ORDER BY JobRole;

-- Education Fields vs Attrition

SELECT EducationField, COUNT(*) AS 'Count of Attrition',
		(COUNT(*)/(SELECT COUNT(*) FROM HRdata WHERE Attrition = 'Yes')) * 100 AS 'Percentage of total'
FROM HRdata 
WHERE Attrition = 'Yes'
GROUP BY EducationField;

-- Attrtion vs Business Travel by Job Role

SELECT JobRole, COUNT(*) AS Attrition_Count
FROM HRdata
WHERE BusinessTravel = 'Non-Travel' AND Attrition = 'Yes'
GROUP BY JobRole
ORDER BY JobRole DESC;

SELECT JobRole, COUNT(*) AS Attrition_Count
FROM HRdata
WHERE BusinessTravel = 'Travel_Frequently' AND Attrition = 'Yes'
GROUP BY JobRole
ORDER BY JobRole DESC;
