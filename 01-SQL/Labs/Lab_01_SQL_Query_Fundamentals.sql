-- ------------------------------------------------------------------
-- 0). First, How Many Rows are in the Products Table?
-- ------------------------------------------------------------------
SELECT COUNT(*) FROM northwind.products;

-- ------------------------------------------------------------------
-- 1). Product Name and Unit/Quantity
-- ------------------------------------------------------------------
SELECT product_name
	, quantity_per_unit
FROM northwind.products;

-- ------------------------------------------------------------------
-- 2). Product ID and Name of Current Products
-- ------------------------------------------------------------------
SELECT id AS product_id
	, product_name
FROM northwind.products
WHERE discontinued = 0; 

-- ------------------------------------------------------------------
-- 3). Product ID and Name of Discontinued Products
-- ------------------------------------------------------------------
SELECT id AS product_id
	, product_name
FROM northwind.products
WHERE discontinued != 0;

-- ------------------------------------------------------------------
-- 4). Name & List Price of Most & Least Expensive Products
-- ------------------------------------------------------------------
SELECT product_name
	, list_price
FROM northwind.products
WHERE list_price = (SELECT MIN(list_price) FROM northwind.products)
OR list_price = (SELECT MAX(list_price) FROM northwind.products);

-- ------------------------------------------------------------------
-- 5). Product ID, Name & List Price Costing Less Than $20
-- ------------------------------------------------------------------
SELECT id
	, product_name
    , list_price
FROM northwind.products
WHERE list_price < 20
ORDER BY list_price DESC;

-- ------------------------------------------------------------------
-- 6). Product ID, Name & List Price Costing Between $15 and $20
-- ------------------------------------------------------------------
SELECT id
	, product_name
    , list_price
FROM northwind.products
WHERE list_price BETWEEN 15.00 AND 20.00
ORDER BY list_price DESC;


-- ------------------------------------------------------------------
-- 7). Product Name & List Price Costing Above Average List Price
-- ------------------------------------------------------------------
SELECT product_name
	, list_price
FROM northwind.products
WHERE list_price > (SELECT AVG(list_price) from northwind.products);

-- ------------------------------------------------------------------
-- 8). Product Name & List Price of 10 Most Expensive Products 
-- ------------------------------------------------------------------
SELECT product_name
	, list_price
FROM northwind.products
ORDER BY list_price DESC
LIMIT 10;

-- ------------------------------------------------------------------ 
-- 9). Count of Current and Discontinued Products 
-- ------------------------------------------------------------------

SELECT SUM(CASE WHEN discontinued=0 THEN 1 END) AS 'Count of Current',
	SUM(CASE WHEN discontinued=1 THEN 1 END) AS 'Count of Discontinued'
FROM northwind.products;

-- ------------------------------------------------------------------
-- 10). Product Name, Units on Order and Units in Stock
--      Where Quantity In-Stock is Less Than the Quantity On-Order. 
-- ------------------------------------------------------------------
SELECT product_name, units_on_order, units_in_stock
FROM (
SELECT product_name,
SUM(CASE
  WHEN posted_to_inventory = 0 THEN quantity ELSE 0 END
) AS units_on_order,
SUM(CASE
  WHEN posted_to_inventory = 1 THEN quantity ELSE 0 END
) AS units_in_stock
FROM northwind.purchase_order_details
INNER JOIN 
(SELECT product_name, id
FROM northwind.products) p
ON p.id = purchase_order_details.product_id
GROUP BY product_name ) quantities
WHERE units_in_stock < units_on_order;

-- ------------------------------------------------------------------
-- EXTRA CREDIT -----------------------------------------------------
-- ------------------------------------------------------------------


-- ------------------------------------------------------------------
-- 11). Products with Supplier Company & Address Info
-- ------------------------------------------------------------------

-- CREATE TABLE suppliers_temp AS SELECT * FROM northwind.suppliers;
-- ALTER TABLE suppliers_temp
-- MODIFY COLUMN id longtext;

SELECT product_name, company, address, city, state_province, zip_postal_code, country_region
FROM 
((		WITH productSupply AS (
			SELECT product_name, supplier_ids
			FROM northwind.products
			WHERE supplier_ids LIKE '___'
		)
		SELECT product_name, substring_index(supplier_ids, ';', 1) AS supplier_ids
		FROM productSupply
		UNION
		SELECT product_name, substring_index(supplier_ids, ';', -1) AS supplier_ids
		FROM productSupply)
	UNION 
    (	SELECT product_name, supplier_ids
		FROM northwind.products
		WHERE supplier_ids LIKE '_')
) AS p
LEFT OUTER JOIN suppliers_temp AS s ON p.supplier_ids = s.id
ORDER BY product_name ASC;

-- ------------------------------------------------------------------
-- 12). Number of Products per Category With Less Than 5 Units
-- ------------------------------------------------------------------

SELECT products.category, COUNT(t.product_id) AS "number"
FROM northwind.products 
  LEFT JOIN 
  (
	SELECT * FROM northwind.purchase_order_details
	WHERE purchase_order_details.posted_to_inventory = 1
	AND purchase_order_details.quantity < 5) t
  ON products.id = t.product_id
GROUP BY products.category;

-- ------------------------------------------------------------------
-- 13). Number of Products per Category Priced Less Than $20.00
-- ------------------------------------------------------------------
SELECT category
	, COUNT(category)
FROM northwind.products
WHERE list_price < 20
GROUP BY category;


