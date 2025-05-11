-- Validation queries for customer data

-- 1. Check for missing values in important fields
SELECT 'Missing Email Addresses' AS validation_check, COUNT(*) AS count
FROM customer_data
WHERE Email IS NULL
UNION ALL
SELECT 'Missing Phone Numbers' AS validation_check, COUNT(*) AS count
FROM customer_data
WHERE Phone_Number IS NULL
UNION ALL
SELECT 'Missing Birthdates' AS validation_check, COUNT(*) AS count
FROM customer_data
WHERE Birthdate IS NULL;

-- 2. Check for duplicate customer records (same first name, last name)
SELECT First_Name, Last_Name, COUNT(*) AS duplicate_count
FROM customer_data
GROUP BY First_Name, Last_Name
HAVING COUNT(*) > 1;

-- 3. Check for duplicate phone numbers
SELECT Phone_Number, COUNT(*) AS duplicate_count
FROM customer_data
WHERE Phone_Number IS NOT NULL
GROUP BY Phone_Number
HAVING COUNT(*) > 1;

-- 4. Validate email format (basic check for @ symbol and domain)
SELECT ID, Email
FROM customer_data
WHERE Email IS NOT NULL 
AND (Email NOT LIKE '%@%.%' OR Email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$');

-- 5. Validate phone number format (assuming US format XXX-XXX-XXXX)
SELECT ID, Phone_Number
FROM customer_data
WHERE Phone_Number IS NOT NULL
AND Phone_Number NOT LIKE '___-___-____';

-- 6. Validate birthdate (check for future dates or very old dates)
SELECT ID, Birthdate
FROM customer_data
WHERE Birthdate IS NOT NULL
AND (Birthdate > CURRENT_DATE OR YEAR(Birthdate) < 1900);

	
-- 8. Summary of data quality issues
SELECT 
    (SELECT COUNT(*) FROM customer_data) AS total_records,
    (SELECT COUNT(*) FROM customer_data WHERE Email IS NULL) AS missing_emails,
    (SELECT COUNT(*) FROM customer_data WHERE Phone_Number IS NULL) AS missing_phones,
    (SELECT COUNT(*) FROM customer_data WHERE Birthdate IS NULL) AS missing_birthdates,
    (SELECT COUNT(*) FROM customer_data WHERE Email IS NOT NULL AND Email NOT LIKE '%@%.%') AS invalid_emails,
    (SELECT COUNT(DISTINCT First_Name, Last_Name) FROM customer_data) AS unique_customers;