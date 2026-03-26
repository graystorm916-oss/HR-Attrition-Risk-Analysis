SELECT * FROM attrition_dataset.employees WHERE attrition='Yes';
SELECT SUM(MonthlyIncome) 
AS Total_Income 
FROM attrition_dataset.employees 
WHERE Attrition='Yes';
SELECT ROUND(AVG(MonthlyIncome)) FROM attrition_dataset.employees WHERE Attrition='Yes';
SELECT COUNT(*) AS Total_Leavers,
-- Monthly Revenue drain caused due to leavers
SUM(MonthlyIncome) AS Monthly_Payroll_Drain, 
-- Annual Calculation of suffered loss due to attritions
SUM(MonthlyIncome * 12) AS Annual_Payroll_Drain,
-- Estimated cost of replacement if 50% of salary is required for the process
ROUND(SUM(MonthlyIncome * 12 * .5)) AS Estimated_Replacement_Cost FROM attrition_dataset.employees
WHERE Attrition='Yes';
SELECT JobRole,
SUM(MonthlyIncome) AS Monthly_Revenue_Drain, COUNT(*) 
AS Employee_Count 
FROM attrition_dataset.employees
WHERE Attrition='Yes' GROUP BY JobRole;
SELECT CASE 
-- Segmenting Attrition with distances
WHEN DistanceFromHome <=5 THEN '0-5 KM (Near)' 
WHEN DistanceFromHome <=15 THEN '6-15 KM (Moderate)' 
ELSE ' 15+(Far)'
END AS Distance_Segment, COUNT(*) AS Attrition_Count,
SUM(MonthlyIncome) AS Monthly_Revenue_Drain FROM attrition_dataset.employees 
WHERE Attrition='Yes' GROUP BY Distance_Segment ORDER BY MIN(DistanceFromHome);
SELECT CASE
WHEN JobRole IN ('Sales Executive', 'Sales Representative') THEN 'SalesDepartment'
WHEN JobRole IN ('Research Scientist', 'Research Director') THEN 'R&D'
WHEN JobRole IN ('Healthcare Representative') THEN 'Healthcare'
WHEN JobRole IN ('Manufacturing Director') THEN 'Manufacturing'
WHEN JobRole IN ('Manager') THEN 'Management'
WHEN JobRole IN ('Human Resources') THEN 'HR'
WHEN JobRole IN ('Laboratory Technician') THEN 'Lab'
ELSE 'Other' END AS Functional_Areas, SUM(MonthlyIncome) AS Monthly_Revenue_Drain, COUNT(*) AS Attrition_Count 
FROM attrition_dataset.employees WHERE Attrition='Yes' GROUP BY Functional_Areas ORDER BY Monthly_Revenue_Drain;
SELECT * FROM attrition_dataset.employees;
SELECT CASE
-- Segmenting on the basis of job level
WHEN JobLevel=1 THEN 'Entry Level'
WHEN JobLevel IN ('2', '3') THEN 'Future Leaders'
WHEN JobLevel IN ('4', '5') THEN 'Senior/Managerial'
END AS Position_Segment, COUNT(*) AS Attrition_Count, SUM(MonthlyIncome) 
AS Monthly_Revenue_Drain FROM attrition_dataset.employees 
WHERE attrition='Yes' GROUP BY Position_Segment ORDER BY Monthly_Revenue_Drain DESC;
SELECT COUNT(*) AS Total_Leavers,
SUM(MonthlyIncome) AS Monthly_Revenue_Drain,
SUM(MonthlyIncome * 12) AS Annnual_Revenue_Drain,
round(SUM(MonthlyIncome * 12 *.5))AS Replacement_Cost 
FROM attrition_dataset.employees WHERE Attrition='Yes';
SELECT * FROM employees;
SELECT CASE
WHEN Age < 25 THEN 'Under 25 (Gen Z)'
WHEN Age BETWEEN 25 AND 34 THEN '25-34 (Young)'
WHEN Age BETWEEN 35 AND 44 THEN '35-44 (Mid-Career)'
WHEN Age BETWEEN 45 AND 54 THEN '45-54 ( Senior)'
WHEN Age BETWEEN 55 AND 57 THEN '55-57 (Retirement Track)' 
WHEN Age >= 58 THEN '58+ (Retirement)'
END AS Age_Attrition, CASE WHEN Age >=58 THEN 'NON-Controllable' ELSE 'Controllable' END AS Attrition_Status,
CASE WHEN DistanceFromHome<15 THEN 'Near-Moderate (<15km)'
WHEN DistanceFromHome>=15 THEN 'Far_Commute(15+km)' END AS Distance_Status,
COUNT(*) AS Attrition_Count, SUM(MonthlyIncome) AS Revenue_Drain FROM attrition_dataset.employees
 WHERE Attrition='Yes' 
 GROUP BY Age_Attrition, Attrition_Status, Distance_Status;
 SELECT Gender, CASE
 -- To Identify employees that left due to undervalued
 WHEN Gender IN ('Male', 'Female') AND Overtime='Yes' AND PercentSalaryHike> 15 AND YearsAtCompany>5 THEN 'Dissatisfied_Job_Value'
 -- Finding number of attriton caused due to imbalanced worklife
 WHEN Gender IN ('Male', 'Female') AND WorkLifeBalance<=2 THEN 'Work_Life_Imbalance'
 -- Segmenting employees that has high commute risk
 WHEN Gender IN ('Male', 'Female') AND DistanceFromHome>12 THEN 'Commute_Burnout'
 -- Finding Joblevel and Stock option level mismatch
 WHEN Gender IN ('Male', 'Female') AND (JobLevel<=2 AND StockOptionLevel=0) OR (JobLevel>=3 AND StockOptionLevel=1) THEN 'Poor_Incentive'
 ELSE 'Other_Reasons'
 END AS Attrition_Reasoning_Status, COUNT(*) AS Attrition_Count, SUM(MonthlyIncome) AS Revenue_Drain 
 FROM attrition_dataset.employees WHERE Attrition='Yes' GROUP BY Attrition_Reasoning_Status, Gender
ORDER BY Revenue_Drain DESC;
SELECT CASE WHEN Age BETWEEN 25 AND 34 THEN 'Young_Leavers' ELSE 'Others' END AS Number_of_Young_Attrition,
 COUNT(*) AS Attrition_Count FROM attrition_dataset.employees WHERE Attrition='Yes'  GROUP BY Number_of_Young_Attrition;
 SELECT * FROM employees;
 SELECT DISTINCT(EducationField), COUNT(*) AS Attrition_Count, SUM(MonthlyIncome) 
 AS Revenue_Drain FROM attrition_dataset.employees
 WHERE Attrition='Yes' GROUP BY EducationField;