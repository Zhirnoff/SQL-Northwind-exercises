--1--
--1.1	������� � ������� Orders ������, ������� ���� ���������� ����� 6 ��� 1998 ���� (������� ShippedDate) ������������ � ������� ���������� � ShipVia >= 2. 
--������ �������� ���� ������ ���� ������ ��� ����� ������������ ����������, �������� ����������� ������ 
--�Writing International Transact-SQL Statements� � Books Online ������ �Accessing and Changing Relational Data�. 
--���� ����� ������������ ����� ��� ���� �������. ������ ������ ����������� ������ ������� OrderID, ShippedDate � ShipVia. 
--�������� ������ ���� �� ������ ������ � NULL-�� � ������� ShippedDate.
SELECT OrderID, ShippedDate, ShipVia
FROM Orders
WHERE ShippedDate > 1998-05-06
--1.2	������� ��� ���������� �� �����������, � ������� ���� ����������.
SELECT *
FROM Employees
WHERE ReportsTo IS NOT NULL
--1.3	������� �� ������� Employees ����� � ������� ���� ����������� ������ 50-��  ���. 
--�������� ����� ������� ���������� � ������� � ��������� �Age� ������� ��� �������.
SELECT LastName, FirstName, DATEDIFF(year, BirthDate, getdate()) AS Age
FROM Employees
WHERE DATEDIFF(year, BirthDate, getdate()) > 50;

--1.4	�������� ������, ������� ������� ������ �������������� ������ �� ������� Orders. 
--� ����������� ������� ����������� ��� ������� ShippedDate ������ �������� NULL ������ �Not Shipped� � ������������ ��������� ������� CAS�. 
--������ ������ ����������� ������ ������� OrderID � ShippedDate.
SELECT OrderID, ShippedDate =
CASE 
WHEN ShippedDate is null THEN 'Not Shipped'
END
FROM Orders 
WHERE ShippedDate is null;
--1.5	������� � ������� Orders ������, ������� ���� ���������� ����� 6 ��� 1998 ���� (ShippedDate) �� ������� ��� ���� ��� ������� ��� �� ����������. 
--� ������� ������ ������������� ������ ������� OrderID (������������� � Order Number) � ShippedDate (������������� � Shipped Date). 
--� ����������� ������� ����������� ��� ������� ShippedDate ������ �������� NULL ������ �Not Shipped�, ��� ��������� �������� ����������� ���� � ������� �� ���������.
SELECT 
OrderID AS "Order Number", 
ShippedDate = 
CASE 
WHEN ShippedDate is null THEN 'Not Shipped'
ELSE CONVERT(CHAR, ShippedDate, 103)
END
FROM Orders 
WHERE (ShippedDate > { d'1996-05-06'} or ShippedDate is null);
--2--
--2.1	������� ���� �� ������� ��������� �� ������� Products, �������� �� �� ������. 
--�������� ������ �������� �������� � ���� �� ����. ������������ ������� CAST.
SELECT ProductName,
CAST (UnitPrice AS DEC(12)) AS UnitPrice
FROM Products
--2.2	������� ���� �� ������� ��������� �� ������� Products, �������� �� �� ������. 
--�������� ������ �������� �������� � ���� �� ����. ������������ ������� CONVERT.
SELECT ProductName,
CONVERT (DEC, UnitPrice, (12)) AS UnitPrice
FROM Products

--3--
--3.1	������� �� ������� Customers ���� ����������, ����������� � USA � Canada. 
--������ ������� � ������ ������� ��������� IN. ����������� ������� � ������ ������������ � ��������� ������ � ����������� �������. 
--����������� ���������� ������� �� ����� ���������� � �� ����� ����������.
SELECT 
ContactName, Country 
FROM Customers 
WHERE Country in ('USA','Canada') 
ORDER BY Country, ContactName;

--3.2	������� �� ������� Customers ���� ����������, �� ����������� � USA � Canada. 
--������ ������� � ������� ��������� IN. ����������� ������� � ������ ������������ � ��������� ������ � ����������� �������. 
--����������� ���������� ������� �� ����� ����������.
SELECT ContactName, Country 
FROM Customers 
WHERE Country not in ('USA','Canada') 
ORDER BY ContactName;
--3.3	������� �� ������� Customers ��� ������, � ������� ��������� ���������. 
--������ ������ ���� ��������� ������ ���� ��� � ������ ������������ �� ��������. 
--�� ������������ ����������� GROUP BY. ����������� ������ ���� ������� � ����������� �������. 
SELECT DISTINCT 
Country 
FROM Customers;
--3.4	������� ��������� ���������� � �����������: �����, ������� � ���� ��������. 
--���������� ������� ����������� �� ���� ���� ����� � �������, ������� ������. 
--���������, ������ ������� � ���� �������� ����������� ��� ������ �� �������.
SELECT City, LastName, BirthDate
FROM Employees
ORDER BY City, LastName, BirthDate

--4--
--4.1 ������� ��� ������ (OrderID) �� ������� Order Details (������ �� ������ �����������), 
--��� ����������� �������� � ����������� �� 3 �� 10 ������������ � ��� ������� Quantity � ������� Order Details. 
--������������ �������� BETWEEN. ������ ������ ����������� ������ ������� OrderID.
SELECT DISTINCT 
OrderID
FROM [Order Details] 
WHERE Quantity BETWEEN 3 AND 10;
--4.2	������� ���� ���������� �� ������� Customers, � ������� �������� ������ ���������� �� ����� �� ��������� a � g. 
--������������ �������� BETWEEN. ������ ������ ����������� ������ ������� CustomerID � Country � ������������ �� Country. 
--������ �������� ������ � �������� ��������� �������� ���� a � g � � �� ������ ���������� � ��������� �����?
SELECT CustomerID, Country 
FROM Customers 
WHERE Country BETWEEN 'a' AND 'g' 
ORDER BY Country;
--4.3	������� ���� ���������� �� ������� Customers, � ������� �������� ������ ���������� �� ����� �� ��������� a � g, �� ��������� �������� BETWEEN.
SELECT CustomerID, Country 
FROM Customers 
WHERE Country > 'a' and Country < 'g' 
ORDER BY Country;

--5--
--5.1	������� �� �������  Customers ��� �������� ��������, ������������ �� �Fran�.
SELECT CompanyName
FROM Customers
WHERE CompanyName LIKE 'Fran%'
--5.2	� ������� Products ����� ��� �������� (������� ProductName), ��� ����������� ��������� 'chocolade'. 
--��������, ��� � ��������� 'chocolade' ����� ���� �������� ���� ����� 'c' � �������� - ����� ��� ��������, ������� ������������� ����� �������. 
--���������: ���������� ������� ������ ����������� 2 ������.
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%cho_olade%'
--5.3	���������� ������� ��� ���������� � ����������( ������� Employees), ��� ������� ����� �� �������� (King ��� Kong).
SELECT *
FROM Employees
WHERE LastName LIKE 'K_ng%'

--6--
--6.2	����� ���-�� ������� �� ������� ������ 15%. 'NOT DONE'
SELECT Discount, COUNT(Quantity) AS [Total Number of Orders]
FROM [Order Details]
WHERE Discount > '0.15'
GROUP BY Discount
HAVING COUNT(Quantity) > 0.15
ORDER BY [Total Number of Orders] DESC;



--6.3	����� ����� ����� ���� ������� �� ������� Order Details � ������ ���������� ����������� ������� � ������ �� ���. 
--��������� ��������� �� �����. ������ (������� Discount) ���������� ������� �� ��������� ��� ������� ������. 
--��� ����������� �������������� ���� �� ��������� ������� ���� ������� ������ �� ��������� � ������� UnitPrice ����. 
--����������� ������� ������ ���� ���� ������ � ����� �������� � ��������� ������� 'Totals'.
SELECT 
ROUND(SUM(UnitPrice * (1 - Discount) * Quantity), 2) AS 'Totals'
FROM [Order Details];

--6.4	����� ������������ � ����������� �� ���� ������� �� ������� Order Details � ������ ���������� ����������� ������� � ������ �� ���. 
--��������� ��������� �� �����. ����������� ������� ������ ���� ���� ������ � ����� ��������� � ���������� 'MAX_ORDER' � 'MIN_ORDER'.
SELECT
MAX(UnitPrice) AS 'MAX_ORDER',
MIN(UnitPrice) AS 'MIN_ORDER'
FROM [Order Details]


--6.5	�� ������� Orders ����� ���������� �������, ������� ��� �� ���� ���������� (�.�. � ������� ShippedDate ��� �������� ���� ��������). 
--������������ ��� ���� ������� ������ �������� COUNT. �� ������������ ����������� WHERE � GROUP.
SELECT 
COUNT(*) - COUNT(ShippedDate) 
FROM Orders;

--6.6	�� ������� Orders ����� ���������� ��������� ����������� (CustomerID), ��������� ������. 
--������������ ������� COUNT � �� ������������ ����������� WHERE � GROUP.
SELECT 
COUNT(DISTINCT CustomerID) 
FROM Orders;

--7--
--7.1.	�� ������� Orders ����� ���������� ������� � ������������ �� �����. 
--� ����������� ������� ���� ����������� ��� ������� c ���������� Year � Total. 
--�������� ����������� ������, ������� ��������� ���������� ���� �������.
SELECT 
YEAR(OrderDate) AS 'Year', 
COUNT(OrderID) AS 'Total' 
FROM Orders 
GROUP BY Year(OrderDate);

SELECT COUNT(OrderID) 
FROM Orders;

--7.2.	�� ������� Orders ����� ���������� �������, ��������� ������ ���������. 
--����� ��� ���������� �������� � ��� ����� ������ � ������� Orders, ��� � ������� EmployeeID ������ �������� ��� ������� ��������. 
--� ����������� ������� ���� ����������� ������� � ������ �������� (������ ������������� ��� ���������� ������������� LastName & FirstName. 
--��� ������ LastName & FirstName ������ ���� �������� ��������� �������� � ������� ��������� �������. 
--����� �������� ������ ������ ������������ ����������� �� EmployeeID.) � ��������� ������� �Seller� � ������� c ����������� ������� ����������� � ��������� 'Amount'. 
--���������� ������� ������ ���� ����������� �� �������� ���������� �������. 
SELECT 
LastName+' '+FirstName  AS 'Seller', 
COUNT(OrderID) AS 'Amount' 
FROM Orders AS ord inner join Employees AS emp ON ord.EmployeeID = emp.EmployeeID
GROUP BY ord.EmployeeID, emp.LastName, emp.FirstName 
ORDER BY Amount DESC;

--7.3.	����� ����������� � ���������, ������� ����� � ����� ������. 
--���� � ������ ����� ������ ���� ��� ��������� ��������� ��� ������ ���� ��� ��������� �����������, �� ���������� � ����� ���������� � ��������� �� ������ �������� � �������������� �����. 
--�� ������������ ����������� JOIN. � ����������� ������� ���������� ������� ��������� ��������� ��� ����������� �������: �Person�, �Type� (����� ���� �������� ������ �Customer� ���  �Seller� � ��������� �� ���� ������), �City�. 
--������������� ���������� ������� �� ������� �City� � �� �Person�.
SELECT 
cu.ContactName AS 'Person', 
'Customer' AS 'Type',
cu.City 
FROM  Customers AS cu,Employees AS emp 
WHERE cu.City = emp.City
UNION
SELECT emp.FirstName+' '+emp.LastName AS 'Person','Seller' AS 'Type', cu.City FROM  Customers AS cu,Employees AS emp 
WHERE cu.City = emp.City 
ORDER BY  City, Person;

--7.4.	����� ���� �����������, ������� ����� � ����� ������. � ������� ������������ ���������� ������� Customers c ����� - ��������������. 
--��������� ������� CustomerID � City. ������ �� ������ ����������� ����������� ������. 
--��� �������� �������� ������, ������� ����������� ������, ������� ����������� ����� ������ ���� � ������� Customers. 
--��� �������� ��������� ������������ �������.
SELECT DISTINCT 
cu1.CustomerID,
cu1.City 
FROM Customers AS cu1 join Customers AS cu2 
ON cu1.City = cu2.City 
WHERE cu1.CustomerID<>cu2.CustomerID;

SELECT City 
FROM Customers 
GROUP BY City 
HAVING COUNT(City)>1;

--7.5.	�� ������� Employees ����� ��� ������� �������� ��� ������������, �.�. ���� �� ������ �������. 
--��������� ������� � ������� 'User Name' (LastName) � 'Boss'. 
--� �������� ������ ���� ��������� ����� �� ������� LastName. ��������� �� ��� �������� � ���� �������?
SELECT 
emp1.LastName,
emp2.LastName AS 'Boss' 
FROM Employees AS emp1 join Employees AS emp2 
ON emp1.ReportsTo = emp2.EmployeeID
WHERE emp1.LastName<>emp2.LastName; 

SELECT DISTINCT 
LastName 
FROM Employees;

--8--
--8.1.	������� ������ ������� � �����, ��� ��������, ����������� � �������. ������������ JOIN
SELECT OrderID, ContactName
FROM Orders 
INNER JOIN Customers AS c1
ON orders.CustomerID = c1.CustomerID
WHERE City = 'London'

--8.2.	���������� ���������, ������� ����������� ������ 'Western' (������� Region). 
--���������� ������� ������ ����������� ��� ����: 'LastName' �������� � �������� ������������� ���������� ('TerritoryDescription' �� ������� Territories). 
--������ ������ ������������ JOIN � ����������� FROM. 
--��� ����������� ������ ����� ��������� Employees � Territories ���� ������������ ����������� ��������� ��� ���� Northwind.
SELECT 
(
SELECT LastName 
FROM Employees 
WHERE EmployeeID = emp.EmployeeID) AS 'LastName'  , 
ter.TerritoryDescription 
FROM EmployeeTerritories AS emp INNER JOIN Territories AS ter 
ON emp.TerritoryID = ter.TerritoryID 
WHERE ter.RegionID = 
(
SELECT 
RegionID 
FROM Region 
WHERE RegionDescription = 'Western');

--8.3.	������� ����������� � �������� ���������, ��� ��������� ��������� Seafood
SELECT CompanyName, ProductName
FROM Suppliers AS s1
INNER JOIN Products AS p1
ON s1.SupplierID = p1.ProductID
INNER JOIN Categories AS c1
ON c1.CategoryName = 'Seafood'

--9--
--9.1.	��������� � ����������� ������� ����� ���� ���������� �� ������� Customers � ��������� ���������� �� ������� �� ������� Orders. 
--������� �� ��������, ��� � ��������� ���������� ��� �������, �� ��� ����� ������ ���� �������� � ����������� �������. 
--����������� ���������� ������� �� ����������� ���������� �������.
SELECT 
(
SELECT 
ContactName 
FROM Customers 
WHERE CustomerID = ord.CustomerID
) AS 'ContactName',COUNT(ord.OrderID) AS 'Amount'
FROM Customers AS cu FULL JOIN Orders AS ord 
ON cu.CustomerID = ord.CustomerID 
GROUP BY ord.CustomerID 
ORDER BY Amount;
--9.2.	������� �������� ���� ��������� � ������ �������, ��������� � ����. 
--�������� �������� �������� ���� � ��� ������, ���� ��� ���� ��� �� ������ ������
SELECT
    ProductName, OrderID
FROM
    Products CROSS JOIN Orders

--9.3.	������� ����� �������� (ContactName) � ��������� (LastName), ������� ����� � ����� ������. 
--�������� ����� ��������, ���� ���� � �� ������ ��� ��������� � ��������.
SELECT c.ContactName AS Person, 'Customer' AS Type,c.City AS City
FROM Customers AS c
WHERE EXISTS (
              SELECT e.City 
              FROM Employees AS e
              WHERE e.City=c.City
              )
UNION ALL
SELECT e.FirstName+' '+e.LastName AS Person, 'Seller' AS Type,e.City AS City
FROM Employees AS e
WHERE EXISTS (
              SELECT c.City 
              FROM Customers AS c
              WHERE e.City=c.City
              )
--9.4.	������� ��� ��������� ���������� ������� �� ���������� (TerritoryDescription) � �������� (RegionDescription) 
SELECT
    TerritoryDescription, RegionDescription
FROM
    Territories CROSS JOIN Region


--10--
--10.1.	��������� ���� ����������� ������� CompanyName � ������� Suppliers, � ������� ��� ���� �� ������ �������� �� ������ (UnitsInStock � ������� Products ����� 0). 
--������������ ��������� SELECT ��� ����� ������� � �������������� ��������� IN. 
--����� �� ������������ ������ ��������� IN �������� '=' ?
SELECT 
CompanyName 
FROM Suppliers 
WHERE SupplierID not in 
(
SELECT 
SupplierID 
FROM Products 
WHERE UnitsInStock = 0
);
--10.2.	������� ����� ������ ��� ��������, ������� �� ����� �� ������ ������. ��  ������������ EXISTS.
SELECT ContactName
FROM Customers AS C
WHERE (SELECT O.CustomerID
FROM Orders AS O 
WHERE C.CustomerID = O.CustomerID AND O.ShippedDate = 0
GROUP BY O.CustomerID) IS NULL

--10.3.	������� ������� ��������, � ������� ���� ������ ����� 01.01.1997 �  01.03.1997
SELECT ContactName
FROM Customers AS C
WHERE (SELECT O.CustomerID 
FROM Orders AS O 
WHERE C.CustomerID = O.CustomerID AND O.ShippedDate BETWEEN '1997-01-01' AND '1997-03-01' 
GROUP BY O.CustomerID) IS NOT NULL

--11--

--11.1.	��������� ���� ���������, ������� ����� ����� 150 �������. ������������ ��������� ��������������� SELECT.
SELECT 
LastName 
FROM Employees
WHERE EmployeeID in
(
SELECT 
EmployeeID 
FROM Orders 
GROUP BY EmployeeID 
HAVING Count(OrderID)>150
);

--11.2.	������� ���������, ������� ����������� ����� 5 ����������
SELECT S.LastName, 
(SELECT COUNT(*) 
FROM Orders AS O 
WHERE S.EmployeeID = O.ShipVia)
FROM Employees AS S
WHERE (SELECT COUNT(*) 
FROM Orders AS O 
WHERE S.EmployeeID = O.ShipVia) > 5
--12--
--12.1.	��������� ���� ���������� (������� Customers), ������� �� ����� �� ������ ������ (��������� �� ������� Orders). 
--������������ ��������������� SELECT � �������� EXISTS.
SELECT 
ContactName 
FROM Customers as cu
WHERE NOT EXISTS 
(
SELECT * FROM Orders as ord
WHERE cu.CustomerID = ord.CustomerID);

--12.2.	�������� ������� ���������, ������ ����  ���� �� ���� �� ��� ��������� � �������
SELECT C.ContactName, 
(SELECT ShipCity 
FROM Orders AS O 
WHERE O.CustomerID = C.CustomerID 
GROUP BY O.ShipCity)
FROM Customers AS C
WHERE C.City = 'London'

--13--
--13.1.	��� ������������ ����������� ��������� Employees ��������� �� ������� Employees ������ ������ ��� ���� ��������, 
--� ������� ���������� ������� Employees (������� LastName) �� ���� �������. ���������� ������ ������ ���� ������������ �� �����������.
SELECT DISTINCT 
SUBSTRING(LastName,1,1) AS '����������_������' 
FROM Employees 
ORDER BY ����������_������;

--13.2.	������� ������� ���� ��������� � ������� ��������
SELECT UPPER(ContactName) AS 'ContactName' 
FROM Customers
--13.3.	������� � ������� ������ ����� �������� �����������
SELECT UNICODE(ContactName) AS 'ContactName'
FROM Suppliers
--13.4.	������� ����� ��������, ������� � 4 �������. ��������� ������ ����  ������������ �� ��������
SELECT SUBSTRING(FirstName,4,11) AS '�����_�����' 
FROM Employees ORDER BY '�����_�����' DESC

--13.5.	������� ������� ���������, ����� � ������� '����� �������' ������� ����� �������. ��������� ������ ���� ������������ �� ��������
SELECT CompanyName, LEN(CompanyName) AS '����� ��������'
FROM Customers
ORDER BY CompanyName

--13.6.	������� �������� ��������� ����� ������ � � ������ ��������
SELECT LOWER(ProductName) AS '�������� ���������'
FROM Products
UNION
SELECT REVERSE(ProductName) AS '�������� ���������'
FROM Products
--14--
--14.1.	��������� �����, ���������� ������������ ������ � ������� ��� � 
--������ ���������� ����������� ������� � ������ �� ���. 
--������ �������� ������ ����� ������� ������ 5000. 

SELECT CONVERT( DATETIME, o.OrderDate, 120) AS '������������ ����� ��', 
max(od.UnitPrice*od.Quantity*(1-od.Discount)) as '������������ �����'
FROM Orders O
	JOIN [Order Details] OD
	ON O.OrderID=OD.OrderID
	GROUP BY OrderDate
	HAVING max(od.UnitPrice*od.Quantity*(1-od.Discount)) >= 5000

--14.2.	������� 2-� ������ �� ���������� ������� ���������, �� ������ 50 ���
SELECT TOP (2) e.LastName 
FROM Employees AS e
inner join Orders AS o
ON e.EmployeeID = o.EmployeeID
WHERE e.BirthDate > datediff( year, -50, getdate() )
GROUP BY e.LastName
ORDER BY count(*) DESC


--����� 2--

--1.	������� �������� ������� Copy_Shippers, ��������� ����������� �� ��������� ������� Shippers.
CREATE TABLE Copy_Shippers(
ShipperID int PRIMARY KEY NOT NULL,
CompanyName nvarchar(40) NOT NULL,
Phone nvarchar(24) NULL,)

--2.	����������� ��� ������ �� ������� Shippers � �������  Copy_Shippers � ������� �������������� ������� INSERT .
INSERT INTO Copy_Shippers 
SELECT ShipperID, CompanyName, Phone 
FROM Shippers

--3.	�������� � �������  Copy_Shippers  �������� �������� � ����� 1,�� �������� �Best Shipping�.  
--��� �� ���������, ���� �� �������� � ����� 1 �� ������������ � �������?  
UPDATE Copy_Shippers 
SET CompanyName='Best Shipping' 
WHERE ShipperID=1
-- �����: ������ ������ �� ������� ��.
--select CompanyName
--from Copy_Shippers--
--where ShipperID=1--
--4.	������� �� ������� ������� ��� ������ �� �������. �� ��������� ��������� �������� � �� ������ ��������� ���� ������.
DELETE FROM Orders 
WHERE ShipCity = 'London'
--5.	������� �� ������� Order Details ��� ������ � OrderID = '10251'  �  ProductID = '22' .
DELETE FROM [Order Details]
WHERE OrderID = '10251' AND ProductID = '22'
--6.	�������  ������� Copy_Shippers � Shippers. ��������� ���������� ���������.
DROP TABLE Copy_Shippers, Shippers
-- ������� Shippers �� "����������", �.�. ���� ����������� � ������ �������� �� � �����.

--7.	������� ��������� �������  TemporaryEmployees � ����� ������: ID(��������� ����)� Notes. 
--�������� � ��� ������ �� ������� Employees(���� EmployeeID,Notes ��������������). 
--��������� ���������� ��������� ������ �������� �� ��������� �������.
CREATE TABLE TemporaryEmployees(
EmployeeID int PRIMARY KEY NOT NULL,
Notes ntext NULL,)

INSERT INTO TemporaryEmployees 
SELECT EmployeeID, Notes 
FROM Employees

SELECT *
FROM TemporaryEmployees

--8.	�������� � �������  Suppliers ����� �������  Notes ���� VARCHAR(100). 
--����� ������������� ��� � �������.
ALTER TABLE Suppliers 
ADD Notes777 VARCHAR (100) NULL 
--����� �������� � ������ ������� ������ ���� �����������. ��� ������� "Notes" � ������� "Suppliers" ������� ����� ������ ����.
ALTER TABLE Suppliers 
DROP COLUMN Notes777