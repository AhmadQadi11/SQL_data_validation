1- Verify Data Integrity
SELECT l1.order_no, l1.order_type, l2.order_type
FROM test2.l1_order l1
JOIN test2.l2_order l2 ON l1.order_no = l2.order_no
WHERE l1.product_type = l1.order_type 
AND l2.product_type = l2.order_type
AND (l1.order_type <> l2.order_type OR l1.dim_group_id <> l2.dim_group_id);

**If rows are returned, there are mismatches

2- Validate the 'Rule' Condition
SELECT l2.service_fee_code, l2.product_code
FROM test2.l2_order
WHERE product_type = 'rule' AND service_fee_code <> product_code;

**For service_fee_code, where product_type = 'rule', it should match product_name.

3- Create the Final Finance Report
CREATE TABLE test2.finance_report AS
SELECT * FROM test2.l2_order WHERE product_type = order_type;

**This should correctly structure the data as per business logic. Let me know if you need any refinements!