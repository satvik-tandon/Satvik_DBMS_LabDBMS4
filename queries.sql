-- Display the total number of customers based on gender who have placed individual orders of worth at least Rs.3000.
SELECT c.CUS_GENDER, COUNT(DISTINCT c.CUS_ID) AS TOTAL_CUSTOMERS
FROM customer c
JOIN `order` o ON c.CUS_ID = o.CUS_ID
WHERE o.ORD_AMOUNT >= 3000
GROUP BY c.CUS_GENDER;

-- Display all the orders along with product name ordered by a customer having Customer_Id=2
SELECT o.ORD_ID, p.PRO_NAME, o.ORD_AMOUNT, o.ORD_DATE
FROM `order` o
JOIN supplier_pricing sp ON o.PRICING_ID = sp.PRICING_ID
JOIN product p ON sp.PRO_ID = p.PRO_ID
WHERE o.CUS_ID = 2;

-- Display the Supplier details who can supply more than one product.
SELECT s.SUPP_ID, s.SUPP_NAME, s.SUPP_CITY, s.SUPP_PHONE
FROM supplier s
JOIN supplier_pricing sp ON s.SUPP_ID = sp.SUPP_ID
GROUP BY s.SUPP_ID, s.SUPP_NAME, s.SUPP_CITY, s.SUPP_PHONE
HAVING COUNT(DISTINCT sp.PRO_ID) > 1;

-- Find the least expensive product from each category and print the table with category id, name, product name and price of the product
SELECT c.cat_ID, c.cat_name, MIN(sp.Min_Price) AS Min_Price
FROM category c
JOIN (
    SELECT p.cat_ID, p.pro_name, MIN(s.supp_price) AS Min_Price
    FROM product p
    JOIN supplier_pricing s ON p.pro_ID = s.pro_ID
    GROUP BY p.cat_ID, p.pro_name
) sp ON sp.cat_ID = c.cat_ID
GROUP BY c.cat_ID, c.cat_name;

-- Display the Id and Name of the Product ordered after “2021-10-05”.
SELECT o.ORD_ID, p.PRO_NAME
FROM `order` o
JOIN supplier_pricing sp ON o.PRICING_ID = sp.PRICING_ID
JOIN product p ON sp.PRO_ID = p.PRO_ID
WHERE o.ORD_DATE > '2021-10-05';

-- Display customer name and gender whose names start or end with character 'A'.
SELECT CUS_NAME, CUS_GENDER
FROM customer
WHERE CUS_NAME LIKE 'A%' OR CUS_NAME LIKE '%A';

-- Create a stored procedure to display supplier id, name, Rating(Average rating of all the products sold by every customer) and
-- Type_of_Service. For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print “Average
-- Service” else print “Poor Service”. Note that there should be one rating per supplier.

