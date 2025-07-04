-- CREATING A TABLE 

CREATE TABLE retail_sales_db
       ( transactions_id INT PRIMARY KEY
	     sale_date DATE
		 sale_time TIME
		 customer_id INT
		 gender VARCHAR(15)
		 age INT
		 category VARCHAR(15)
		 quantiy INT
		 price_per_unit FLOAT
		 cogs FLOAT
		 total_sale FLOAT
	   );


SELECT * 
FROM retail_sales_db;

SELECT COUNT(*)
FROM retail_sales_db;


-- DEALING WITH NULL VALUES IN DATA

SELECT * FROM retail_sales_db
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales_db
WHERE sale_date IS NULL;

SELECT * FROM retail_sales_db
WHERE sale_time IS NULL;

SELECT * FROM retail_sales_db
WHERE customer_id IS NULL;

SELECT * FROM retail_sales_db
WHERE gender IS NULL;

SELECT * FROM retail_sales_db
WHERE age IS NULL;

SELECT * FROM retail_sales_db
WHERE category IS NULL;

SELECT * FROM retail_sales_db
WHERE quantiy IS NULL;

SELECT * FROM retail_sales_db
WHERE price_per_unit IS NULL;

SELECT * FROM retail_sales_db
WHERE cogs IS NULL;

SELECT * FROM retail_sales_db
WHERE total_sale IS NULL;


-- OR IT CAN ALSO BE DONE AS :

SELECT * FROM retail_sales_db
WHERE 
      transactions_id IS NULL
	  OR
	  sale_date IS NULL
	  OR
	  sale_time IS NULL
	  OR 
	  customer_id IS NULL
	  OR
	  gender IS NULL
	  OR
	  age IS NULL
	  OR
	  category IS NULL
	  OR
	  quantiy IS NULL
	  OR
	  price_per_unit IS NULL
	  OR
	  cogs IS NULL
	  OR 
	  total_sale IS NULL
;

--DATA CLEANING

DELETE FROM retail_sales_db
WHERE 
      transactions_id IS NULL
	  OR
	  sale_date IS NULL
	  OR
	  sale_time IS NULL
	  OR 
	  customer_id IS NULL
	  OR
	  gender IS NULL
	  OR
	  age IS NULL
	  OR
	  category IS NULL
	  OR
	  quantiy IS NULL
	  OR
	  price_per_unit IS NULL
	  OR
	  cogs IS NULL
	  OR 
	  total_sale IS NULL
;

-- DATA EXPLORATION

-- How many sales we have 
SELECT COUNT(*) AS TOTAL_SALE FROM retail_sales_db;

-- How many  distinct customers we have
SELECT COUNT(DISTINCT customer_id) AS TOTAL_CUSTOMERS FROM retail_sales_db;

-- What distinct categories do we have
SELECT DISTINCT category FROM retail_sales_db;


-- DATA ANALYSIS AND BUSINESS KEY PROBLEMS 


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * 
FROM 
    retail_sales_db
WHERE 
    sale_date = '2022-11-05'
;

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
SELECT
    transactions_id,
    sale_date,
    sale_time,
    customer_id,
    gender,
    age,
    category,
    quantiy,
    price_per_unit,
    cogs,
    total_sale
FROM
    retail_sales_db
WHERE
    category = 'Clothing'
    AND quantiy > 3
    AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT
    category,
    SUM(total_sale) AS total_sales_by_category
FROM
    retail_sales_db
GROUP BY
    category
ORDER BY
    total_sales_by_category DESC;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
      AVG(age) AS average_age_of_customers 
FROM 
      retail_sales_db
WHERE
      category = 'Beauty'
;

-- 0.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * 
FROM 
     retail_sales_db
WHERE 
     total_sale > 1000;


-- Q. 6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT
    gender,
    category,
    COUNT(transactions_id) AS total_transactions
FROM
    retail_sales_db
GROUP BY
    gender,
    category
ORDER BY
    gender,
    total_transactions DESC;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.

SELECT
    TO_CHAR(sale_date, 'YYYY-MM') AS sale_month,
    AVG(total_sale) AS average_monthly_sale
FROM
    retail_sales_db
GROUP BY
    sale_month
ORDER BY
    sale_month;


--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

SELECT
    customer_id,
    SUM(total_sale) AS total_sales_by_customer
FROM
    retail_sales_db
GROUP BY
    customer_id
ORDER BY
    total_sales_by_customer DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT
    category,
    COUNT(DISTINCT customer_id) AS unique_customers_per_category
FROM
    retail_sales_db
GROUP BY
    category
ORDER BY
    unique_customers_per_category DESC;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


WITH hourly_sale
AS 
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS sales_shift
FROM
    retail_sales_db
)
SELECT 
      sales_shift,
	  COUNT(*) AS total_orders
FROM
      hourly_sale
GROUP BY 
      sales_shift
;

-- END OF PROJECT




























































