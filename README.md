# Introduction to Churn Analysis

<em>Analyzing customer behavior and churn patterns to enhance retention strategies and business performance using SQL, Python, and Power BI..</em>

---

## 📌 Table of Contents
- [Overview](#Overview)
- [Target Audience](#who-is-the-target-audience)
- [Project Goals](#Project-Goals)
- [Tools & Technologies](#Tools-&-Technologies)
- [ETL Process in SQL Server](#ETL-Process-in-SQL-Server)
- [Dashboard Preview](#Dashboard-Preview)
- [Key Outcomes](#Key-Outcomes)
- [Author & Contact](#author--contact)
  
---

## Overview
<p>In today’s competitive business environment, retaining customers is crucial for long-term success. Churn analysis is a key technique used to understand and reduce this customer attrition. It involves examining customer data to identify patterns and reasons behind customer departures. By using advanced data analytics and machine learning, businesses can predict which customers are at risk of leaving and understand the factors driving their decisions. This knowledge allows companies to take proactive steps to improve customer satisfaction and loyalty.</p>

---

## Who is the Target Audience
<p>Although this project focuses on churn analysis for a telecom firm, the techniques and insights are applicable across various industries. From retail and finance to healthcare and beyond, any business that values customer retention can benefit from churn analysis. We will explore the methods, tools, and best practices for reducing churn and improving customer loyalty, transforming data into actionable insights for sustained success.</p>

---

## Project Goals
<em>Create an entire ETL process in a database & a Power BI dashboard to utilize the Customer Data and achieve below goals:</em>

  1. Analyze Customer Data at below levels:
     - Demographic
     - Geographic
     - Payment & Account Info
     - Services
  2. Study Churner Profile & Identify Areas for Implementing Marketing Campaigns
  3. Identify a Method to Predict Future Churners
  4. Metrics Required:
     - Total Customers
     - Total Churn
     - Churn Rate
     - New Joiners

---

## Tools & Technologies

| Tool        | Purpose                          |
|-------------|----------------------------------|
| **Python**  | Data analysis & scripting        |             
| **SQL**     | Data querying & ETL              |
| **Power BI Desktop**| Dashboard creation       |
| **Power BI Service**| Dashboard deployment     |
| **Machine learning** | Random Forest Algorithm |

---

## 🧩 ETL Process in SQL Server

The first step in the **Customer Churn Analysis** project is to perform the **ETL (Extract, Transform, Load)** process using **Microsoft SQL Server**.  
This allows efficient handling of large customer datasets, ensures data integrity, and prepares the foundation for analysis in **Power BI** and **Python**.

---

- ###  Setup and Installation
  
  **Install SQL Server Management Studio (SSMS)**  
  Microsoft provides a GUI interface to connect to SQL Server and execute SQL queries.  
  Download the latest version of SSMS from the official documentation:

  🔗 [Download SQL Server Management Studio (SSMS)](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)

---

- ### Creating the Database

  After installing SSMS and connecting to your SQL Server instance, create a new database named **db_Churn**:
  
  ```sql
  CREATE DATABASE Churn_db;
  ```
  
  <em> <h3>Import CSV into SQL Server (Staging Table)</h3></em>
    <p><strong>Use the Import Wizard in SSMS:</strong></p>
      <em>Right-click on the database → Tasks → Import Data → Flat File Source → Browse CSV File</em>

---


- ### Data Exploration – Distinct Value Checks
    <em>Use the following queries to check categorical distributions and understand your data composition:</em>
  
  ```sql
  
  USE churn_db;
  
  -- 1: Distribution of Customers by Gender
  SELECT 
      Gender, 
      COUNT(Gender) AS TotalCount,
      ROUND(COUNT(Gender) * 100.0 / (SELECT COUNT(*) FROM customer_churn), 2) AS Percentage
  FROM customer_churn
  GROUP BY Gender;
  
  --2: Distribution of Customers by Contract Type
  SELECT 
      Contract, 
      COUNT(Contract) AS TotalCount,
      COUNT(Contract) * 100.0 / (SELECT COUNT(*) FROM customer_churn) AS Percentage
  FROM customer_churn
  GROUP BY Contract;
  
  --3: What is the total customer count, total revenue, and revenue contribution percentage by customer status?
  SELECT 
  	Customer_Status, 
  	Count(Customer_Status) as TotalCount, 
  	Sum(Total_Revenue) as TotalRevenue,
  	Sum(Total_Revenue) / (Select sum(Total_Revenue) from customer_churn) * 100  as RevenuePercentage
  from customer_churn
  Group by Customer_Status;
  
  --4: What is the total customer count and percentage contribution by state?
  SELECT State, 
  	COUNT(State) AS TotalCount,
  	COUNT(State) * 100.0 / (SELECT COUNT(*) FROM customer_churn) AS percentage
  FROM customer_churn
  GROUP BY State
  ORDER BY percentage DESC;
  
  ```
- ### Data Exploration – Check Nulls
  <em>To assess data quality and identify missing values across all columns:</em>

  ```sql
  SELECT 
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_Null_Count,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_Null_Count,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_Null_Count,
    SUM(CASE WHEN Married IS NULL THEN 1 ELSE 0 END) AS Married_Null_Count,
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_Null_Count,
    SUM(CASE WHEN Number_of_Referrals IS NULL THEN 1 ELSE 0 END) AS Number_of_Referrals_Null_Count,
    SUM(CASE WHEN Tenure_in_Months IS NULL THEN 1 ELSE 0 END) AS Tenure_in_Months_Null_Count,
    SUM(CASE WHEN Value_Deal IS NULL THEN 1 ELSE 0 END) AS Value_Deal_Null_Count,
    SUM(CASE WHEN Phone_Service IS NULL THEN 1 ELSE 0 END) AS Phone_Service_Null_Count,
    SUM(CASE WHEN Multiple_Lines IS NULL THEN 1 ELSE 0 END) AS Multiple_Lines_Null_Count,
    SUM(CASE WHEN Internet_Service IS NULL THEN 1 ELSE 0 END) AS Internet_Service_Null_Count,
    SUM(CASE WHEN Internet_Type IS NULL THEN 1 ELSE 0 END) AS Internet_Type_Null_Count,
    SUM(CASE WHEN Online_Security IS NULL THEN 1 ELSE 0 END) AS Online_Security_Null_Count,
    SUM(CASE WHEN Online_Backup IS NULL THEN 1 ELSE 0 END) AS Online_Backup_Null_Count,
    SUM(CASE WHEN Device_Protection_Plan IS NULL THEN 1 ELSE 0 END) AS Device_Protection_Plan_Null_Count,
    SUM(CASE WHEN Premium_Support IS NULL THEN 1 ELSE 0 END) AS Premium_Support_Null_Count,
    SUM(CASE WHEN Streaming_TV IS NULL THEN 1 ELSE 0 END) AS Streaming_TV_Null_Count,
    SUM(CASE WHEN Streaming_Movies IS NULL THEN 1 ELSE 0 END) AS Streaming_Movies_Null_Count,
    SUM(CASE WHEN Streaming_Music IS NULL THEN 1 ELSE 0 END) AS Streaming_Music_Null_Count,
    SUM(CASE WHEN Unlimited_Data IS NULL THEN 1 ELSE 0 END) AS Unlimited_Data_Null_Count,
    SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS Contract_Null_Count,
    SUM(CASE WHEN Paperless_Billing IS NULL THEN 1 ELSE 0 END) AS Paperless_Billing_Null_Count,
    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Payment_Method_Null_Count,
    SUM(CASE WHEN Monthly_Charge IS NULL THEN 1 ELSE 0 END) AS Monthly_Charge_Null_Count,
    SUM(CASE WHEN Total_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Charges_Null_Count,
    SUM(CASE WHEN Total_Refunds IS NULL THEN 1 ELSE 0 END) AS Total_Refunds_Null_Count,
    SUM(CASE WHEN Total_Extra_Data_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Extra_Data_Charges_Null_Count,
    SUM(CASE WHEN Total_Long_Distance_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Long_Distance_Charges_Null_Count,
    SUM(CASE WHEN Total_Revenue IS NULL THEN 1 ELSE 0 END) AS Total_Revenue_Null_Count,
    SUM(CASE WHEN Customer_Status IS NULL THEN 1 ELSE 0 END) AS Customer_Status_Null_Count,
    SUM(CASE WHEN Churn_Category IS NULL THEN 1 ELSE 0 END) AS Churn_Category_Null_Count,
    SUM(CASE WHEN Churn_Reason IS NULL THEN 1 ELSE 0 END) AS Churn_Reason_Null_Count
  FROM customer_churn; 
  ```
- ## Data Cleaning and Loading into Production Table
  <em>Replace NULL values with appropriate defaults and move the cleaned data into the production table prod_Churn:</em>

  ```sql
  SELECT 
    Customer_ID,
    Gender,
    Age,
    Married,
    State,
    Number_of_Referrals,
    Tenure_in_Months,
    ISNULL(Value_Deal, 'None') AS Value_Deal,
    Phone_Service,
    ISNULL(Multiple_Lines, 'No') AS Multiple_Lines,
    Internet_Service,
    ISNULL(Internet_Type, 'None') AS Internet_Type,
    ISNULL(Online_Security, 'No') AS Online_Security,
    ISNULL(Online_Backup, 'No') AS Online_Backup,
    ISNULL(Device_Protection_Plan, 'No') AS Device_Protection_Plan,
    ISNULL(Premium_Support, 'No') AS Premium_Support,
    ISNULL(Streaming_TV, 'No') AS Streaming_TV,
    ISNULL(Streaming_Movies, 'No') AS Streaming_Movies,
    ISNULL(Streaming_Music, 'No') AS Streaming_Music,
    ISNULL(Unlimited_Data, 'No') AS Unlimited_Data,
    Contract,
    Paperless_Billing,
    Payment_Method,
    Monthly_Charge,
    Total_Charges,
    Total_Refunds,
    Total_Extra_Data_Charges,
    Total_Long_Distance_Charges,
    Total_Revenue,
    Customer_Status,
    ISNULL(Churn_Category, 'Others') AS Churn_Category,
    ISNULL(Churn_Reason, 'Others') AS Churn_Reason
  INTO [Churn_db].[dbo].[prod_Churn]
  FROM [Churn_db].[dbo].[customer_churn];

  ```

- ### Create SQL Views for Power BI Integration
  <em>Create separate views for customers who Stayed/Churned and those who Joined recently:</em>
  ```sql
  -- Create View for Power BI
  -- 1️ View for Churned and Stayed customers
  IF OBJECT_ID('dbo.vw_ChurnData', 'V') IS NOT NULL
      DROP VIEW dbo.vw_ChurnData;
  GO
  
  CREATE VIEW dbo.vw_ChurnData AS
  SELECT *
  FROM dbo.prod_churn
  WHERE Customer_Status IN ('Churned', 'Stayed');
  GO
  
  -- 2️ View for Joined customers
  IF OBJECT_ID('dbo.vw_JoinData', 'V') IS NOT NULL
      DROP VIEW dbo.vw_JoinData;
  GO
  
  CREATE VIEW dbo.vw_JoinData AS
  SELECT *
  FROM dbo.prod_churn
  WHERE Customer_Status = 'Joined';
  GO
  ```
  <h4>Outcomes</h4>
  <em> The ETL process prepares a clean, production-ready dataset in SQL Server that can be directly connected to Power BI for visualization and analysis, or exported to Python for advanced modeling.</em>
---

    
