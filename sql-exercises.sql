-- 1. Write a query to return all category names with their descriptions from the Categories table.
SELECT CategoryName, Description
FROM Categories

-- 2. Write a query to return the contact name, customer id, company name and city name of all Customers in London
SELECT CustomerID, CompanyName, ContactName, City
FROM Customers
WHERE City = 'London'

-- 3. Write a query to return all available columns in the Suppliers tables for the marketing managers and sales representatives that have a FAX number
SELECT *
FROM Suppliers
WHERE ContactTitle IN('Marketing Manager', 'Sales Representative')  
AND Fax IS NULL

-- 4. Write a query to return a list of customer id's from the Orders table with required dates between Jan 1, 1997 and Dec 31, 1997 and with freight under 100 units.
SELECT CustomerID
FROM Orders
WHERE RequiredDate BETWEEN '1997-01-01 00:00:00.000' AND  '1997-12-31 23:59:59.999'

-- 5. Write a query to return a list of company names and contact names of all customers from Mexico, Sweden and Germany.
SELECT CompanyName, ContactName
FROM Customers
WHERE Country IN('Germany', 'Mexico', 'Sweden')    


-- 6. Write a query to return a count of the number of discontinued products in the Products table.'
Select COUNT(*)
FROM Products
WHERE Discontinued = 1

-- 7 Write a query to return a list of category names and descriptions of all categories beginning with 'Co' from the Categories table.
Select CategoryName, Description
FROM Categories
WHERE CategoryName LIKE 'Co%'

-- 8. Write a query to return all the company names, city, country and postal code from the Suppliers table with the word 'rue' in their address. The list should ordered alphabetically by company name.
SELECT CompanyName, City, Country, PostalCode
FROM Suppliers
WHERE Address LIKE '%rue%'
ORDER BY CompanyName ASC

-- 9. Write a query to return the product id and the quantity ordered for each product labelled as 'Quantity Purchased' in the Order Details table ordered by the Quantity Purchased in descending order.
SELECT ProductID, Quantity as 'Quantity Purchased'
From [Order Details]
ORDER BY Quantity DESC

-- 10. Write a query to return the company name, address, city, postal code and country of all customers with orders that shipped using Speedy Express, along with the date that the order was made.
SELECT c.CompanyName, c.Address, c.City, c.PostalCode, c.Country, Orders.OrderDate
FROM Customers as c
Left join Orders
ON c.CustomerID = Orders.CustomerID
JOIN Shippers
ON Orders.ShipVia = Shippers.ShipperID
WHERE Shippers.CompanyName = 'Speedy Express' 

-- 11. Write a query to return a list of Suppliers containing company name, contact name, contact title and region description.
SELECT CompanyName, ContactName, ContactTitle, Region
FROM Suppliers

-- 12. Write a query to return all product names from the Products table that are condiments.
Select ProductName 
From Products
LEFT JOIN Categories
ON Products.CategoryID = Categories.CategoryID
WHERE Categories.CategoryName = 'Condiments'

-- 13. Write a query to return a list of customer names who have no orders in the Orders table.
SELECT ContactName
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderDate IS NULL

-- 14. Write a query to add a shipper named 'Amazon' to the Shippers table using SQL.
INSERT INTO Shippers (CompanyName, Phone)
VALUES ('Amazon', '(503 555-9999)')

-- 15. Write a query to change the company name from 'Amazon' to 'Amazon Prime Shipping' in the Shippers table using SQL.
UPDATE Shippers
SET Phone = '(503) 555-9999'
WHERE CompanyName = 'Amazon Prime Shipping'

-- 16. Write a query to return a complete list of company names from the Shippers table. Include freight totals rounded to the nearest whole number for each shipper from the Orders table for those shippers with orders.
SELECT Shippers.CompanyName, ROUND(SUM(Orders.Freight), 0)
FROM Shippers
LEFT JOIN Orders
ON Shippers.ShipperID = Orders.ShipVia
GROUP BY(Shippers.CompanyName)

-- 17. Write a query to return all employee first and last names from the Employees table by combining the 2 columns aliased as 'DisplayName'. The combined format should be 'LastName, FirstName'.
SELECT (LastName + ', ' + FirstName)  as 'LastName, FirstName' 
FROM Employees

-- 18. Write a query to add yourself to the Customers table with an order for 'Grandma's Boysenberry Spread'.
INSERT INTO Customers(CustomerID, CompanyName, ContactName)
Values ('OCAJ', 'OCA', 'Jason Land')

INSERT INTO Orders(CustomerID)
    (SELECT CustomerID 
    FROM Customers 
    WHERE CustomerID = 'OCAJ'
    )

INSERT INTO [Order Details](OrderID, ProductID, UnitPrice, Quantity, Discount)
    (SELECT OrderID, p.ProductID, p.UnitPrice, 1, 0
    FROM Orders
    INNER JOIN Products as p
    ON CustomerID = 'OCAJ' and p.ProductName = 'Grandma''s Boysenberry Spread')

-- 19. Write a query to remove yourself and your order from the database.
DELETE FROM [Order Details]
WHERE EXISTS(
    SELECT Orders.CustomerID
    FROM Orders
    WHERE Orders.CustomerID = 'OCAJ')

DELETE FROM Orders
WHERE EXISTS(
    SELECT ContactName
    FROM Customers
    WHERE ContactName = 'Jason Land')

DELETE FROM Customers
WHERE ContactName = 'Jason Land'

-- 20. Write a query to return a list of products from the Products table along with the total units in stock for each product. Include only products with TotalUnits greater than 100.
SELECT ProductName, SUM(UnitsInStock)
FROM Products
GROUP BY ProductName
HAVING SUM(UnitsInSTock) > 100