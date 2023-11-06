##Task 1 — Import Classic Car Model Database##

show databases;
use mintclassics;
show tables;
select * from customers
order by customernumber asc;

##Task 2 — Understanding the Mint Classics Database and Its Business Processes##

##Task 3 — Investigating Business Issues and Identifying Affected Tables##

#Are there products with high inventory but low sales? How can we optimize the inventory of such products?#

select productcode, productname, quantityinstock, totalordered, (quantityinstock - totalordered) as Inventoryshortage
from (
select p.productcode, p.productname, p.quantityinstock, sum(od.quantityordered) as totalordered
from mintclassics.products as p
left join mintclassics.orderdetails as od on p.productcode = od.productcode
group by p.productcode, p.productname, p.quantityinstock) as Inventorydata
where (quantityinstock - totalordered) > 0
order by inventoryshortage desc;

#Are all the warehouses currently in use still necessary? How can we review warehouses that have low or inactive inventory?#

select p.productname, w.warehousename, sum(p.quantityinstock) as Totalinventory
from mintclassics.products as p
join mintclassics.warehouses as w on p.warehousecode = w.warehouseCode
group by p.productname, w.warehouseName
order by Totalinventory asc;

select w.warehousecode, w.warehouseName, sum(p.quantityinstock) as Totalinventory
from mintclassics.warehouses as w
join mintclassics.products as p on w.warehousecode = p.warehousecode
group by w.warehousecode, w.warehouseName
order by Totalinventory desc;

#Is there a relationship between product prices and their sales levels? How can price adjustments impact sales?#

select p.productcode, p.productname, p.buyprice, sum(od.quantityordered) as Totalordered
from mintclassics.products as p
left join mintclassics.orderdetails as od on p.productCode = od.productCode
group by p.productcode, p.productname, p.buyprice
order by buyPrice desc;

#Who are the customers contributing the most to sales? How can sales efforts be focused on these valuable customers?#

select c.customernumber, c.customername, sum(o.ordernumber)as Totalsales
from mintclassics.customers as c
join mintclassics.orders as o on c.customerNumber = o.customerNumber
group by c.customernumber, c.customername
order by Totalsales desc;

#How can the performance of sales employees be evaluated using sales data?#

select e.employeenumber, e.firstname, e.lastname, e.jobtitle, sum(od.priceeach * od.quantityordered) as Totalsales
from mintclassics.employees as e
left join mintclassics.customers as c on e.employeeNumber =salesRepEmployeeNumber
left join mintclassics.orders as o on c.customerNumber = o.customerNumber
left join mintclassics.orderdetails as od on o.orderNumber = od.orderNumber
group by e.employeenumber, e.firstname, e.lastname, e.jobtitle
order by Totalsales desc;

#How can customer payment trends be analyzed? What credit risks need to be considered, and how can cash flow be managed?#

select c.Customernumber, c.Customername, p.Paymentdate, p.amount as Paymentamount
from mintclassics.customers as c
left join mintclassics.payments as p on c.customerNumber = p.customerNumber
order by Paymentamount desc;

#How can the performance of various product lines be compared? Which products are the most successful, and which ones need improvement or removal?#

select 	p.productline, 
		pl.textdescription as Productlinedescription, 
		sum(p.quantityinstock) as Totalinventory, 
		sum(od.quantityordered) as Totalsales,
		sum(od.priceeach * od.quantityordered) as Totalrevenue,
		(sum(od.quantityordered)/sum(p.quantityinstock))* 100 as Salestoinventorypercentage
from mintclassics.products as p
left join mintclassics.productlines as pl on p.productLine = pl.productLine
left join mintclassics.orderdetails as od on p.productCode = od.productCode
group by p.productLine, pl.textdescription
order by Salestoinventorypercentage desc;

#How can the company’s credit policies be evaluated? Are there any customers with credit issues that need to be addressed?#

select 	c.customernumber, c.customername, c.creditlimit, 
		sum(p.amount) as Totalpayment, 
        sum(p.amount) - c.creditlimit as Creditlimitdiffrence
from mintclassics.customers as c 
left join mintclassics.payments as p on c.customerNumber = p.customerNumber
group by c.customernumber, c.creditlimit
having  sum(p.amount)<c.creditLimit
order by Totalpayment asc;

##Task 4 — Formulating Recommendations to Address Business Issues##

/*In this task, I have conducted data analysis using SQL queries and formulated recommendations to address the inventory-related business problem. Here is the summary based on the questions posed:
Inventory Optimization : After analyzing the data, I found some products with high inventory but low sales. My recommendation is to reduce the inventory of these products. This can be achieved by either reducing the quantity ordered for these products or evaluating the actual demand for them. Reducing inventory will help in lowering storage costs and optimizing resource allocation.

2. Warehouse Review: Warehouse data indicates that there are warehouses with low or inactive inventory. I recommend conducting further reviews of these warehouses. Consider closing or consolidating inefficient or inactive warehouses. This will reduce warehouse rental costs and optimize inventory allocation.

3. Product Pricing Evaluation: The analysis of product prices reveals a relationship between price and sales performance. My recommendation is to carefully review product prices. Consider adjusting the prices of specific products with low sales. Price reductions can enhance the attractiveness of these products to customers and boost sales.

4. Customer Analysis: Customer data has helped identify valuable customers contributing significantly to sales. My recommendation is to focus sales efforts on these valuable customers. Provide special incentives to these customers and consider offering products that align with their preferences.

5. Employee Performance Evaluation: Sales employee data can be used to evaluate employee performance. I recommend looking into employees who have achieved or exceeded sales targets and rewarding them with incentives. Additionally, identify employees who may need improvement and provide necessary training or support.

6. Payment Analysis: Payment trends of customers have been analyzed, and I recommend monitoring payments regularly. Identify customers with poor payment trends and take follow-up actions to mitigate credit risks. Additionally, manage cash flow carefully to ensure optimal liquidity.

7. Product Line Review: The analysis has shown the performance of various product lines. Products with less success need further evaluation. Consider product improvements or, if necessary, discontinuation of inefficient products. This will help in enhancing the profitability of the product portfolio.

8. Credit Policy Evaluation: Lastly, I recommend conducting a thorough evaluation of the company’s credit policies. Identify customers with credit issues and consider providing solutions or making changes in credit policies to reduce credit risk.

By following these recommendations and involving data analysis, the company can optimize its operations, improve profitability, and provide better customer service.*/


##Task 5 — Crafting Conclusions and Recommendations with SQL Support##

/*The final task is to compile conclusions about the analysis process, key findings, and the recommendations I have designed. I will explain the steps taken and why I made certain decisions. I will also include SQL queries that support my findings as part of the portfolio uploaded to GitHub.

By completing all these tasks, I have gained experience in data analysis and the use of SQL to address business problems. The results of my work will be integrated into my GitHub portfolio to showcase my data analysis and SQL skills to potential employers.*/




