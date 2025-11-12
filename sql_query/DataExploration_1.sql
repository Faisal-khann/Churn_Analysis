USE churn_db;

SELECT COUNT(*) FROM customer_churn;

SELECT * FROM customer_churn;

--Data Exploration – Check Distinct Values
--1. Distribution of Customers by Gender
SELECT 
    Gender, 
    COUNT(Gender) AS TotalCount,
    ROUND(COUNT(Gender) * 100.0 / (SELECT COUNT(*) FROM customer_churn), 2) AS Percentage
FROM customer_churn
GROUP BY Gender;

SELECT TOP 10 *
FROM customer_churn;

--2. Distribution of Customers by Contract Type
SELECT 
    Contract, 
    COUNT(Contract) AS TotalCount,
    COUNT(Contract) * 100.0 / (SELECT COUNT(*) FROM customer_churn) AS Percentage
FROM customer_churn
GROUP BY Contract;

--3. What is the total customer count, total revenue, and revenue contribution percentage by customer status?
SELECT 
	Customer_Status, 
	Count(Customer_Status) as TotalCount, 
	Sum(Total_Revenue) as TotalRevenue,
	Sum(Total_Revenue) / (Select sum(Total_Revenue) from customer_churn) * 100  as RevenuePercentage
from customer_churn
Group by Customer_Status;

--4. What is the total customer count and percentage contribution by state?
SELECT State, 
	COUNT(State) AS TotalCount,
	COUNT(State) * 100.0 / (SELECT COUNT(*) FROM customer_churn) AS percentage
FROM customer_churn
GROUP BY State
ORDER BY percentage DESC;
