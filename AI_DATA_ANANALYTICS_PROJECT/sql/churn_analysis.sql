
-- AI Customer Churn Prediction Project
-- SQL Business Analysis
-- Database: churn_analysis

USE churn_analysis;

-- 1. Total customers
SELECT COUNT(*) AS total_customers
FROM telco_customers;

-- 2. Churned and retained customers
SELECT Churn, COUNT(*) AS customer_count
FROM telco_customers
GROUP BY Churn;

-- 3. Churn percentage
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS churn_percentage
FROM telco_customers;

-- 4. Contract-wise churn
SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS churn_percentage
FROM telco_customers
GROUP BY Contract
ORDER BY churn_percentage DESC;

-- 5. Payment method analysis
SELECT
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM telco_customers
GROUP BY PaymentMethod
ORDER BY churned_customers DESC;

-- 6. Average monthly charges
SELECT
    Churn,
    ROUND(AVG(MonthlyCharges), 2) AS average_monthly_charges
FROM telco_customers
GROUP BY Churn;

-- 7. Customer tenure analysis
SELECT
    CASE
        WHEN tenure <= 12 THEN 'New Customers'
        WHEN tenure <= 48 THEN 'Medium-Term Customers'
        ELSE 'Long-Term Customers'
    END AS customer_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM telco_customers
GROUP BY customer_group;

-- 8. Monthly charges of churned customers
SELECT
    ROUND(SUM(MonthlyCharges), 2) AS monthly_charges_of_churned_customers
FROM telco_customers
WHERE Churn = 'Yes';
