-- --------------------------------------------------------------------------------------------------------------
-- TODO: Extract the appropriate data from the northwind database, and INSERT it into the Northwind_DW database.
-- --------------------------------------------------------------------------------------------------------------
USE northwind_dw;
-- ----------------------------------------------
-- Populate dim_customers
-- ----------------------------------------------

INSERT INTO `northwind_dw`.`dim_customers`
(`customer_key`,
`company`,
`last_name`,
`first_name`,
`job_title`,
`business_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`)
SELECT `id`,
`company`,
`last_name`,
`first_name`,
`job_title`,
`business_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`
FROM northwind.customers;

-- ----------------------------------------------
-- Validate that the Data was Inserted ----------
-- ----------------------------------------------
SELECT * FROM northwind_dw.dim_customers;


-- ----------------------------------------------
-- Populate dim_employees
-- ----------------------------------------------
INSERT INTO `northwind_dw`.`dim_employees`
(`employee_key`,
`company`,
`last_name`,
`first_name`,
`email_address`,
`job_title`,
`business_phone`,
`home_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`,
`web_page`)
SELECT `employees`.`id`,
    `employees`.`company`,
    `employees`.`last_name`,
    `employees`.`first_name`,
    `employees`.`email_address`,
    `employees`.`job_title`,
    `employees`.`business_phone`,
    `employees`.`home_phone`,
    `employees`.`fax_number`,
    `employees`.`address`,
    `employees`.`city`,
    `employees`.`state_province`,
    `employees`.`zip_postal_code`,
    `employees`.`country_region`,
    `employees`.`web_page`
FROM `northwind`.`employees`;

-- ----------------------------------------------
-- Validate that the Data was Inserted ----------
-- ----------------------------------------------
SELECT * FROM northwind_dw.dim_employees;


-- ----------------------------------------------
-- Populate dim_products
-- ----------------------------------------------
INSERT INTO `northwind_dw`.`dim_products`
(`product_key`,
`product_code`,
`product_name`,
`standard_cost`,
`list_price`,
`reorder_level`,
`target_level`,
`quantity_per_unit`,
`discontinued`,
`minimum_reorder_quantity`,
`category`)
# TODO: Write a SELECT Statement to Populate the table;
SELECT `id`,
    `product_code`,
    `product_name`,
    `standard_cost`,
    `list_price`,
    `reorder_level`,
    `target_level`,
    `quantity_per_unit`,
    `discontinued`,
    `minimum_reorder_quantity`,
    `category`
FROM northwind.products;

-- ----------------------------------------------
-- Validate that the Data was Inserted ----------
-- ----------------------------------------------
SELECT * FROM northwind_dw.dim_products;


-- ----------------------------------------------
-- Populate dim_shippers
-- ----------------------------------------------
INSERT INTO `northwind_dw`.`dim_shippers`
(`shipper_key`,
`company`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`)
# TODO: Write a SELECT Statement to Populate the table;
SELECT `id`,
    `company`,
    `address`,
    `city`,
    `state_province`,
    `zip_postal_code`,
    `country_region`
FROM northwind.shippers;
-- ----------------------------------------------
-- Validate that the Data was Inserted ----------
-- ----------------------------------------------
SELECT * FROM northwind_dw.dim_shippers;



-- ----------------------------------------------
-- Populate fact_orders
-- ----------------------------------------------
INSERT INTO `northwind_dw`.`fact_orders`
(
`order_key`,
`order_details_key`,
`employee_key`,
`customer_key`,
`product_key`,
`shipper_key`,
`unit_price`,
`discount`,
`quantity`,
`order_date`,
`shipped_date`,
`shipping_fee`,
`taxes`,
`payment_type`,
`paid_date`,
`tax_rate`,
`order_status`,
`order_details_status`)
/* 
--------------------------------------------------------------------------------------------------
TODO: Write a SELECT Statement that:
- JOINS the northwind.orders table with the northwind.orders_status table
- JOINS the northwind.orders with the northwind.order_details table.
--  (TIP: Remember that there is a one-to-many relationship between orders and order_details).
- JOINS the northwind.order_details table with the northwind.order_details_status table.
--------------------------------------------------------------------------------------------------
- The column list I've included in the INSERT INTO clause above should be your guide to which 
- columns you're required to extract from each of the four tables. Pay close attention!
--------------------------------------------------------------------------------------------------
*/
SELECT o.id,
    od.id,
    o.employee_id,
    o.customer_id,
    od.product_id,
    o.shipper_id,
    od.unit_price,
    od.discount,
    od.quantity,
    o.order_date,
    o.shipped_date,
    o.shipping_fee,
    o.taxes,
    o.payment_type,
    o.paid_date,
    o.tax_rate,
    os.status_name AS order_status,
    ods.status_name AS order_details_status
FROM northwind.orders AS o
INNER JOIN northwind.orders_status AS os
ON o.status_id = os.id
RIGHT OUTER JOIN northwind.order_details AS od
ON o.id = od.order_id
INNER JOIN northwind.order_details_status AS ods
ON od.status_id = ods.id;
-- ----------------------------------------------
-- Validate that the Data was Inserted ----------
-- ----------------------------------------------
SELECT * FROM northwind_dw.fact_orders;



-- ---------------------------------------------
-- TODO: To demonstrate the viability of your solution, author a SQL SELECT statement that returns:
--   -	Each Customer’s Last Name
--   -	The total amount of the order quantity associated with each customer
--   -  The total amount of the order unit price associated with each customer
-- ---------------------------------------------
SELECT dc.last_name AS customer_name
	, SUM(fo.quantity) AS total_quantity
	, SUM(fo.unit_price) AS total_unit_price
FROM northwind_dw.fact_orders AS fo
INNER JOIN northwind_dw.dim_customers AS dc 
ON fo.customer_key = dc.customer_key
GROUP BY dc.customer_key
ORDER BY total_unit_price DESC;


SELECT * FROM northwind_dw.fact_orders;
SELECT * FROM northwind_dw.dim_customers;
