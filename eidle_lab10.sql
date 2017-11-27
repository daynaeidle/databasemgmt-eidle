-- Dayna Eidle --
-- Lab 10 --
-- Database Management --
-- Due: 11/27/2017 --

-- #1
-- Create a function that returns the immediate prerequisites for the passed-in course number

create or replace function getPreReqsFor(int, REFCURSOR) returns refcursor as 
$$
declare
   course int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for
   select name, num
   from courses
   where num in (select prereqnum
		from   prerequisites
		where  coursenum = course);
   return resultset;
end;
$$ 
language plpgsql;

-- testing
select getPreReqsFor(499, 'results');
Fetch all from results;

-- #2
-- Create a function that returns the courses for which the passed-in course is an immediate prerequisite

create or replace function isPreReqFor(int, REFCURSOR) returns refcursor as 
$$
declare
   course int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for
   select name, num
   from courses
   where num in (select coursenum
		from   prerequisites
		where  prereqnum = course);
   return resultset;
end;
$$ 
language plpgsql;

-- testing
select isPreReqFor(120, 'results');
Fetch all from results;

-- I might come back and give my Jedi skills a try after finishing the final project