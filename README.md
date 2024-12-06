# SQLProject
This database is designed to manage the operations of a pizza restaurant, including employee management, menu items, tables, orders, and invoices.

Tables:
Employees
Stores employee details such as name, position, shift, salary, and contact information.

Tables
Manages information about restaurant tables, including table number, capacity, and status (available, occupied, or reserved).

Menu
Contains all menu items (pizzas, drinks, desserts), with their name, description, category, and price.

Inventory
Tracks ingredients and stock levels for products used in the restaurant, such as cheese, meats, and beverages.

Orders
Records customer orders, linking tables, waiters, and ordered items, along with order status and date.

Invoice
Stores details of invoices generated for completed orders, including payment method and total amount.

InvoiceProducts
Links each invoice with the products ordered, showing quantity and price per item.

This database will be useful for performing various queries, such as using SELECT to retrieve specific data, JOIN to combine tables, and filtering data based on different conditions. For example, you can easily find which waiter served a particular table, calculate total sales for a given date, or check inventory stock levels. These queries will help analyze restaurant performance, track orders, manage inventory, and generate reports.

SQL Querys examples:

Find wich waiter served a particular table 
"SELECT Employees.Name, Waiters.AssignmentDate, Tables.TableNumber FROM Waiters JOIN Employees ON Waiters.EmployeeID = Employees.EmployeeID JOIN Tables ON Waiters.TableID = Tables.TableID Where Tables.TableNumber = 3;"

How to calculate total sales on a specific date 
"SELECT SUM(TotalAmount) FROM Invoice where CONVERT(DATE, InvoiceDate) = '2024-12-06';"

Top 5 most sold products 
"SELECT TOP 5 ProductName, 
    SUM(Quantity) AS TotalSold, 
    SUM(Subtotal) AS TotalSales
FROM InvoiceProducts
JOIN Invoice ON InvoiceProducts.InvoiceID = Invoice.InvoiceID
WHERE CONVERT(DATE, InvoiceDate) BETWEEN '2024-12-01' AND '2024-12-06'
GROUP BY ProductName
ORDER BY TotalSold DESC;"


Sales depending on shift 
"SELECT 
    Employees.Shift AS Shift,
    SUM(InvoiceProducts.Subtotal) AS TotalSales
FROM Invoice
JOIN InvoiceProducts ON Invoice.InvoiceID = InvoiceProducts.InvoiceID
JOIN Waiters ON Invoice.InvoiceID = Waiters.TableID
JOIN Employees ON Waiters.EmployeeID = Employees.EmployeeID
WHERE CONVERT(DATE, InvoiceDate) BETWEEN '2024-12-01' AND '2024-12-06' 
GROUP BY Shift;"
