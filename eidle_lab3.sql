-- Dayna Eidle --
-- Database Management --
-- Lab 3 --

-- #1 --
select ordno, totalusd
from Orders;

-- #2 --
select name, city
from Agents
where name = 'Smith';

-- #3 --
select pid, name, priceUSD
from Products
where qty > 200010;

-- #4 --
select name, city
from Customers
where city = 'Duluth';

-- #5 --
select name
from Agents
where city != 'New York' and city != 'Duluth';

-- #6 --
select *
from Products
where city != 'Dallas' and city != 'Duluth' and priceUSD >= 1;

-- #7 --
select *
from Orders
where month = 'May' or month = 'Mar';

-- #8 --
select *
from Orders
where month = 'Feb' and totalUSD >= 500;

-- #9 --
select *
from Orders
where cid = 'c005';