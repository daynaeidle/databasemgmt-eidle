-- Dayna Eidle --
-- Database Management --
-- Lab 4 --
-- Due: October 2, 2017 --

-- #1 -- 
select city
from Agents
where aid in (select aid
		from Orders
		where cid = 'c006');

-- #2 -- 
select distinct pid
from Orders
where aid in (select aid
		from Orders
		where cid in (select cid
				from Customers
				where city = 'Beijing')
		)
order by pid DESC;

-- #3 -- 
select cid, name
from Customers
where cid not in (select cid
		  from Orders
		  where aid = 'a03');

-- #4 --
select distinct cid
from Orders
where cid in (select cid
		from Orders
		where pid = 'p01')
and cid in (select cid
	    from Orders
	    where pid = 'p07');

-- #5 -- 
select pid
from Orders
where cid not in (select cid
		   from Orders
		   where aid = 'a02' or aid ='a03')
order by pid DESC;

-- #6 -- 
select name, discountPct, city
from Customers
where cid in (select cid
		from Orders
		where aid in (select aid
				from Agents
				where city = 'Tokyo' or city = 'New York')
		);

-- #7 -- 
select *
from Customers
where discountPct in (select discountPct
			from Customers
			where city = 'Duluth' or city = 'London');

-- #8 --
/*
A check constraint is a specification added when creating a table to 
ensure that the values of a column meet a certain condition. Check 
constraints are useful when there are a small amount of specific values
that could be entered into a column as a value. An example of this could
be putting a check contraint on a gender column. The check constraint for
that column could be: gender text CHECK (gender = 'male' or gender = 'female'
					  or gender = 'other');
This would be a good use of a check contraint because any value aside from
male, female, or other shouldn't be accepted into the database, therefore
should warrant an error. Check contraints are also helpful if the values of a
column need to meet a certain condition like needing to be a positive
value for a price column. By setting constraints for columns to be specific
values or to meet a certain condition, it makes the database more accurate
because all values entered will be what they're meant to be. An unnecessary
check constraint would be checking a value that there are a large amount of. 
For instance, if there was a column in a table for "Favorite Pizza Topping", 
adding a check constraint of specific values would be useless because, most 
likely, someone could add a topping that wasn't on the specified list of values 
because there are so many different toppings. 
*/
