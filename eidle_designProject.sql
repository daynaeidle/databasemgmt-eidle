-- Dayna Eidle
-- Database Design Project
-- Database Management
-- Due: December 4, 2017

DROP VIEW IF EXISTS Ages;
DROP VIEW IF EXISTS MostPopularQuiz;
DROP VIEW IF EXISTS UnusedActors;
DROP TABLE IF EXISTS ActsIn;
DROP TABLE IF EXISTS SnapchatVideoTags;
DROP TABLE IF EXISTS SnapchatVideos;
DROP TABLE IF EXISTS FavQuizzes;
DROP TABLE IF EXISTS QuizTags;
DROP TABLE IF EXISTS Quizzes;
DROP TABLE IF EXISTS SnapchatArticleTags;
DROP TABLE IF EXISTS SnapchatArticles;
DROP TABLE IF EXISTS TastyVideoTags;
DROP TABLE IF EXISTS TastyVideos;
DROP TABLE IF EXISTS TastyVideoTypes;
DROP TABLE IF EXISTS PopularLunches;
DROP TABLE IF EXISTS Catering;
DROP TABLE IF EXISTS TastyVidHands;
DROP TABLE IF EXISTS CreativePositions;
DROP TABLE IF EXISTS PositionDescriptions;
DROP TABLE IF EXISTS WebDesigners;
DROP TABLE IF EXISTS SnapchatStoryActors;
DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS OfficeLocations;

-- OfficeLocations --
CREATE TABLE OfficeLocations(
  officeid	char(4) not null,
  address	text not null,
  city		text not null,
  state_prov	text not null,
  postalCode	text not null,
  country	text not null,
 primary key(officeid)
);

-- People --
CREATE TABLE People (
  pid         	char(4) not null,
  firstName    	text not null,
  lastName     	text not null,
  birthdate 	date not null,
  address 	text not null,
  city		text not null,
  state_prov	text not null,
  postalCode	text not null,
  country	text not null, 
  officeid	char(4) not null references OfficeLocations(officeid),
 primary key(pid)
);


-- SnapchatStoryActors --
CREATE TABLE SnapchatStoryActors (
  pid          		char(4) not null references People(pid),
  hairColor       	text,
  eyeColor        	text,
  personalityType	text,
  hireDate		date not null,
 primary key(pid)
);        


-- TastyVidHands --
CREATE TABLE TastyVidHands (
  pid      	char(4) not null references People(pid),
  favNailColor	text,
  numRings     	integer,
  gender      	text CHECK (gender = 'female' or gender = 'male' or gender = 'other'),
  favFood 	text,
  hireDate 	date not null,
 primary key(pid)
);

-- PositionDescriptions --
CREATE TABLE PositionDescriptions(
  posid 	char(4) not null,
  positionTitle	text,
 primary key(posid)
);

-- CreativePositions --
CREATE TABLE CreativePositions (
  pid     	char(4) not null unique references People(pid),
  posid		char(4) not null references PositionDescriptions(posid) ,
  favBook     	text,
  hireDate 	date not null,
 primary key(pid)
);

-- WebDesigners --
CREATE TABLE WebDesigners (
  pid      		char(4) not null references People(pid),
  college		text,
  highestDegree     	text,
  favFrontEndLang     	text,
  hireDate 		date not null,
 primary key(pid)
);


-- SnapchatArticles --
CREATE TABLE SnapchatArticles(
  aid 	char(4) not null,
  topic text,
  pid 	char(4) not null references CreativePositions(pid),
 primary key(aid)
);

-- SnapchatArticleTags --
CREATE TABLE SnapchatArticleTags(
  aid char(4) not null references SnapChatArticles(aid),
  tag text,
 primary key(aid, tag)
);

-- Quizzes --
CREATE TABLE Quizzes(
  quizid 	char(4) not null,
  name		text,
  numQuestions	integer,
  type 		text,
 primary key(quizid)
);

-- QuizTags --
CREATE TABLE QuizTags(
  quizid 	char(4) not null references Quizzes(quizid),
  tag		text,
 primary key(quizid, tag)
);

-- FavQuizzes --
CREATE TABLE FavQuizzes(
  pid		char(4) not null references CreativePositions(pid),
  quizid	char(4) not null references Quizzes(quizid),
 primary key(pid, quizid)
);


-- Catering --
CREATE TABLE Catering(
  lunchid		char(4) not null,
  cateringCompany 	text,
  lunchDescription	text,
  cuisineType 		text,
 primary key(lunchid)
);

-- PopularLunches --
CREATE TABLE PopularLunches(
  officeid		char(4) not null references OfficeLocations(officeid),
  lunchid		char(4) not null references Catering(lunchid),
  dayOfWeekServed 	text CHECK(dayOfWeekServed = 'Monday' or dayOfWeekServed = 'Tuesday' or
				dayOfWeekServed = 'Wednesday' or dayOfWeekServed = 'Thursday' or
				dayOfWeekServed = 'Friday' or dayOfWeekServed = 'Saturday' or
				dayOfWeekServed = 'Sunday'),
 primary key(officeid)
);

-- SnapchatVideos --
CREATE TABLE SnapchatVideos(
  scvid		char(4) not null,
  topic 	text,
  vidStateLoc	text,
 primary key(scvid)
);

-- SnapchatVideoTags --
CREATE TABLE SnapchatVideoTags(
  scvid	char(4) not null references SnapchatVideos(scvid),
  tag	text,
 primary key(scvid, tag)
);

-- ActsIn --
CREATE TABLE ActsIn(
  scvid	char(4) not null references SnapchatVideos(scvid),
  pid 	char(4) not null references SnapchatStoryActors(pid),
 primary key(scvid, pid)
);

-- TastyVideoTypes --
CREATE TABLE TastyVideoTypes(
  typeCode		char(4) not null,
  typeDescription 	text,
 primary key(typeCode)
);

-- TastyVideos --
CREATE TABLE TastyVideos(
  tastyvid 	char(4) not null,
  name 		text,
  caption 	text,
  pid 		char(4) not null references TastyVidHands(pid),
  typeCode 	char(4) not null references TastyVideoTypes(typeCode),
 primary key (tastyvid)
);


-- TastyVideoTags --
CREATE TABLE TastyVideoTags(
  tastyvid	char(4) not null references TastyVideos(tastyvid),
  tag 		text not null,
 primary key(tastyvid, tag)
);


-- SQL Sample Data --

-- OfficeLocations --
INSERT INTO OfficeLocations(officeid, address, city, state_prov, postalCode, country)
  VALUES('o001', '111 E. 18th Street 13th Floor', 'New York', 'NY', '10003', 'USA'),
	('o002', '7323 Beverly Blvd', 'Los Angeles', 'CA', '90036', 'USA'),
	('o003', '1630 Connecticut Ave', 'Washington', 'DC', '20009', 'USA'),
	('o004', '40 Argyll Street', 'Soho', 'London', 'W1F 7EB', 'United Kingdom'),
	('o005', '989 Market St', 'San Francisco', 'CA', '94103', 'USA'),
	('o006', '17-19 Bridge Street (Tank Stream Way)', 'Sydney', 'NSW', '2000', 'Australia'),
	('o007', '355 Adelaide St W', 'Toronto', 'Ontario', 'M5V', 'Canada'),
	('o008', '52 MMGS Marg', 'Juhu', 'Maharashtra', '400049', 'India');

-- People --
INSERT INTO People(pid, firstName, lastName, birthdate, address, city, state_prov, postalCode, country, officeid)
  VALUES('p001', 'Jonah', 'Peretti', '1982-06-12', '6650 Franklin Ave', 'Los Angeles', 'CA', '90028', 'USA', 'o002'),
	('p002', 'Kenneth', 'Lerer', '1960-07-13', '709 Honey Creek Dr', 'New York', 'NY', '10028', 'USA', 'o001'),
	('p003', 'John', 'Johnson', '1964-11-28', '15 St Margarets Ln', 'New York', 'NY', '10033', 'USA', 'o001'),
	('p004', 'Lenke', 'Taylor', '1969-09-04', '438 Rush Green Rd', 'Romford', 'London', 'RM7 0LX', 'UK', 'o004'),
	('p005', 'Allison', 'Lucas', '1971-08-12', 'Shop 11, D Wing, Shanti Apt Mathuradas Ext Rd', 'Mumbai', 'Maharashtra', '400705', 'India', 'o008'),
	('p006', 'Ben', 'Smith', '1976-08-10', '7246 W. Windsor Dr', 'Carmichael', 'CA', '95608', 'USA', 'o002'),
	('p007', 'Ze', 'Frank', '1974-12-26', '601 Sherwood Ave', 'San Bernardino', 'CA', '92404', 'USA', 'o002'),
	('p008', 'Mark', 'Frackt', '1962-11-04', '4 Sunny Dr', 'Washington', 'DC', '20202', 'USA', 'o003'),
	('p009', 'Greg', 'Coleman', '1959-03-03', '33 Rosemary Ave', 'Washington', 'DC', '20252', 'USA', 'o003'),
	('p010', 'Lee', 'Brown', '1968-06-01', '187 Inglewood Dr', 'Toronto', 'Ontario', 'M4C 1A3', 'Canada', 'o007'),
	('p011', 'Tim', 'Beliveau', '1999-08-24', '45 Rose Street', 'Chippendale', 'NSW', '2008', 'Australia', 'o006'),
	('p012', 'Alan', 'Labouseur', '1968-03-27', '102, D-265, Sagar Ratan Bldg', 'Mumbai', 'Maharashtra', '400705', 'India', 'o008'),
	('p013', 'Ashley', 'Delucia', '1998-05-04', '30 High Holborn Street', 'Surry Hills', 'NSW', '2010', 'Australia', 'o006'),
	('p014', 'Matt', 'Corbman', '1998-10-17', '1688 Pine St #06', 'San Francisco', 'CA', '94109', 'USA', 'o005'),
	('p015', 'Elly', 'Hersam', '1998-04-09', '2805-2807 Harrison St', 'San Francisco', 'CA', '94110', 'USA', 'o005'),
	('p016', 'Mitchell', 'Godett', '1998-03-08', '25 Herbert Ave', 'Toronto', 'Ontario', 'M4C 1A3', 'Canada', 'o007'), 
	('p017', 'Ryan', 'Waystack', '1997-08-07', '35 Butterworth Ave', 'Toronto', 'Ontario', 'M4C 1A3', 'Canada', 'o007'), 
	('p018', 'Diana', 'Zogheb', '1998-04-02', '67 Brewery Road', 'Plumstead', 'London', 'SE18 1ND', 'UK', 'o004'),
	('p019', 'Paige', 'Krikorian', '1997-12-14', '7405 Wrangler St', 'Washington', 'DC', '20543', 'USA', 'o003'),
	('p020', 'Tea', 'Geraci', '1998-03-24', '170 King St UNIT 402', 'San Francisco', 'CA', '94107', 'USA', 'o005'),
	('p021', 'Nick', 'Dandola', '1990-02-14', '812 Thatcher Court', 'Yonkers', 'NY', '10701', 'USA', 'o001'),
	('p022', 'Brooke', 'Ballard', '1989-08-19', '85 Harrington Street', 'The Rocks', 'NSW', '2000', 'Australia', 'o006'),
	('p023', 'Jake', 'Mack', '1987-10-22', '110 Arthur Road', 'Wimbledon Park', 'London', 'SW19 8AA', 'UK', 'o004'),
	('p024', 'Matt', 'Richards', '1989-10-07', '19 Saki Vihar Road', 'Mumbai', 'Maharashtra', '400072', 'India', 'o008'),
	('p025', 'Darcy', 'Eidle', '1995-05-10', '42 Merriman Street', 'Millers Point', 'NSW', '2000', 'Australia', 'o006'),
	('p026', 'Chris', 'Briggs', '1994-05-17', '135 Arthur Street', 'Surry Hills', 'NSW', '2010', 'Australia', 'o006'),
	('p027', 'Guy', 'Fieri', '1974-07-04', '434 Galvin Dr', 'Washington', 'DC', '20266', 'USA', 'o003'),
	('p028', 'Joanna', 'Gains', '1980-08-05', '45 Mulgrave Road', 'Sutton', 'London', 'SM2 6LJ', 'UK', 'o004'),
	('p029', 'Chip', 'Gains', '1980-01-02', '45 Mulgrave Road', 'Sutton', 'London', 'SM2 6LJ', 'UK', 'o004'),
	('p030', 'Vince', 'Vaughn', '1970-03-28', '11/12 Shah Indl Area', 'Mumbai', 'Maharashtra', '400088', 'India', 'o008'),
	('p031', 'Owen', 'Wilson', '1968-11-18', '1 Ram Maruti Rd', 'Mumbai',  'Maharashtra', '400602', 'India', 'o008'),
	('p032', 'Jennifer', 'Aniston', '1969-02-11', '2857 22nd St', 'San Francisco', 'CA', '94110', 'USA', 'o005'),
	('p033', 'Adam', 'Sandler', '1966-09-06', '814 - 65 East Liberty St', 'Toronto', 'Ontario', 'M4C 1A3', 'Canada', 'o007'),
	('p034', 'Jennifer', 'Lawrence', '1990-08-15', '93 Bayport Ave', 'South Richmond Hill', 'NY', '11419', 'USA', 'o001'),
	('p035', 'Lisa', 'Kudrow', '1963-07-30', '237 N Bowling Green Way', 'Los Angeles', 'CA', '90049', 'USA', 'o002'),
	('p036', 'James', 'Corden', '1978-08-22', '64 Holbourne Ave', 'Toronto', 'Ontario', 'M4C 1A3', 'Canada', 'o007'), 
	('p037', 'Tommy', 'Magnusson', '1998-01-01', '44 Trusel St', 'Washington', 'DC', '20029', 'USA', 'o003'),
	('p038', 'G', 'Leaden', '1997-02-26', '911 Evergreen Street', 'New York', 'NY', '10027', 'USA', 'o001'),
	('p039', 'Lexi', 'Frampton', '1998-03-24', '1537 S Westgate Ave #2', 'Los Angeles', 'CA', '90025', 'USA', 'o002'),
	('p040', 'Aubrey', 'OKeefe', '1998-12-04', '3848 26th St', 'San Francisco', 'CA', '94131', 'USA', 'o005');


-- SnapchatStoryActors --
INSERT INTO SnapchatStoryActors(pid, hairColor, eyeColor, personalityType, hireDate)
  VALUES('p021', 'brown', 'brown', 'quirky', '2017-04-17'),
	('p039', 'brown', 'hazel', 'cute', '2015-10-31'),
	('p027', 'blonde/brown', 'brown', 'loud', '2017-03-15'),
	('p023', 'brown', 'brown', 'energetic', '2017-05-05'),
	('p015', 'blonde', 'green', 'wild', '2016-11-23'),
	('p032', 'brown', 'brown', 'funny', '2015-12-10'),
	('p013', 'brown', 'brown', 'awkward', '2015-07-08'),
	('p033', 'brown', 'brown', 'sarcastic', '2016-04-21'),
	('p036', 'blonde', 'green', 'whimsical', '2015-05-12'),
	('p031', 'blonde', 'green', 'relaxed', '2016-10-25');

-- TastyVidHands --
INSERT INTO TastyVidHands(pid, favNailColor, numRings, gender, favFood, hireDate)
  VALUES('p034', 'red', 2, 'female', 'hawaiian pizza', '2013-03-12' ),
	('p035', 'purple', 9, 'female', 'ice cream', '2014-02-13'),
	('p019', 'french', 0, 'female', 'pasta', '2016-01-12'),
	('p009', 'none', 1, 'male', 'sushi', '2007-03-19'),
	('p018', 'light pink', 4, 'female', 'margherita pizza', '2016-09-26'),
	('p040', 'french', 3, 'female', 'chocolate cake', '2015-09-12'),
	('p022', 'blue', 7, 'female', 'buffalo chicken calzone', '2014-08-26'),
	('p010', 'none', 2, 'male', 'steak tips', '2015-06-18'),
	('p005', 'coral', 5, 'female', 'grilled cheese', '2016-07-12');
  
-- PositionDescriptions --
INSERT INTO PositionDescriptions(posid, positionTitle)
  VALUES('NEWS', 'News Article Writer'),
	('QUIZ', 'Quiz Creator'),
	('MEME', 'Inventor of Memes'),
	('SCAW', 'Snapchat Article Writer'),
	('APRL', 'Apparel Designer'),
	('NIFT', 'Nifty Specialist');

-- CreativePositions --
INSERT INTO CreativePositions(pid, posid, favBook, hireDate)
  VALUES('p038', 'MEME', 'The Hobbit', '2015-07-28'),
	('p001', 'NEWS', 'The Grapes of Wrath', '2009-08-17'),
	('p006', 'APRL', 'Wonder', '2010-09-12'),
	('p008', 'NIFT', 'The Hunger Games', '2012-07-15'),
	('p028', 'SCAW', 'Glass Castle', '2015-05-01'),
	('p029', 'QUIZ', 'The Diary of a Wimpy Kid', '2015-05-02'),
	('p020', 'SCAW', 'Extremely Loud and Incredibly Close', '2017-03-19'),
	('p025', 'QUIZ', 'The Notebook', '2016-05-11'),
	('p026', 'APRL', 'Harry Potter', '2016-05-18'),
	('p016', 'MEME', 'The Odyssey', '2015-10-14'),
	('p012', 'NIFT', 'The Great Gatsby', '2014-03-22'),
	('p030', 'SCAW', 'Matilda', '2016-12-15');


-- WebDesigners --	
INSERT INTO WebDesigners(pid, college, highestDegree, favFrontEndLang, hireDate)
  VALUES('p002', 'Massachusetts Institute of Technology', 'Bachelors', 'HTML', '2016-11-13'),
	('p007', 'Wocester Polytechnical Institue', 'Bachelors', 'JavaScript', '2012-04-04'),
	('p003', 'Northeastern University', 'Masters', 'CSS', '2011-09-21'),
	('p037', 'Marist College', 'Masters', 'HTML', '2017-12-01'),
	('p004', 'Stanford University', 'Doctorate', 'CSS', '2015-06-19'),
	('p014', 'Virginia Tech', 'Bachelors', 'HTML', '2017-08-16'),
	('p011', 'Virginia Tech', 'Bachelors', 'jQuery', '2017-03-03'),
	('p017', 'University of Vermont', 'Bachelors', 'Python', '2016-05-09'),
	('p024', 'Northeastern University', 'Masters', 'HTML', '2015-02-27');


-- SnapchatArticles --
INSERT INTO SnapchatArticles(aid, topic, pid)
  VALUES('a001', '19 Funny Typos in Public Ads', 'p028'),
	('a002', '21 Food Combos That Cannot Happen', 'p030'),
	('a003', 'The Best Memes of 2017', 'p020'),
	('a004', '10 Interesting Facts About the iPhone X', 'p020'),
	('a005', '21 Jokes About Growing Up With a Sister That Are So Relatable', 'p028');

-- SnapchatArticleTags --
INSERT INTO SnapchatArticleTags(aid, tag)
  VALUES('a001', 'funny'),
	('a001', 'typo'),
	('a001', 'meme'),
	('a002', 'food'),
	('a002', 'gross'),
	('a002', 'strange'),
	('a002', 'combos'),
	('a003', 'funny'),
	('a003', 'meme'),
	('a003', '2017'),
	('a003', 'best'),
	('a004', 'facts'),
	('a004', 'interesting'),
	('a004', 'iPhone'),
	('a004', 'Apple'),
	('a004', 'new'),
	('a005', 'jokes'),
	('a005', 'relatable'),
	('a005', 'sister'),
	('a005', 'family'),
	('a005', 'funny');


-- Quizzes --
INSERT INTO Quizzes(quizid, name, numQuestions, type)
  VALUES('q001', 'Rate These Desserts and We Will Reveal What Type of Guys Attract You', 15, 'ratings'),
	('q002', 'Which Disney Princess Should You Date Based on the Trip You Plan?', 10, 'preferences'),
	('q003', 'Would You Rather: Food Edition', 7, 'would you rather'),
	('q004', 'What Kind of Sandwich Are You?', 9, 'preferences'),
	('q005', 'Would You Rather: Makeup Edition', 12, 'would you rather'),
	('q006', 'Choose Some Dad Things and We Will Tell You a Dad Joke', 12, 'preferences');


-- QuizTags --
INSERT INTO QuizTags(quizid, tag)
  VALUES('q001', 'dessert'),
	('q001', 'rate'),
	('q001', 'guys'),
	('q001', 'attract'),
	('q002', 'Disney'),
	('q002', 'vacation'),
	('q002', 'planning'),
	('q002', 'princess'),
	('q003', 'choice'),
	('q003', 'food'),
	('q004', 'food'),
	('q004', 'sandwich'),
	('q004', 'type'),
	('q005', 'makeup'),
	('q005', 'choice'),
	('q006', 'dad'),
	('q006', 'jokes'),
	('q006', 'dad jokes'),
	('q006', 'funny');

-- FavQuizzes --
INSERT INTO FavQuizzes(pid, quizid)
  VALUES('p038', 'q006'),
	('p001', 'q006'),
	('p006', 'q003'),
	('p008', 'q004'),
	('p028', 'q002'),
	('p029', 'q004'),
	('p020', 'q005'),
	('p025', 'q005'),
	('p026', 'q004'),
	('p016', 'q006'),
	('p012', 'q001'),
	('p030', 'q004');


-- Catering --
INSERT INTO Catering(lunchid, cateringCompany, lunchDescription, cuisineType)
  VALUES('lu01', 'Spinellis', 'Pasta Trio and Calzones', 'italian'),
	('lu02', 'Panera Bread', 'Assorted Sandwiches', 'american'),
	('lu03', 'P.F. Changs', 'Chinese Food Spread', 'asian'),
	('lu04', 'Chipotle Mexican Grill', 'Build Your Own Burrito Bowl', 'mexican'),
	('lu05', 'Qdoba Mexican Grill', 'Taco Bar', 'mexican'),
	('lu06', 'Giacomos Pizza', 'Pizza Station', 'italian'),
	('lu07', 'Rossis Deli', 'Build Your Own Sandwich', 'american');


-- PopularLunches --
INSERT INTO PopularLunches(officeid, lunchid, dayOfWeekServed)
  VALUES('o001', 'lu04', 'Friday'),
	('o002', 'lu06', 'Wednesday'),
	('o003', 'lu05', 'Tuesday'),
	('o004', 'lu07', 'Friday'),
	('o005', 'lu04', 'Monday'),
	('o006', 'lu02', 'Thursday'),
	('o007', 'lu02', 'Wednesday'),
	('o008', 'lu05', 'Tuesday');


-- SnapchatVideos --
INSERT INTO SnapchatVideos(scvid, topic, vidStateLoc)
  VALUES('v001', 'I Tried To Eat Like Gigi Hadid For a Week', 'NY'),
	('v002', 'Taco Challenge: Eat Only Tacos For a Week', 'CA'),
	('v003', 'Design An Outfit That Works With Crocs', 'NY'),
	('v004', 'Playing Pranks in the Office Without Getting Caught', 'Ontario'),
	('v005', 'Pizza Tour', 'CA');


-- SnapchatVideoTags --
INSERT INTO SnapchatVideoTags(scvid, tag)
  VALUES('v001', 'food'),
	('v001', 'supermodel'),
	('v001', 'diet'),
	('v001', 'challenge'),
	('v002', 'taco'),
	('v002', 'mexican'),
	('v002', 'challenge'),
	('v002', 'food'),
	('v003', 'clothes'),
	('v003', 'outfit'),
	('v003', 'crocs'),
	('v003', 'shoes'),
	('v004', 'pranks'),
	('v004', 'jokes'),
	('v004', 'funny'),
	('v004', 'office'),
	('v004', 'sneaky'),
	('v005', 'pizza'),
	('v005', 'cheese'),
	('v005', 'food'),
	('v005', 'tour');

  
-- ActsIn --
INSERT INTO ActsIn(pid, scvid)
  VALUES('p015', 'v004'),
	('p027', 'v005'),
	('p036', 'v001'),
	('p032', 'v003'),
	('p021', 'v002');


-- TastyVideoTypes --
INSERT INTO TastyVideoTypes(typeCode, typeDescription)
  VALUES('TAST', 'Original Tasty'),
	('JUNR', 'Tasty Junior'),
	('PROP', 'Proper Tasty'),
	('JAPN', 'Tasty Japan'),
	('BIEN', 'Tasty Bien'),
	('MIAM', 'Tasty Miam'),
	('DEMA', 'Tasty Demais');

	
-- TastyVideos --
INSERT INTO TastyVideos(tastyvid, name, caption, pid, typeCode)
  VALUES('t001', 'Chicken Kabob Salad', 'This is the perfect dish to start off the summer with!', 'p018', 'TAST'),
	('t002', 'Pizza Star', 'The newest appetizer to your next tailgate', 'p034', 'TAST'),
	('t003', 'Ham and Cheese Pinwheels', 'These are fun and easy to make with the kids!', 'p022', 'JUNR'),
	('t004', 'Late Night Snacks', '10 Quick recipes for those late night cravings', 'p040', 'TAST'),
	('t005', 'Churros de Calabaza y Especias', 'These churros are the ideal way to start off the fall!', 'p019', 'BIEN'),
	('t006', 'Flower Dumplings', 'These dumplings will look beautiful and taste just as great', 'p005', 'JAPN'),
	('t007', 'Gingerbread Dutch Baby Pancake', 'ITS SO FLUFFY', 'p010', 'PROP');


-- TastyVideoTags --
INSERT INTO TastyVideoTags(tastyvid, tag)
  VALUES('t001', 'chicken'),
	('t001', 'kabob'),
	('t001', 'salad'),
	('t001', 'food'),
	('t001', 'summer'),
	('t002', 'pizza'),
	('t002', 'star'),
	('t002', 'shapes'),
	('t002', 'cheese'),
	('t002', 'food'),
	('t003', 'ham'),
	('t003', 'cheese'),
	('t003', 'pinwheel'),
	('t003', 'junior'),
	('t003', 'kids'),
	('t003', 'snack'),
	('t003', 'food'),
	('t004', 'night'),
	('t004', 'snacks'),
	('t004', 'food'),
	('t004', 'easy'),
	('t005', 'churros'),
	('t005', 'pumpkin'),
	('t005', 'spice'),
	('t005', 'fall'),
	('t005', 'dessert'),
	('t005', 'food'),
	('t005', 'bien'),
	('t006', 'japan'),
	('t006', 'dumpling'),
	('t006', 'flower'),
	('t006', 'shrimp'),
	('t006', 'beef'),
	('t006', 'pretty'),
	('t006', 'food'),
	('t007', 'proper'),
	('t007', 'dutch baby'),
	('t007', 'pancake'),
	('t007', 'United Kingdom'),
	('t007', 'gingerbread'),
	('t007', 'breakfast'),
	('t007', 'dessert'),
	('t007', 'food');
	

-- View Definitons --	


-- UnusedActors View
create view UnusedActors (firstName, lastName, pid)
as
 select p.firstName, p.lastName, s.pid
 from snapchatstoryactors s left outer join people p on s.pid = p.pid
			    left outer join actsin a on s.pid = a.pid
where scvid is NULL;


-- Testing UnusedActors
select *
from UnusedActors;


-- MostPopularQuiz View
-- This is the most popular quiz among employees, not viewers
create view MostPopularQuiz (quizid)
as
  select quizid, count(quizid) as numVotes
  from favQuizzes
  group by quizid
  order by count(quizid) DESC
  limit 1;


--Testing MostPopularQuiz
select p.quizid, q.name, q.numquestions, q.type, p.numvotes
from quizzes q inner join mostpopularquiz p on q.quizid = p.quizid;


-- Ages View
create view Ages(pid, firstName, lastName, birthdate)
as
  select pid, firstName, lastName, date_trunc('year',age(birthdate))
  from people;

-- Testing Ages
select *
from Ages;

-- Reports
-- 21 and over
select *
from ages
where birthdate >= '21 years';

-- Number of employees at each office
select officeid, count(officeid)
from people
group by officeid
order by officeid ASC;

-- Number of offices by country
select country, count(country)
from officelocations
group by country;

-- Full employee, office, and job info listed together by specific job
-- Example: Tasty Video employees
select *
from people p inner join tastyvidhands t on p.pid = t.pid
	      inner join officelocations l on p.officeid = l.officeid
	      inner join tastyvideos v on t.pid = v.pid;

-- Stored Procedures Definitions

--commonTastyTags
create or replace function commonTastyTags(text, REFCURSOR) returns refcursor as 
$$
declare
   commonTag text       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for
   select tv.tastyvid, tv.name, t.tag as tastyTag , qt.quizid, 
			qt.tag as quizTag, a.aid as articleid, a.tag as articleTag,v.scvid as scVidTag, 
			v.tag as videoTag
   from TastyVideoTags t inner join TastyVideos tv on t.tastyvid = tv.tastyvid
			  left outer join QuizTags qt on t.tag = qt.tag
			  left outer join SnapchatArticleTags a on t.tag = a.tag
			  left outer join SnapchatVideoTags v on t.tag = v.tag
   where t.tag = commonTag;
   return resultset;
end;
$$ 
language plpgsql;

-- testingCommonTastyTags
select commonTastyTags('cheese', 'results');
Fetch all from results;


--CreativePositions
create or replace function creativePosInNeed(char(4))
returns refcursor as
$$
declare
   selectedPos	char(4) :=$1;
   count 	int;
begin
	count = (select count(posid)
		 from creativepositions
		 where posid=selectedPos
		 group by posid);

	if (count < 2) then
		return true;
	else
		return false;
	end if;
end;
$$
language plpgsql;

--testing creativePosInNeed
select creativePosInNeed('NEWS');

-- Triggers

-- Stored Procedure: quizLength
create or replace function quizLength()
returns trigger as
$$
begin
  if NEW.numQuestions > 25 then
    delete from quizzes where numquestions = NEW.numQuestions;
  end if;
  return NEW;
end;
$$
language plpgsql;

-- Trigger: checkQuizLength
create trigger checkQuizLength
after insert on quizzes
for each row execute procedure quizLength();

--testing checkQuizLength and quizLength 
insert into Quizzes(quizid, name, numquestions, type)
values('q007', 'Make The Perfect Cookie Dough And We Will Tell You How Many Kids You Will Have', 35, 'preferences');

select *
from quizzes;

-- Security

-- Create roles
--create role admin;
--create role CEO;
--create role departmentChairs;


-- Admin
grant all on all tables in schema public to admin;

-- CEO
grant all on all tables in schema public to CEO;

-- departmentChairs
revoke all on all tables in schema public from departmentChairs;
grant select on QuizTags, FavQuizzes, SnapchatArticleTags, TastyVideoTags, SnapchatVideoTags to departmentChairs;
grant select, insert, update on PositionDescriptions, Quizzes, SnapchatArticles, TastyVideos, 
				TastyVideoTypes, SnapchatVideos, ActsIn to departmentChairs;
grant select, insert, update, delete on CreativePositions, WebDesigners, TastyVidHands, SnapchatStoryActors
					to departmentChairs;
