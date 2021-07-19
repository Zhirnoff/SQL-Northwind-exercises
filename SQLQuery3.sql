--1--
--1.1	Выбрать в таблице Orders заказы, которые были доставлены после 6 мая 1998 года (колонка ShippedDate) включительно и которые доставлены с ShipVia >= 2. 
--Формат указания даты должен быть верным при любых региональных настройках, согласно требованиям статьи 
--“Writing International Transact-SQL Statements” в Books Online раздел “Accessing and Changing Relational Data”. 
--Этот метод использовать далее для всех заданий. Запрос должен высвечивать только колонки OrderID, ShippedDate и ShipVia. 
--Пояснить почему сюда не попали заказы с NULL-ом в колонке ShippedDate.
SELECT OrderID, ShippedDate, ShipVia
FROM Orders
WHERE ShippedDate > 1998-05-06
--1.2	Вывести всю информацию по сотрудникам, у которых есть начальники.
SELECT *
FROM Employees
WHERE ReportsTo IS NOT NULL
--1.3	Выбрать из таблицы Employees имена и фамилии всех сотрудников старше 50-ти  лет. 
--Напротив имени каждого сотрудника в колонке с названием “Age” вывести его возраст.
SELECT LastName, FirstName, DATEDIFF(year, BirthDate, getdate()) AS Age
FROM Employees
WHERE DATEDIFF(year, BirthDate, getdate()) > 50;

--1.4	Написать запрос, который выводит только недоставленные заказы из таблицы Orders. 
--В результатах запроса высвечивать для колонки ShippedDate вместо значений NULL строку ‘Not Shipped’ – использовать системную функцию CASЕ. 
--Запрос должен высвечивать только колонки OrderID и ShippedDate.
SELECT OrderID, ShippedDate =
CASE 
WHEN ShippedDate is null THEN 'Not Shipped'
END
FROM Orders 
WHERE ShippedDate is null;
--1.5	Выбрать в таблице Orders заказы, которые были доставлены после 6 мая 1998 года (ShippedDate) не включая эту дату или которые еще не доставлены. 
--В запросе должны высвечиваться только колонки OrderID (переименовать в Order Number) и ShippedDate (переименовать в Shipped Date). 
--В результатах запроса высвечивать для колонки ShippedDate вместо значений NULL строку ‘Not Shipped’, для остальных значений высвечивать дату в формате по умолчанию.
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
--2.1	Вывести цены на единицу продуктов из таблицы Products, округлив их до целого. 
--Выводить только название продукта и цену на него. Использовать функцию CAST.
SELECT ProductName,
CAST (UnitPrice AS DEC(12)) AS UnitPrice
FROM Products
--2.2	Вывести цены на единицу продуктов из таблицы Products, округлив их до целого. 
--Выводить только название продукта и цену на него. Использовать функцию CONVERT.
SELECT ProductName,
CONVERT (DEC, UnitPrice, (12)) AS UnitPrice
FROM Products

--3--
--3.1	Выбрать из таблицы Customers всех заказчиков, проживающих в USA и Canada. 
--Запрос сделать с только помощью оператора IN. Высвечивать колонки с именем пользователя и названием страны в результатах запроса. 
--Упорядочить результаты запроса по имени заказчиков и по месту проживания.
SELECT 
ContactName, Country 
FROM Customers 
WHERE Country in ('USA','Canada') 
ORDER BY Country, ContactName;

--3.2	Выбрать из таблицы Customers всех заказчиков, не проживающих в USA и Canada. 
--Запрос сделать с помощью оператора IN. Высвечивать колонки с именем пользователя и названием страны в результатах запроса. 
--Упорядочить результаты запроса по имени заказчиков.
SELECT ContactName, Country 
FROM Customers 
WHERE Country not in ('USA','Canada') 
ORDER BY ContactName;
--3.3	Выбрать из таблицы Customers все страны, в которых проживают заказчики. 
--Страна должна быть упомянута только один раз и список отсортирован по убыванию. 
--Не использовать предложение GROUP BY. Высвечивать только одну колонку в результатах запроса. 
SELECT DISTINCT 
Country 
FROM Customers;
--3.4	Вывести следующую информацию о сотрудниках: город, фамилию и дату рождения. 
--Результаты запроса упорядочить по всем трем полям в порядке, который указан. 
--Объяснить, почему фамилии и даты рождения расположены “не совсем” по порядку.
SELECT City, LastName, BirthDate
FROM Employees
ORDER BY City, LastName, BirthDate

--4--
--4.1 Выбрать все заказы (OrderID) из таблицы Order Details (заказы не должны повторяться), 
--где встречаются продукты с количеством от 3 до 10 включительно – это колонка Quantity в таблице Order Details. 
--Использовать оператор BETWEEN. Запрос должен высвечивать только колонку OrderID.
SELECT DISTINCT 
OrderID
FROM [Order Details] 
WHERE Quantity BETWEEN 3 AND 10;
--4.2	Выбрать всех заказчиков из таблицы Customers, у которых название страны начинается на буквы из диапазона a и g. 
--Использовать оператор BETWEEN. Запрос должен высвечивать только колонки CustomerID и Country и отсортирован по Country. 
--Почему работает запрос с условием строчного регистра букв a и g – в БД страны начинаются с заглавной буквы?
SELECT CustomerID, Country 
FROM Customers 
WHERE Country BETWEEN 'a' AND 'g' 
ORDER BY Country;
--4.3	Выбрать всех заказчиков из таблицы Customers, у которых название страны начинается на буквы из диапазона a и g, не используя оператор BETWEEN.
SELECT CustomerID, Country 
FROM Customers 
WHERE Country > 'a' and Country < 'g' 
ORDER BY Country;

--5--
--5.1	Выбрать из таблицы  Customers все названия компаний, начинающиеся на “Fran”.
SELECT CompanyName
FROM Customers
WHERE CompanyName LIKE 'Fran%'
--5.2	В таблице Products найти все продукты (колонка ProductName), где встречается подстрока 'chocolade'. 
--Известно, что в подстроке 'chocolade' может быть изменена одна буква 'c' в середине - найти все продукты, которые удовлетворяют этому условию. 
--Подсказка: результаты запроса должны высвечивать 2 строки.
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%cho_olade%'
--5.3	Необходимо вывести всю информацию о сотруднике( таблица Employees), чья фамилия точно не известна (King или Kong).
SELECT *
FROM Employees
WHERE LastName LIKE 'K_ng%'

--6--
--6.2	Найти кол-во заказов со скидкой больше 15%. 'NOT DONE'
SELECT Discount, COUNT(Quantity) AS [Total Number of Orders]
FROM [Order Details]
WHERE Discount > '0.15'
GROUP BY Discount
HAVING COUNT(Quantity) > 0.15
ORDER BY [Total Number of Orders] DESC;



--6.3	Найти общую сумму всех заказов из таблицы Order Details с учетом количества закупленных товаров и скидок по ним. 
--Результат округлить до сотых. Скидка (колонка Discount) составляет процент из стоимости для данного товара. 
--Для определения действительной цены на проданный продукт надо вычесть скидку из указанной в колонке UnitPrice цены. 
--Результатом запроса должна быть одна запись с одной колонкой с названием колонки 'Totals'.
SELECT 
ROUND(SUM(UnitPrice * (1 - Discount) * Quantity), 2) AS 'Totals'
FROM [Order Details];

--6.4	Найти максимальный и минимальный из всех заказов из таблицы Order Details с учетом количества закупленных товаров и скидок по ним. 
--Результат округлить до сотых. Результатом запроса должна быть одна запись с двумя колонками с названиями 'MAX_ORDER' и 'MIN_ORDER'.
SELECT
MAX(UnitPrice) AS 'MAX_ORDER',
MIN(UnitPrice) AS 'MIN_ORDER'
FROM [Order Details]


--6.5	По таблице Orders найти количество заказов, которые еще не были доставлены (т.е. в колонке ShippedDate нет значения даты доставки). 
--Использовать при этом запросе только оператор COUNT. Не использовать предложения WHERE и GROUP.
SELECT 
COUNT(*) - COUNT(ShippedDate) 
FROM Orders;

--6.6	По таблице Orders найти количество различных покупателей (CustomerID), сделавших заказы. 
--Использовать функцию COUNT и не использовать предложения WHERE и GROUP.
SELECT 
COUNT(DISTINCT CustomerID) 
FROM Orders;

--7--
--7.1.	По таблице Orders найти количество заказов с группировкой по годам. 
--В результатах запроса надо высвечивать две колонки c названиями Year и Total. 
--Написать проверочный запрос, который вычисляет количество всех заказов.
SELECT 
YEAR(OrderDate) AS 'Year', 
COUNT(OrderID) AS 'Total' 
FROM Orders 
GROUP BY Year(OrderDate);

SELECT COUNT(OrderID) 
FROM Orders;

--7.2.	По таблице Orders найти количество заказов, сделанных каждым продавцом. 
--Заказ для указанного продавца – это любая запись в таблице Orders, где в колонке EmployeeID задано значение для данного продавца. 
--В результатах запроса надо высвечивать колонку с именем продавца (Должно высвечиваться имя полученное конкатенацией LastName & FirstName. 
--Эта строка LastName & FirstName должна быть получена отдельным запросом в колонке основного запроса. 
--Также основной запрос должен использовать группировку по EmployeeID.) с названием колонки ‘Seller’ и колонку c количеством заказов высвечивать с названием 'Amount'. 
--Результаты запроса должны быть упорядочены по убыванию количества заказов. 
SELECT 
LastName+' '+FirstName  AS 'Seller', 
COUNT(OrderID) AS 'Amount' 
FROM Orders AS ord inner join Employees AS emp ON ord.EmployeeID = emp.EmployeeID
GROUP BY ord.EmployeeID, emp.LastName, emp.FirstName 
ORDER BY Amount DESC;

--7.3.	Найти покупателей и продавцов, которые живут в одном городе. 
--Если в городе живут только один или несколько продавцов или только один или несколько покупателей, то информация о таких покупателя и продавцах не должна попадать в результирующий набор. 
--Не использовать конструкцию JOIN. В результатах запроса необходимо вывести следующие заголовки для результатов запроса: ‘Person’, ‘Type’ (здесь надо выводить строку ‘Customer’ или  ‘Seller’ в завимости от типа записи), ‘City’. 
--Отсортировать результаты запроса по колонке ‘City’ и по ‘Person’.
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

--7.4.	Найти всех покупателей, которые живут в одном городе. В запросе использовать соединение таблицы Customers c собой - самосоединение. 
--Высветить колонки CustomerID и City. Запрос не должен высвечивать дублируемые записи. 
--Для проверки написать запрос, который высвечивает города, которые встречаются более одного раза в таблице Customers. 
--Это позволит проверить правильность запроса.
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

--7.5.	По таблице Employees найти для каждого продавца его руководителя, т.е. кому он делает репорты. 
--Высветить колонки с именами 'User Name' (LastName) и 'Boss'. 
--В колонках должны быть высвечены имена из колонки LastName. Высвечены ли все продавцы в этом запросе?
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
--8.1.	Вывести номера заказов и Имена, для клиентов, проживающих в Лондоне. Использовать JOIN
SELECT OrderID, ContactName
FROM Orders 
INNER JOIN Customers AS c1
ON orders.CustomerID = c1.CustomerID
WHERE City = 'London'

--8.2.	Определить продавцов, которые обслуживают регион 'Western' (таблица Region). 
--Результаты запроса должны высвечивать два поля: 'LastName' продавца и название обслуживаемой территории ('TerritoryDescription' из таблицы Territories). 
--Запрос должен использовать JOIN в предложении FROM. 
--Для определения связей между таблицами Employees и Territories надо использовать графические диаграммы для базы Northwind.
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

--8.3.	Выбрать поставщиков и названия продуктов, для продуктов категории Seafood
SELECT CompanyName, ProductName
FROM Suppliers AS s1
INNER JOIN Products AS p1
ON s1.SupplierID = p1.ProductID
INNER JOIN Categories AS c1
ON c1.CategoryName = 'Seafood'

--9--
--9.1.	Высветить в результатах запроса имена всех заказчиков из таблицы Customers и суммарное количество их заказов из таблицы Orders. 
--Принять во внимание, что у некоторых заказчиков нет заказов, но они также должны быть выведены в результатах запроса. 
--Упорядочить результаты запроса по возрастанию количества заказов.
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
--9.2.	Вывести названия всех продуктов и номера заказов, связанных с ними. 
--Название продукта выводить даже в том случае, если для него нет ни одного заказа
SELECT
    ProductName, OrderID
FROM
    Products CROSS JOIN Orders

--9.3.	Вывести имена клиентов (ContactName) и продавцов (LastName), которые живут в одном городе. 
--Выводить имена клиентов, даже если в их городе нет продавцов и наоборот.
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
--9.4.	Вывести все возможные комбинации записей из территорий (TerritoryDescription) и регионов (RegionDescription) 
SELECT
    TerritoryDescription, RegionDescription
FROM
    Territories CROSS JOIN Region


--10--
--10.1.	Высветить всех поставщиков колонка CompanyName в таблице Suppliers, у которых нет хотя бы одного продукта на складе (UnitsInStock в таблице Products равно 0). 
--Использовать вложенный SELECT для этого запроса с использованием оператора IN. 
--Можно ли использовать вместо оператора IN оператор '=' ?
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
--10.2.	Вывести имена только тех клиентов, которые не имеют ни одного заказа. Не  использовать EXISTS.
SELECT ContactName
FROM Customers AS C
WHERE (SELECT O.CustomerID
FROM Orders AS O 
WHERE C.CustomerID = O.CustomerID AND O.ShippedDate = 0
GROUP BY O.CustomerID) IS NULL

--10.3.	Вывести фамилии клиентов, у которых есть заказы между 01.01.1997 и  01.03.1997
SELECT ContactName
FROM Customers AS C
WHERE (SELECT O.CustomerID 
FROM Orders AS O 
WHERE C.CustomerID = O.CustomerID AND O.ShippedDate BETWEEN '1997-01-01' AND '1997-03-01' 
GROUP BY O.CustomerID) IS NOT NULL

--11--

--11.1.	Высветить всех продавцов, которые имеют более 150 заказов. Использовать вложенный коррелированный SELECT.
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

--11.2.	Найдите продавцов, которые обслуживают более 5 территорий
SELECT S.LastName, 
(SELECT COUNT(*) 
FROM Orders AS O 
WHERE S.EmployeeID = O.ShipVia)
FROM Employees AS S
WHERE (SELECT COUNT(*) 
FROM Orders AS O 
WHERE S.EmployeeID = O.ShipVia) > 5
--12--
--12.1.	Высветить всех заказчиков (таблица Customers), которые не имеют ни одного заказа (подзапрос по таблице Orders). 
--Использовать коррелированный SELECT и оператор EXISTS.
SELECT 
ContactName 
FROM Customers as cu
WHERE NOT EXISTS 
(
SELECT * FROM Orders as ord
WHERE cu.CustomerID = ord.CustomerID);

--12.2.	Выводить фамилии продавцов, только если  хотя бы один из них проживает в Лондоне
SELECT C.ContactName, 
(SELECT ShipCity 
FROM Orders AS O 
WHERE O.CustomerID = C.CustomerID 
GROUP BY O.ShipCity)
FROM Customers AS C
WHERE C.City = 'London'

--13--
--13.1.	Для формирования алфавитного указателя Employees высветить из таблицы Employees список только тех букв алфавита, 
--с которых начинаются фамилии Employees (колонка LastName) из этой таблицы. Алфавитный список должен быть отсортирован по возрастанию.
SELECT DISTINCT 
SUBSTRING(LastName,1,1) AS 'Алфавитный_список' 
FROM Employees 
ORDER BY Алфавитный_список;

--13.2.	Вывести фамилии всех продавцов в верхнем регистре
SELECT UPPER(ContactName) AS 'ContactName' 
FROM Customers
--13.3.	Вывести в юникоде первые буквы названий поставщиков
SELECT UNICODE(ContactName) AS 'ContactName'
FROM Suppliers
--13.4.	Вывести имена клиентов, начиная с 4 символа. Результат должен быть  отсортирован по убыванию
SELECT SUBSTRING(FirstName,4,11) AS 'Часть_имени' 
FROM Employees ORDER BY 'Часть_имени' DESC

--13.5.	Вывести фамилии продавцов, рядом в столбце 'Длина фамилии' вывести длину фамилий. Результат должен быть отсортирован по алфавиту
SELECT CompanyName, LEN(CompanyName) AS 'Длина названия'
FROM Customers
ORDER BY CompanyName

--13.6.	Вывести названия продуктов задом наперёд и в нижнем регистре
SELECT LOWER(ProductName) AS 'Названия продуктов'
FROM Products
UNION
SELECT REVERSE(ProductName) AS 'Названия продуктов'
FROM Products
--14--
--14.1.	Составить отчет, содержащий максимальные заказы в разрезе дат с 
--учетом количества закупленных товаров и скидок по ним. 
--Причем выводить только суммы заказов больше 5000. 

SELECT CONVERT( DATETIME, o.OrderDate, 120) AS 'Максимальный заказ за', 
max(od.UnitPrice*od.Quantity*(1-od.Discount)) as 'Максимальный заказ'
FROM Orders O
	JOIN [Order Details] OD
	ON O.OrderID=OD.OrderID
	GROUP BY OrderDate
	HAVING max(od.UnitPrice*od.Quantity*(1-od.Discount)) >= 5000

--14.2.	Вывести 2-х лучших по количеству заказов продавцов, не старше 50 лет
SELECT TOP (2) e.LastName 
FROM Employees AS e
inner join Orders AS o
ON e.EmployeeID = o.EmployeeID
WHERE e.BirthDate > datediff( year, -50, getdate() )
GROUP BY e.LastName
ORDER BY count(*) DESC


--Часть 2--

--1.	Создать тестовую таблицу Copy_Shippers, полностью повторяющую по структуре таблицу Shippers.
CREATE TABLE Copy_Shippers(
ShipperID int PRIMARY KEY NOT NULL,
CompanyName nvarchar(40) NOT NULL,
Phone nvarchar(24) NULL,)

--2.	Скопировать все данные из таблицы Shippers в таблицу  Copy_Shippers с помощью многострочного запроса INSERT .
INSERT INTO Copy_Shippers 
SELECT ShipperID, CompanyName, Phone 
FROM Shippers

--3.	Заменить в таблице  Copy_Shippers  название компании с кодом 1,на компанию “Best Shipping”.  
--Что бы произошло, если бы компании с кодом 1 не существовало в таблице?  
UPDATE Copy_Shippers 
SET CompanyName='Best Shipping' 
WHERE ShipperID=1
-- Ответ: Запрос ничего не обновил бы.
--select CompanyName
--from Copy_Shippers--
--where ShipperID=1--
--4.	Удалить из таблицы заказов все заказы из Лондона. Не применять каскадное удаление и не менять структуру базы данных.
DELETE FROM Orders 
WHERE ShipCity = 'London'
--5.	Удалить из таблицы Order Details все заказы с OrderID = '10251'  и  ProductID = '22' .
DELETE FROM [Order Details]
WHERE OrderID = '10251' AND ProductID = '22'
--6.	Удалить  таблицы Copy_Shippers и Shippers. Объяснить полученный результат.
DROP TABLE Copy_Shippers, Shippers
-- Таблица Shippers не "дропнулась", т.к. есть зависимовти в других таблицах от её полей.

--7.	Создать временную таблицу  TemporaryEmployees с двумя полями: ID(первичный ключ)и Notes. 
--Вставить в нее данные из таблицы Employees(поля EmployeeID,Notes соответственно). 
--Проверить полученный результат полной выборкой из временной таблицы.
CREATE TABLE TemporaryEmployees(
EmployeeID int PRIMARY KEY NOT NULL,
Notes ntext NULL,)

INSERT INTO TemporaryEmployees 
SELECT EmployeeID, Notes 
FROM Employees

SELECT *
FROM TemporaryEmployees

--8.	Добавить в таблицу  Suppliers новый столбец  Notes типа VARCHAR(100). 
--Затем переименовать его и удалить.
ALTER TABLE Suppliers 
ADD Notes777 VARCHAR (100) NULL 
--Имена столбцов в каждой таблице должны быть уникальными. Имя столбца "Notes" в таблице "Suppliers" указано более одного раза.
ALTER TABLE Suppliers 
DROP COLUMN Notes777