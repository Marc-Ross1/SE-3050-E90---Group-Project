USE farmers_market_schema;

-- Purpose: Lists the information of all markets so users decide where to visit.
SELECT name AS market_name, location AS market_location, operating_hours, contact_email
FROM Markets
ORDER BY name, location;

-- Purpose: Lists all the vendors and markets in a given city so users can search if a market and vendor is in a specific city.
SELECT m.location AS market_location, m.name AS market_name, ms.stall_number, v.business_name, v.owner_name, v.phone, v.email
FROM Markets m
JOIN Market_Stalls ms ON m.market_id = ms.market_id 
JOIN Vendors v ON v.vendor_id = ms.vendor_id
WHERE location = 'St. Peter, MN' -- Location will changed depending on the input the user gives. 
ORDER BY m.location, v.business_name;


-- Purpose: Lists all the products a specific vendor sells so users can see what they can purchase.
SELECT v.business_name, p.name AS product_name, p.description, p.price, p.stock_quantity, p.category 
FROM Vendors v
JOIN Products p
ON v.vendor_id = p.vendor_id
WHERE v.business_name = 'Honey \'N\' Stuff' -- Business name will changed depending on the input the user gives. 
ORDER BY p.name;


-- Purpose: Lists all the orders for a given customer. NOTE: This will have to have some form a validation on the application side so that only the customer can request this data.
SELECT o.customer_name, o.order_date, o.status, o.total_amount, oi.quantity
FROM Orders o
JOIN Order_Items oi
ON o.order_id = oi.order_id
WHERE customer_name = 'Alex Smith' -- Customer name will changed depending on the input the user gives. 
ORDER BY o.order_date, o.status, o.total_amount, oi.quantity;


-- Purpose: Lists the total vendor sales for a given year for each product of the vendor so vendors can asses their financial status for the year.
SELECT v.business_name, p.name AS product_name, SUM(oi.price_at_purchase * oi.quantity) AS total_sales_for_product, COUNT(*) AS num_unique_purchases
FROM Vendors v
JOIN Products p ON v.vendor_id = p.vendor_id
JOIN Order_Items oi ON p.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
WHERE v.business_name = 'Jason\'s Barbeque' AND YEAR(o.order_date) = '2026' -- Business name and order date will change depending on the input the user gives. 
GROUP BY p.name
ORDER BY p.name;


-- Purpose: Lists the global sales of all of a market's vendors based off the sum of vendor product sales for a given year so markets can asses their financial status.
SELECT v.business_name, SUM(oi.price_at_purchase * oi.quantity) AS total_vendor_sales
FROM Markets m
JOIN Market_Stalls ms ON m.market_id = ms.market_id 
JOIN Vendors v ON  ms.vendor_id = v.vendor_id
JOIN Products p ON v.vendor_id = p.vendor_id
JOIN Order_Items oi ON p.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
WHERE m.name = 'Sunfield Market' AND YEAR(o.order_date) = '2026' -- Market name and order date will change depending on the input the user gives. 
GROUP BY v.business_name
ORDER BY v.business_name;