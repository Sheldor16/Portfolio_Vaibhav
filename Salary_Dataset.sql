--Describing the datasets

Select *
from SalaryDataset



Select *
From SalaryDataset
where Company_Name = 'IBM'

-- Selecting different types of Job Titles

Select Distinct(Job_Title) as job_titles
From SalaryDataset


-- Count of salaries reported at a job description level

Select Job_Title, COUNT(Salaries_Reported) as count_of_reports
FROM SalaryDataset
GROUP BY Job_Title
ORDER BY count_of_reports DESC


-- Count of Job Openings at a Job description level for all the cities associated

Select Location,
SUM(CASE WHEN Job_Title='Data Scientist' then 1 else 0 end) as Data_Scientist,
SUM(CASE WHEN Job_Title='Data Analyst' then 1 else 0 end) as Data_Analyst,
SUM(CASE WHEN Job_Title='Data Engineer' then 1 else 0 end) as Data_Engineer,
SUM(case when Job_Title='Machine Learning Engineer' then 1 else 0 end) as Machine_Learning_Engineer,
SUM(case when Job_Title='Junior Data Scientist' then 1 else 0 end) as Junior_Data_Scientist,
SUM(case when Job_Title='Senior Machine Learning Engineer' then 1 else 0 end) as Senior_Machine_Learning_Engineer,
SUM(case when Job_Title='Lead Data Scientist' then 1 else 0 end) as Lead_Data_Scientist,
SUM(case when Job_Title='Software Engineer- Machine learning' then 1 else 0 end) as Software_Engineer_Machine_learning,
sum(case when Job_Title='Machine Learning Scientist' then 1 else 0 end) as Machine_Learning_Scientist,
sum(case when Job_Title='Machine Learning Developer' then 1 else 0 end) as Machine_Learning_Developer,
sum(case when Job_Title='Machine Learning Consultant' then 1 else 0 end) as Machine_Learning_Consultant,
sum(case when Job_Title='Machine Learning Software Engineer' then 1 else 0 end) as Machine_Learning_Software_Engineer,
sum(case when Job_Title='Machine Learning Engineer/Data Scientist' then 1 else 0 end) as Machine_Learning_Engineer_Data_Scientist,
sum(case when Job_Title='Machine Learning Data Associate II' then 1 else 0 end) as Machine_Learning_Data_Associate_II,
sum(case when Job_Title='Machine Learning Data Associate I' then 1 else 0 end) as Machine_Learning_Data_Associate_I,
sum(case when Job_Title='Machine Learning Data Associate' then 1 else 0 end) as Machine_Learning_Data_Associate,
sum(case when Job_Title='Machine Learning Data Analyst' then 1 else 0 end) as Machine_Learning_Data_Analyst,
sum(case when Job_Title='Machine Learning Associate' then 1 else 0 end) as Machine_Learning_Associate,
sum(case when Job_Title='Data Scientist - Trainee' then 1 else 0 end) as Data_Scientist_Trainee,
sum(case when Job_Title='Data Science Manager' then 1 else 0 end) as Data_Science_Manager,
sum(case when Job_Title='Data Science Lead' then 1 else 0 end) as Data_Science_Lead,
sum(case when Job_Title='Data Science Associate' then 1 else 0 end) as Data_Science_Associate,
sum(case when Job_Title='Associate Machine Learning Engineer' then 1 else 0 end) as Associate_Machine_Learning_Engineer,
sum(case when Job_Title='Data Science Consultant' then 1 else 0 end) as Data_Science_Consultant,
sum(case when Job_Title='Senior Data Scientist' then 1 else 0 end) as Senior_Data_Scientist
From SalaryDataset
GROUP BY Location


--Company Size Identification
-- small company, medium company, and big company
-- if the company has1 branch - small company
-- if the company has 3 branch - medium company
-- if the company has 5 branches - large company

Select *,
CASE
WHEN a.count_of_branches > 3 THEN 'BIG'
WHEN a.count_of_branches > 1 AND a.count_of_branches <= 3 THEN 'MEDIUM'
WHEN a.count_of_branches = 1 THEN 'SMALL'
ELSE 'NO SIZE'
END as size_of_company

From ( SELECT Company_Name, COUNT(DISTINCT Location) as count_of_branches
	   FROM SalaryDataset
	   where Company_Name !='None'
	   GROUP BY 1,2
	   ORDER BY 2
	   ) a
	   

--List of Companies for analysis

Select distinct Company_Name as Distinct_company
from SalaryDataset


-- Count of branches at a job description level for all the cities associated


SELECT c.Location,
sum(case when c.Company_Name='Mu Sigma' then 1 else 0 end) as Mu_Sigma,
sum(case when c.Company_Name='IBM' then 1 else 0 end) as IBM,
sum(case when c.Company_Name='Tata Consultancy Services' then 1 else 0 end) as Tata_Consultancy_Services,
sum(case when c.Company_Name='Impact Analytics' then 1 else 0 end) as Impact_Analytics,
sum(case when c.Company_Name='Accenture' then 1 else 0 end) as Accenture,
sum(case when c.Company_Name='Infosys' then 1 else 0 end) as Infosys,
sum(case when c.Company_Name='Capgemini' then 1 else 0 end) as Capgemini,
sum(case when c.Company_Name='Cognizant Technology Solutions' then 1 else 0 end) as Cognizant_Technology_Solutions
FROM (SELECT Company_Name, Location, COUNT(DISTINCT Location) as count_of_branches
FROM SalaryDataset
WHERE Company_Name!='None'
GROUP BY Company_Name, COUNT(DISTINCT Location)) c
GROUP BY c.Location


-- Count of salaries report at a branch level for all companies:- code 1 hardcoding all the case statements


select
Location,
sum(case when Company_Name='Mu Sigma' then Salaries_Reported else 0 end) as Mu_Sigma,
sum(case when Company_Name='IBM' then Salaries_Reported else 0 end) as IBM,
sum(case when Company_Name='Tata Consultancy Services' then Salaries_Reported else 0 end) as Tata_Consultancy_Services,
sum(case when Company_Name= 'Impact Analytics' then Salaries_Reported else 0 end) as ImpactAnalytics,
sum(case when Company_Name='Accenture' then Salaries_Reported else 0 end) as Accenture,
sum(case when Company_Name='Infosys' then Salaries_Reported else 0 end) as Infosys,
sum(case when Company_Name= 'Capgemini' then Salaries_Reported else 0 end) as Capgemini,
sum(case when Company_Name='Cognizant Technology Solutions' then Salaries_Reported else 0 end) as CognizantTechnologySolutions,
sum(case when Company_Name='Anheuser-Busch InBev' then Salaries_Reported else 0 end) as AnheuserBuschInBev,
sum(case when Company_Name='Fractal' then Salaries_Reported else 0 end) as Fractal,
sum(case when Company_Name='Embibe' then Salaries_Reported else 0 end) as Embibe,
sum(case when Company_Name='Amazon' then Salaries_Reported else 0 end) as Amazon,
sum(case when Company_Name='Google' then Salaries_Reported else 0 end) as Google,
sum(case when Company_Name='Flipkart' then Salaries_Reported else 0 end) as Flipkart,
sum(case when Company_Name='HP Inc' then Salaries_Reported else 0 end) as HPInc,
sum(case when Company_Name='Wipro' then Salaries_Reported else 0 end) as Wipro,
sum(case when Company_Name='Ericsson-Worldwide' then Salaries_Reported else 0 end) as EricssonWorldwide,
sum(case when Company_Name='MiQ' then Salaries_Reported else 0 end) as MiQ,
sum(case when Company_Name='Deloitte' then Salaries_Reported else 0 end) as Deloitte,
sum(case when Company_Name='Microsoft' then Salaries_Reported else 0 end) as Microsoft,
sum(case when Company_Name='Genpact' then Salaries_Reported else 0 end) as Genpact,
sum(case when Company_Name='Fresher' then Salaries_Reported else 0 end) as Fresher,
sum(case when Company_Name='SociÃ©tÃ© GÃ©nÃ©rale' then Salaries_Reported else 0 end) as SociÃtÃGÃnÃrale,
sum(case when Company_Name='Flutura' then Salaries_Reported else 0 end) as Flutura,
sum(case when Company_Name='Fuzzy Logix' then Salaries_Reported else 0 end) as FuzzyLogix,
sum(case when Company_Name='DXC Technology' then Salaries_Reported else 0 end) as DXC_Technology,
sum(case when Company_Name='Jio' then Salaries_Reported else 0 end) as Jio,
sum(case when Company_Name='Honeywell' then Salaries_Reported else 0 end) as Honeywell,
sum(case when Company_Name='Affine' then Salaries_Reported else 0 end) as Affine,
sum(case when Company_Name='Philips' then Salaries_Reported else 0 end) as Philips
FROM SalaryDataset
WHERE Company_Name!='None'
GROUP by Location

-- Salary packages aross different locations

Select *
From SalaryDataset


Select Location, round(AVG(salary_replace_three),2) as final_avg_salary
FROM
(SELECT *,
REPLACE(salary_replace_two,',','') as salary_replace_three
FROM
(SELECT *,
REPLACE(salary_replace_one, 'â‚','') as salary_replace_two
FROM
(SELECT *,
REPLACE (Salary, '/yr','') as salary_replace_one
FROM SalaryDataset
) a
) b
) c
GROUP BY c.Location

-- FINISH --