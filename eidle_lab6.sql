-- Dayna Eidle --
-- Lab 6 --
-- Database Management --
-- Due: October 16, 2017

-- #1
-- Display the name and city of customers who live in any city that makes the	most different kinds of products.
-- (There are two cities that make the most different products. Return the name and city of customers from either
-- one of those)
select name, city
from customers
where city in (-- subquery for city with the most products
		select city
		from products
		-- this counts products in each city
		group by city
		order by count(*) DESC
		-- gets ONE city with most products
		limit 1);

-- #2
-- Display the names of products whose priceUSD is at or above the average priceUSD, in reverse-alphabetical	order
select name
from products
where priceUSD >= (select AVG(priceUSD)
		   from products)
order by name DESC;

-- #3
-- Display the customer name, pid ordered, and the total for all orders
-- sorted by total from high to low
select c.name, o.pid, o.totalusd
from orders o inner join customers c on o.cid = c.cid
order by o.totalusd DESC;

-- #4
-- Display all customer names in reverse alphabetical order and their total ordered and nothing more
-- Use coalesce to avoid showing nulls
select c.name, coalesce(SUM(totalUSD), 0)
from customers c left outer join orders o on c.cid = o.cid
-- group by name doesn't work because of ACME, cid distibguishes each customer
group by c.cid
order by c.name DESC;

-- #5
-- Display the names of all customers who bought products from agents based in Newark,
-- along with the names of the products they ordered, and the names of the agents who
-- sold it to them
select c.name, p.name, a.name
from orders o inner join customers c on o.cid = c.cid
	      inner join products p on o.pid = p.pid
	      inner join agents a on o.aid = a.aid
where a.city = 'Newark';

-- #6
-- Write a query to check the acuracy of the totaUSD column in the Orders table.
-- Display all rows in orders where orders.totalUSD is incorrect, if any
select *, round(((p.priceUSD * o.quantity) * (1-(c.discountPct/100))),2) as calculatedTotalAmt
from orders o inner join customers c on o.cid = c.cid
		inner join products p on o.pid = p.pid
where o.totalUSD != (p.priceUSD * o.quantity) * (1-(c.discountPct/100));

-- #7
-- What's the difference between LEFT OUTER JOIN and RIGHT OUTER JOIN?
-- A left outer join is a join that takes the first table listed (or the table on the left side) in the 
-- join and lists all of the values from that table with the matches of the condition given with the right 
-- side of the join. The condition given can be anything relating the two tables such as cid in the customers 
-- table and cid in the orders table. An example of an left outer join from the CAP database would be:
-- 
-- select *
-- from customers c left outer join orders o on c.cid = o.cid;
--
-- This takes all of the customers from the customers table and lists their information along with the orders that
-- correspond with them, given that c.cid is equal to o.cid. This means that even if a customer did not make an order, 
-- they would still be listed. If this query were switched around and had "right outer join" instead of "left outer join", 
-- then all of the orders from the orders table would be listed and only the customers who made those orders would be 
-- listed along with them (customers who did not make orders would be excluded). Right outer joins have the same concept 
-- of left outer joins except they take the table on the right side of the join and list all of those values with their 
-- corresponding matches from the table on the left side of the join.
