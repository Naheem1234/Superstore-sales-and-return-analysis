# Superstore-sales-and-return-analysis

### Project Overview

This project provides an in-depth analysis of Superstore’s sales, returns, and regional performance based on historical transaction data. The dataset consists of three primary tables: Orders, Returns, and People. Key insights include overall sales trends, profitability, high-return products, and the impact of regional sales strategies. The findings aim to help the company optimize inventory management, reduce losses, and improve customer satisfaction.

### Data Sources

Superstore Sales Data: The primary dataset used for this analysis is the "Sample-Superstore.CSV" file, which contains detailed information about the sales made by the superstore.

### Tools

- MySQL: Data cleaning, Data Analysis
- Microsoft Word: Report

### Exploratory Data Analysis

EDA invloved using the superstore sales data to answer key questions such as:

- Sales Performance Trend: Identify key trends in sales and profitability across years, categories and customer segments.
- Profitability Analysis: Understand the profit distribution and the high profit vs low profit products in regards to their profit margin.
- Returns & Loss Analysis: Evaluate the return rate by category, financial impact of returns and the order return trends.
- Regional Sales Performance: Analyze to determine the top performing regions, the performance of the managers and the cities driving the highest sales and profitability.

### Data Analysis
Includes some of the queries used to draft insight

```sql
SELECT DATE_FORMAT(DATE_ADD('1899-12-30', INTERVAL `Order Date` DAY),'%Y-%m') AS Months, SUM(Sales) AS `Total Revenue`
FROM superstore
GROUP BY Months
ORDER BY `Total Revenue`;
```

```sql
SELECT DATE_FORMAT(DATE_ADD('1899-12-30', INTERVAL `Order Date` DAY), '%Y') AS Year, SUM(Sales) AS `Total Revenue`
FROM superstore
GROUP BY Year
ORDER BY `Total Revenue`;
```

```sql
SELECT Segment, COUNT(DISTINCT `Order ID`)
FROM superstore
GROUP BY Segment
ORDER BY COUNT(DISTINCT `Order ID`) DESC;
```

```sql
SELECT Category, Returned, COUNT(Returned) AS `return-rate`
FROM superstore
GROUP BY Category, Returned
HAVING Returned = "Yes";
```

```sql
SELECT SUM(Loss)
FROM (SELECT State, SUM(Profit) AS Loss
      FROM superstore
      GROUP BY State
      HAVING Loss < 1) AS Sub;
```

### Results

Some of the Analysis Results are Summarized as follows -the full results is in the main report file:

1. Yearly Revenue Trend: In 2014, the total revenue was $481,763.798 which reduced in 2015 by 3.6% but increased in 2016 by 124.8% from 2014 and further increased to 150.49% in 2017.
2. While Furniture had the second most generated revenue of $733,046.861, it generated the least profit of $16,980.771.
3. The West contributed most to the profit by contributing 37.48% ($106,021.15) of the total profit.
4. Office Supplies has a return rate 58.21% which equates to 450 returns from the total returns.
5. The superstore lost a total of $177,168.677 revenue due to the returns.
6. The superstore had the highest return influx in 2017 which resuleted to a total of 275 returns.
7. Anna Andrendi, the manager of the west contributed 31.40% to the revenue and also had a return rate of 61.32% from the total returns.
8. California contributed $74,669.204 to the total profit and $450,567.592 to the total revenue generated.
9. Texas, Ohio, Pennsylvania, Illinois, North Carolina, Colorado, Tennessee, Arizona, Florida, Oregon collectively contributed a loss of $97,368.42 to the company’s profit.

### Recommendations

Based on the Analysis, the following actions are recommended:

- Capitalize on high sales in Q4 (October – December) with focused promotions, while addressing the weaker revenue in January and February. Also, target high-growth regions with additional marketing to boost overall performance.
- Investigate the furniture category’s low profit despite high revenue and evaluate product pricing strategies, balancing high margin but low volume items against low margin, high profit ones.
- Leverage the consumer segment (over 50% of orders) by investing in frequently purchased items like binders and maintaining standard class shipping, which all segments prefer.
- Analyze the link between strong managerial performance and higher return rates especially in December to develop strategies that reduce post sale return.

### Limitations
The date part of the data was not cleaned even though i cleaned it with "DATE_FORMAT" and "DATE_ADD" functions, it is only temporary cleaning to get what i needed and not permanent cleaning. So permanent cleaning is a better option to go about it to avoid writing long queries anytime the date part of the data is needed for an insight.




