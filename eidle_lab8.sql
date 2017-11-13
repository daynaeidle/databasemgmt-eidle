-- Dayna Eidle --
-- Lab 8 --
-- Database Management --
-- Due: November 13, 2017 --


-- Drop tables if they already exist
DROP TABLE IF EXISTS ActsIn;
DROP TABLE IF EXISTS DirectorOf;
DROP TABLE IF EXISTS Actors;
DROP TABLE IF EXISTS Directors;
DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS Movies;

-- #3 --
-- Create statements for datebase

-- People -- 
CREATE TABLE People (
  pid         	   	char(4) not null,
  firstName	   	text not null,
  lastName	   	text not null,
  address	    	text,
  spouseFirstName 	text,
  spouseLastName   	text,
 primary key(pid)
);

-- Actors --
CREATE TABLE Actors (
  pid         		char(4) not null references People(pid),
  birthday		date not null,
  hairColor		text,
  eyeColor		text not null,
  height_in 		text not null,
  weight_lbs   		text not null,
  favColor		text,
  sagAnniversary	date,
 primary key(pid)
);

-- Directors --
CREATE TABLE Directors (
  pid         	char(4) not null references People(pid),
  filmSchool	text,
  dgAnniversary	date,
  favLensMaker	text,
 primary key(pid)
);

-- Movies --
CREATE TABLE Movies (
  MPAANum		int not null,
  name			text not null,
  yearReleased		int,
  domBoxOffSales 	int,
  foreignBoxOffSales 	int,
  dvdBlueRayBoxOffSales	int,
 primary key(MPAANum)
);

-- ActsIn --
CREATE TABLE ActsIn (
  pid         	char(4) not null references Actors(pid),
  MPAANum	int not null references Movies(MPAANum),
 primary key(pid,MPAANum)
);

-- DirectorOf --
CREATE TABLE DirectorOf(
  pid         	char(4) not null references Directors(pid),
  MPAANum	int not null references Movies(MPAANum),
 primary key(pid,MPAANum)
);


-- #4 --
-- Write a query to show all the directors with whom actor “Roger Moore” has worked
-- **he could work with directors as an actor OR as a codirector

-- gets info about director
select d.pid, p.firstName, p.lastName
from Directors d inner join People p on d.pid = p.pid
where d.pid in (select pid 
		from DirectorOf  --(below) gets movies that Roger has directed
		where MPAANum in(select d.MPAANum
					from DirectorOf d inner join People p on d.pid = p.pid
					where p.firstName = 'Roger' and p.lastName = 'Moore')
				--(below) gets movies that Roger has acted in
		and MPAANum in(select a.MPAANum
				from ActsIn a inner join People p on a.pid = p.pid
				where p.firstName = 'Roger' and p.lastName = 'Moore')
		)
-- Roger doesn't count as someone who worked with Roger
except
select d.pid, p.firstName, p.lastName
from Directors d inner join People p on d.pid = p.pid
where p.firstName = 'Roger' and p.lastName = 'Moore';
		


