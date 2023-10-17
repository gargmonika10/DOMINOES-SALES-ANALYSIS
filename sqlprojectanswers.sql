..........1.list the total sales amount for each customer, including their first and last name.......

select c.firstname,lastname,sum(o.totalamount) as totalamount
from customers c
inner join orders o
on c.customerid=o.customerid
group by firstname,lastname;


......2. Find the orders where total amount is higher than the avg total amount of all orders.....

select avg(totalamount)
from orders;


select orderid,orderdate,(totalamount)
from orders 
where totalamount>(select avg(totalamount)
from orders)
;


.................3. calculate the total quantity and subtotal for each product in the orderdetails table.....

select o.productid,sum(o.quantity) as totalquantity,sum(o.subtotal)
from orderdetails o
inner join products p
on o.productid = p.productid
group by productid;

select productid,sum(quantity),sum(subtotal)
from orderdetails
group by productid;





select o.productid,p.productname,sum(o.quantity) as totalquantity,sum(o.subtotal)
from orderdetails o
inner join products p
on o.productid = p.productid
group by productid,productname;


........... 4.create a report that shows whether an orders total amount is high,medium,or low based on the following ranges(>=1500),medium(>=1000),low(<1000)

select orderid,totalamount,
case
when totalamount>=1500 then 'high'
when totalamount>=1000 then 'medium'
else 'low'
end as category
from orders;


........... 5. rank the employee based on the total number of orders they have processed........

select employeeid,count(orderid)
from orders
group by employeeid;


select employeeid,count(orderid),
rank() over(order by count(orderid)desc) as orderrank
from orders
group by employeeid;


select employeeid,count(orderid),
dense_rank() over(order by count(orderid)desc) as orderrank
from orders
group by employeeid;

select employeeid,count(orderid),
rank() over(order by count(orderid)desc) as orderrank,
dense_rank() over(order by count(orderid)desc) as dense_orderrank
from orders
group by employeeid;



............6. list the products that have been orderd more than the average quantity orders across all products


select avg(quantity)
from orderdetails;

select productid,sum(quantity)
from orderdetails 
group by productid
having sum(quantity) > (select avg(quantity) from orderdetails);



retrieve the customer details along with the employees first and last name who handle their orders.

select c.customerid as customerid,c.firstname as customerfirstname,c.lastname as customerlastname,
e.employeeid as employeeid,e.firstname as employeefirstname,e.lastname as employeelastname
from customers c
inner join orders o
on c.customerid= o.customerid
inner join employees e
on o.employeeid= e.employeeid;


select o.orderid,c.*,o.employeeid,e.firstname,e.lastname
from customers c,orders o,employees e
where o.customerid=c.customerid and o.employeeid=e.employeeid;



...........8. list the total quantity sold and the average price per product category........
select category,avg(price)
from products
group by category;

select p.category,sum(o.quantity),avg(p.price)
from products p
inner join orderdetails o
on p.productid=o.productid
group by p.category;


..........9.. list the customers who have placed orders more than the average numer of orders.

select customerid,count(orderid) as ordercust
from orders
group by customerid;


 
select avg(ordercust)
from 
(select customerid,count(orderid) as ordercust
from orders
group by customerid) a
;


select customerid,count(orderid) 
from orders
group by customerid
having count(orderid)>
(
select avg(ordercust)
from
(
select customerid,count(orderid) as ordercust
from orders
group by customerid) a
);


select c.firstname,c.lastname
from customers c
where customerid in(
select customerid
from orders
group by customerid
having count(orderid)>
(
select avg(ordercust)
from
(
select customerid,count(orderid) as ordercust













from orders
group by customerid) a
));









