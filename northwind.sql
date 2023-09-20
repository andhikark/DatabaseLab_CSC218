--1) Show order date and its product names. 
SELECT orders.orderid, orderdate, productname
FROM orders, orderdetails, products
WHERE orders.orderid = orderdetails.orderid
       and products.productID = orderdetails.productID

--2) Show the number of different products  for each order
SELECT orderid, COUNT(*)
FROM orderdetails
GROUP BY orderid

--3) Show the number of pieces of 
SELECT orderid, SUM(quantity) AS pieces
FROM orderdetails
GROUP BY orderid

--4) Show order date, the number of different product for each order
SELECT orderdate, COUNT(*) AS PRODUCTS
FROM orders, orderdetails
WHERE orders.orderid = orderdetails.orderid
GROUP BY orderdate,orders.orderid

--5) How many pieces of product does each customer order? Show name of customer and the number of pieces of products 
SELECT customername, SUM(quantity) AS pieces
FROM customers, orders, orderdetails
WHERE customers.customerid = orders.customerid
  AND orders.orderid = orderdetails.orderid
GROUP BY customers.customerid, customername

--6) continue from number 5) Who orders the most pieces?
SELECT max(pieces)
FROM customerQuantity

--7) How many people are there for each job title?
SELECT jobtitle, Count(*) AS quantity
FROM employees
GROUP BY jobtitle;

--8) Show name fo customer who have never ordered  --> all customers - ordering customer 
SELECT customername
FROM customers
EXCEPT 
SELECT customername
FROM customers, orders
WHERE customers.customerid = orders.customerid 
