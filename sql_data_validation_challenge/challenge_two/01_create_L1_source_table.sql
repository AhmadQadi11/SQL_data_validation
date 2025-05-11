-- Create the L1 source table based on the challenge description
CREATE TABLE IF NOT EXISTS L1_source_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_type VARCHAR(50),
    dim_group_id VARCHAR(50),
    order_no VARCHAR(50),
    dim_bookingdate_id DATE,
    dim_store_id VARCHAR(50),
    product_name VARCHAR(100),
    product_type VARCHAR(50),
    dim_customer_id VARCHAR(50),
    dim_language VARCHAR(10),
    dim_totals_currency VARCHAR(3),
    dim_status_id VARCHAR(20),
    phone VARCHAR(20),
    payment_amount DECIMAL(10,2),
    discount_amount DECIMAL(10,2),
    service_fee_amount DECIMAL(10,2),
    base_amount DECIMAL(10,2),
    inputvat DECIMAL(10,2),
    outputvat DECIMAL(10,2),
    product_vat DECIMAL(10,2),
    selling_price DECIMAL(10,2),
    selling_price_vat DECIMAL(10,2),
    ibv DECIMAL(10,2),
    conversion_rate_usd DECIMAL(10,4),
    gbv DECIMAL(10,2)
);
**To insert the value as its huge I created an csv file and uploaded the data on it then I uploaded using msql workbench you can find the files on the same folder