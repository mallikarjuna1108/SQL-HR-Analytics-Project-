-- HOME PAGE
-- Total Number of Employees
select sum(EmployeeCount) As Employee_Count from hranalyticaldata;

-- Total Active Employees
select (sum(EmployeeCount) - (select sum(employeeCount) from hranalyticaldata where Attrition = 'Yes')) As 'Active Employees' 
from hranalyticaldata;

-- Total Female Employees and Female Employees Rate
select sum(EmployeeCount) As 'Female Employees',
round(((select sum(EmployeeCount) from hranalyticaldata where Gender = 'Female')/(select sum(EmployeeCount) from hranalyticaldata))* 100,2) As 'Female Employee Rate' 
from hranalyticaldata 
where Gender = 'Female';

-- Total Male Employees and Male Employees Rate
select sum(EmployeeCount) As 'Male Employees',
round(((select sum(EmployeeCount) from hranalyticaldata where Gender = 'Male')/(select sum(EmployeeCount) from hranalyticaldata))* 100,2) As 'Male Employee Rate' 
from hranalyticaldata 
where Gender = 'Male';

-- Number of Employees Due for Promotion and Percentage of Due for promotion
select sum(EmployeeCount) As 'Due for promotion',round((select sum(EmployeeCount)from hranalyticaldata
where YearsSinceLastPromotion >= 10)/(select sum(EmployeeCount)from hranalyticaldata) * 100,1) As 'Due for Promotion %'
from hranalyticaldata
where YearsSinceLastPromotion >= 10;


-- Number of Employees Not Due for Promotion And Percentage of Not Due
select sum(EmployeeCount) As 'Not Due' ,round((select sum(EmployeeCount)from hranalyticaldata
where YearsSinceLastPromotion <10)/(select sum(EmployeeCount)from hranalyticaldata) * 100,1) As 'Not Due %'
from hranalyticaldata
where YearsSinceLastPromotion < 10;

-- No of Employees by Age Group and Gender
select sum(EmployeeCount) as Employees ,Gender,
case 
	when Age < 25 then 'Under 25'
    when Age >= 25 And Age <= 34 then '25 - 34'
    when Age >= 35 And Age <= 44 then '35 - 44'
    when Age >= 45 And Age <= 54 then '45 - 54'
    Else 'Over 55'
end as age_group
from hranalyticaldata
group by age_group,Gender
order by age_group;

-- Total Employees by Distance Status
select 
case
	when DistanceFromHome < 10 then 'Very Close'
    when DistanceFromHome < 20 then 'Close'
    else 'Very far'
end as Distance_Status,
sum(EmployeeCount) As Employees,Gender
from hranalyticaldata
group by Distance_Status,Gender
order by Distance_Status;

-- Top 5 Employees with Highest Salary
select Emplyeename,sum(MonthlyIncome)
from hranalyticaldata a
join hremployeedata b on a.EmployeeNumber = b.EmployeeNumber
group by Emplyeename
order by sum(MonthlyIncome) desc
limit 5;

-- Total Employees By Performance
select sum(EmployeeCount) as Employee,
Case
	when PerformanceRating = 3 then 'Low'
    else 'High'
end as Performance
from hranalyticaldata
group by Performance;

-- Job Satisfaction Rating table
select JobRole,
sum(case 
	when JobSatsfaction = '1' then EmployeeCount else 0 end
    ) as one,
sum(case 
	when JobSatsfaction = '2' then EmployeeCount else 0 end
    ) as two,
sum(case 
	when JobSatsfaction = '3' then EmployeeCount else 0 end
    ) as three,
sum(case 
	when JobSatsfaction = '4' then EmployeeCount else 0 end
    ) as four
from hranalyticaldata
group by JobRole
order by JobRole desc;

-- ACTION PAGE
-- Total Number of Employees
select sum(EmployeeCount) As Employees from hranalyticaldata;

-- Average Age
select AVG(Age) as avg_age from hranalyticaldata;

-- Total Attrition
select sum(EmployeeCount) AS Total_Attrition 
from hranalyticaldata
where Attrition = 'Yes';

-- Total Female Attrition and Female Attrition Rate
select Gender,sum(EmployeeCount) AS Total_Attrition,
round((select sum(EmployeeCount) from hranalyticaldata
where Attrition = 'Yes' And Gender = 'Female')/(select sum(EmployeeCount) AS Total_Attrition from hranalyticaldata
where Attrition = 'Yes')*100,0) as Female_Attrition_Rate
from hranalyticaldata
where Attrition = 'Yes' And Gender = 'Female';

 -- Total Male Attrition and Male Attrition Rate
select Gender,sum(EmployeeCount) AS Total_Attrition,
round((select sum(EmployeeCount) from hranalyticaldata
where Attrition = 'Yes' And Gender = 'Male')/(select sum(EmployeeCount) AS Total_Attrition from hranalyticaldata
where Attrition = 'Yes')*100,0) as Female_Attrition_Rate
from hranalyticaldata
where Attrition = 'Yes' And Gender = 'Male';

-- Attrition by Department and Gender
select Department,sum(EmployeeCount) as Employees,Gender
from hranalyticaldata
where Attrition = 'Yes'
group by Department,Gender
order by Department;

-- Attrition by Age Group and Gender
select Gender,sum(EmployeeCount) as No_of_attrition,
case 
	when Age < 25 then 'Under 25'
    when Age >= 25 And Age <= 34 then '25 - 34'
    when Age >= 35 And Age <= 44 then '35 - 44'
    when Age >= 45 And Age <= 54 then '45 - 54'
    Else 'Over 55'
end as age_group
from hranalyticaldata
where Attrition = 'Yes'
group by age_group,Gender
order by age_group;

-- Attrition Rate
select sum(EmployeeCount) as total_attrition,round((select sum(EmployeeCount) from hranalyticaldata
where Attrition = 'Yes')/
(select sum(EmployeeCount) from hranalyticaldata)*100,2) as Attrition_rate from hranalyticaldata
where Attrition = 'Yes';

-- Attrition by Employee Satisfaction
select sum(EmployeeCount) as Attrition,
case
	when JobSatsfaction = 1 then 'Very Satisfied'
    when JobSatsfaction = 2 then 'Satisfied'
    when JobSatsfaction = 3 then 'Disatisfied'
    else 'Very Disatisfied'
end as Employee_Satisfaction
from hranalyticaldata
where Attrition = 'Yes'
group by Employee_Satisfaction
order by Attrition desc;

-- Attrition by Education Field
select EducationField,sum(EmployeeCount) As Attrition 
from hranalyticaldata
where Attrition = 'Yes'
group by EducationField
order by Attrition desc;

-- Attrition by Distance
select sum(EmployeeCount) AS Attrition,
case
	when DistanceFromHome  < 10 then 'Very Close'
    when DistanceFromHome  < 20 then 'Close'
    else 'Very far'
end as Distance_status
from hranalyticaldata
where Attrition = 'Yes'
group by Distance_status;

-- DETAILS PAGE
-- Total Number of Employees
select sum(EmployeeCount) from hranalyticaldata;

-- Total Active Employees
select (sum(EmployeeCount) - (select sum(employeeCount) from hranalyticaldata where Attrition = 'Yes')) As 'Active Employees' 
from hranalyticaldata;

-- Total Female Employees and Female Employees Rate
select sum(EmployeeCount) As 'Female Employees',
round(((select sum(EmployeeCount) from hranalyticaldata where Gender = 'Female')/(select sum(EmployeeCount) from hranalyticaldata))* 100,2) As 'Female Employee Rate' 
from hranalyticaldata 
where Gender = 'Female';

-- Total Male Employees and Male Employees Rate
select sum(EmployeeCount) As 'Male Employees',
round(((select sum(EmployeeCount) from hranalyticaldata where Gender = 'Male')/(select sum(EmployeeCount) from hranalyticaldata))* 100,2) As 'Male Employee Rate' 
from hranalyticaldata 
where Gender = 'Male';

-- Total Number of Employees on Retreanchment status
select sum(EmployeeCount),
case
	when YearsAtCompany >= 18 then 'Will be Retreanched'
    else 'On Service'
end as Retreanchment_status
from hranalyticaldata
group by Retreanchment_status;

-- Employee details page
select Emplyeename,Department,EducationField,MonthlyIncome,JobRole,YearsAtCompany as ServiceYear,Age
from hranalyticaldata a
cross join hremployeedata b on 
a.EmployeeNumber = b.EmployeeNumber
order by Emplyeename;









