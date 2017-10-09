-- Dayna Eidle --
-- Lab 5 --
-- Database Management --
-- Due: October 9, 2017 --

-- #1 --
-- Cities of agents booking an order for a customer whos cid is 'c006' w/ joins
select city
from agents a inner join orders o on a.aid = o.aid
where o.cid = 'c006';

-- #2 --
-- Ids of products ordered through any agent who makes AT LEAST one order for a customer in Beijing
-- sorted by PID from highest to lowest w/ joins
select distinct o2.pid
		--checks for order matching correct customer
from orders o1 inner join customers c on o1.cid = c.cid
		--shows agents orders for customers in Beijing (and agent info)
		inner join agents a on c.city = 'Beijing'
		--adds on orders from customers not from Beijing and gets rid of mismatched agent ids
		inner join orders o2 on o1.aid = o2.aid
order by pid DESC;

-- #3 --
-- Names of customers who have never placed an order w/ a subquery.
select name
from customers
where cid not in (select cid
		  from orders);

-- #4 --
-- Names of customers who never placed an order w/ an outer join
select c.name
from customers c left outer join orders o on c.cid = o.cid
where o.ordno is NULL;

-- #5 --
-- Names of customers who placed at least one order with an agent in their own city, along with those agent(s) names
select distinct c.name, a.name
from orders o inner join customers c on o.cid = c.cid
	      inner join agents a on o.aid = a.aid
where c.city = a.city;

-- #6 --
-- Names of customers and agents living in the same city along with the name of the shared city,
-- regardless of whether or not the customer has placed an order with that agent or not
select c.name, a.name, c.city
from customers c inner join agents a on c.city = a.city;

-- #7 --
-- Name and city of customers who live in the city that makes the FEWEST different kinds of products
select name, city
from customers
where city in (select city
		from products
		-- this counts products in each city
		group by city
		order by count(*) ASC
		-- gets city with fewest products
		limit 1);