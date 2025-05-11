-- Create the customer data table
CREATE TABLE IF NOT EXISTS customer_data (
    ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Address VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(2),
    Zip_Code VARCHAR(10),
    Phone_Number VARCHAR(15),
    Email VARCHAR(100),
    Birthdate DATE
);

-- Insert sample data from the challenge
INSERT INTO customer_data VALUES
(1, 'John', 'Smith', '123 Main St', 'Anytown', 'CA', '12345', '555-555-1212', 'john.smith@email.com', '1980-01-01'),
(2, 'Jane', 'Doe', '456 Second St', 'Anytown', 'CA', '12345', NULL, 'jane.doe@email.com', '1990-02-02'),
(3, 'John', 'Smith', '789 Third St', 'Othertown', 'NY', '67890', '555-555-1212', NULL, '1987-03-12'),
(4, 'Bob', 'Johnson', '234 Fourth St', 'Othertown', 'NY', '67890', '555-555-1212', 'bob.johnson@example.com', '1985-04-04'),
(5, 'Sarah', 'Lee', '567 Fifth St', 'Thirdtown', 'FL', '45678', '555-555-1212', 'sarah.lee@invalidemail', NULL),
(6, 'David', 'Kim', '890 Sixth St', 'Fourthtown', 'TX', '34567', '555-555-1212', 'david.kim@email.com', '1995-06-06'),
(7, 'John', 'Smith', '123 Main St', 'Anytown', 'CA', NULL, '555-555-1212', 'john.smith@example.com', '1980-01-01'),
(8, 'Jane', 'Doe', '456 Second St', 'Anytown', 'CA', '12345', '555-555-1212', 'jane.doe@invalidemail', '02-02-1990'),
(9, 'John', 'Smith', '789 Third St', 'Othertown', NULL, '67890', '555-555-1212', 'john.smith@email.com', '1975-03-03'),
(10, 'Bob', 'Johnson', '234 Fourth St', 'Othertown', 'NY', NULL, '555-555-1212', 'bob.johnson@example.com', '1985-04-04');
-- 