USE samplestore;

SELECT * FROM superstore;
-- 1. Annual Sales Growth --
SELECT DATE_FORMAT(DATE_ADD('1899-12-30', INTERVAL `Order Date` DAY), '%Y-%m') AS Months, SUM(Sales) AS `Total Revenue`
FROM superstore
GROUP BY Months
ORDER BY `Total Revenue` ;

SELECT DATE_FORMAT(DATE_ADD('1899-12-30', INTERVAL `Order Date` DAY), '%Y') AS Year, SUM(Sales) AS `Total Revenue`
FROM superstore
GROUP BY Year
ORDER BY Year
;
-- Category performance -- 2. The most profitable product category --
SELECT Category, sum(Sales), SUM(Profit), SUM(Discount), SUM(Quantity)
FROM superstore
GROUP BY Category
ORDER BY SUM(Profit) DESC;

SELECT Region, SUM(Sales)
FROM superstore
GROUP BY Region
ORDER BY SUM(Sales) DESC;

SELECT State, SUM(Profit)
FROM superstore
GROUP BY State
ORDER BY SUM(Profit) DESC;

-- Customer Segment -- 
-- 3. Total orders per segment --
SELECT Segment, COUNT(DISTINCT `Order ID`)
FROM superstore
GROUP BY Segment
ORDER BY COUNT(DISTINCT `Order ID`) DESC;
-- 4. Total sales per segment --
SELECT Segment, SUM(Sales)
FROM superstore
GROUP BY Segment 
ORDER BY SUM(Sales) DESC;
-- 5. Total Profit per segment --
SELECT Segment, SUM(Profit)
FROM superstore
GROUP BY Segment 
ORDER BY SUM(Profit) DESC;
-- 6. Total Quantity ordered per segment --
SELECT Segment, SUM(Quantity)
FROM superstore
GROUP BY Segment 
ORDER BY SUM(Quantity) DESC;
-- 7. Average Order Value per Segment --
SELECT Segment, SUM(Sales)/COUNT(DISTINCT `Order ID`)
FROM superstore
GROUP BY Segment
ORDER BY SUM(Sales)/COUNT(DISTINCT `Order ID`) DESC;
-- 8. Average Discount per segment --
SELECT Segment, AVG(Discount)
FROM superstore
GROUP BY Segment
ORDER BY AVG(Discount) DESC;
-- 9. Most frequently purchased categories/sub-categories by segment --
SELECT Segment, Category, `Sub-Category`, COUNT(`Sub-Category`)
FROM superstore
GROUP BY Segment, Category, `Sub-Category`
HAVING Segment = 'Consumer'
ORDER BY COUNT(`Sub-Category`)DESC;

SELECT Segment, Category, `Sub-Category`, COUNT(`Sub-Category`)
FROM superstore
GROUP BY Segment, Category, `Sub-Category`
HAVING Segment = 'Corporate'
ORDER BY COUNT(`Sub-Category`)DESC;

SELECT Segment, Category, `Sub-Category`, COUNT(`Sub-Category`)
FROM superstore
GROUP BY Segment, Category, `Sub-Category`
HAVING Segment = 'Home Office'
ORDER BY COUNT(`Sub-Category`)DESC;
-- 10. Preferred shipmode per segment --
SELECT Segment, `Ship Mode`, COUNT(`Ship Mode`)
FROM superstore
GROUP BY segment, `Ship Mode`
HAVING Segment = "Home Office"
ORDER BY COUNT(`Ship Mode`) DESC;

SELECT Segment, `Ship Mode`, COUNT(`Ship Mode`)
FROM superstore
GROUP BY segment, `Ship Mode`
HAVING Segment = "Consumer"
ORDER BY COUNT(`Ship Mode`) DESC;

SELECT Segment, `Ship Mode`, COUNT(`Ship Mode`)
FROM superstore
GROUP BY segment, `Ship Mode`
HAVING Segment = "Corporate"
ORDER BY COUNT(`Ship Mode`) DESC;

-- 11. Profit distribution --
SELECT Region, SUM(Profit)
FROM superstore
GROUP BY Region
ORDER BY SUM(Profit) DESC;

SELECT Category, SUM(Profit)
FROM superstore
GROUP BY Category
ORDER BY SUM(Profit) DESC;
-- 12. high profit product (profit margin) --
SELECT `Sub-Category`, ((SUM(Profit)/SUM(Sales))*100), SUM(Profit)
FROM superstore
GROUP BY `Sub-Category`
ORDER BY ((SUM(Profit)/SUM(Sales))*100) DESC
LIMIT 5;
-- 13. low profit product (profit margin) --
SELECT `Sub-Category`, ((SUM(Profit)/SUM(Sales))*100), SUM(Profit)
FROM superstore
GROUP BY `Sub-Category`
ORDER BY ((SUM(Profit)/SUM(Sales))*100)
LIMIT 5;

SELECT DISTINCT Returned
FROM superstore;
-- 14. Return rate by category --
SELECT Category, Returned, COUNT(Returned) AS `return-rate`
FROM superstore
GROUP BY Category, Returned
HAVING Returned = "Yes";

-- 15. Financial Impact of returns--
SELECT Returned, SUM(Sales)
FROM superstore
GROUP BY Returned
HAVING Returned = "Yes";
-- 16. order return trends --
SELECT DATE_FORMAT(DATE_ADD('1899-12-30', INTERVAL `Order Date` DAY), '%Y-%m') AS Months, Returned, COUNT(Returned) AS Return_rate
FROM superstore
GROUP BY Months, Returned
HAVING Returned = 'Yes'
ORDER BY Return_rate DESC
;
SELECT DATE_FORMAT(DATE_ADD('1899-12-30', INTERVAL `Order Date` DAY), '%Y') AS Year, Returned, COUNT(Returned) AS Return_rate
FROM superstore
GROUP BY Year, Returned
HAVING Returned = 'Yes'
ORDER BY Year DESC
;
-- 17. top performing regions --
SELECT Region, Person, ((SUM(Profit)/SUM(Sales))*100), SUM(Sales)
FROM superstore
GROUP BY Region, Person
ORDER BY ((SUM(Profit)/SUM(Sales))*100) DESC;
-- 18. manager performance --
SELECT Person, Region, SUM(Sales)
FROM superstore
GROUP BY Person, Region
ORDER BY SUM(Sales) DESC;

SELECT Region, Person, Returned, COUNT(Returned) AS `return-rate`
FROM superstore
GROUP BY Region, Person, Returned
HAVING Returned = "Yes";

SELECT  DISTINCT Person, Region
FROM superstore;
-- 19. state level insight --
-- Top three profitable states --
SELECT State, SUM(Sales)
FROM superstore
GROUP BY State
ORDER BY SUM(Sales) DESC;

SELECT State, SUM(Profit)
FROM superstore
GROUP BY State
ORDER BY SUM(Profit) DESC;
-- Least profitable states --
SELECT State, SUM(Profit) AS Loss
FROM superstore
GROUP BY State
HAVING Loss < 1
ORDER BY Loss ;

SELECT SUM(Loss)
FROM ( SELECT State, SUM(Profit) AS Loss
FROM superstore
GROUP BY State
HAVING Loss < 1) AS Sub ;

SELECT Returned, COUNT(Returned)
FROM superstore
GROUP BY Returned
HAVING Returned = "Yes";

SELECT COUNT(Returned)
FROM superstore
WHERE Returned = "Yes";