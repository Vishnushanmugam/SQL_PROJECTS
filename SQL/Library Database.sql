-- CREATE DATABASE 
create database library;

-- USING THAT DB
use library;

-- CREATE LIBRARY TABLE
create table library_books(book_id int primary key, book_name varchar(50), author char(25), publish_year year,category varchar(20), available boolean default true);

-- CREATE MEMBER TABLE
create table members(mem_id int primary key not null, mem_name char(25) not null, address varchar(50) not null, ph_number int);

-- CREATE BOOK_TRACKER TABLE
create table book_tracker(tracker_id int auto_increment primary key ,book_id int, mem_id int, book_name varchar(50), mem_name char(25), book_in DATETIME, book_out DATETIME);

-- CREATE CHECK_OUT TABLE
create table check_out(check_out_id int auto_increment primary key,book_id int, mem_id int, book_name varchar(50), mem_name char(25), check_out DATETIME DEFAULT CURRENT_TIMESTAMP);

-- CREATE CHECK_IN TABLE
create table check_in(check_in_id int auto_increment primary key,book_id int, mem_id int, book_name varchar(50), mem_name char(25), check_in DATETIME DEFAULT CURRENT_TIMESTAMP);

-- INSERT VALUES TO LIBRARY TABLE
insert into library_books values
(1501,"pride and prejudice","Jane Austen",1813,"Romance novel",True), 
(1502,"1984","George Orwell",1949,"Science fiction novel",True),
(1503,"To Kill a Mockingbird","Harper Lee",1960, "Justice",True),
(1504,"The Lord of the Rings","J.R.R. Tolkien",1937,"Fiction",True),
(1505,"Don Quixote","Miguel de Cervantes", 1615,"Satire",True),
(1506,"Moby-Dick","Herman Melville",1851,"Epic",True),
(1507,"Anna Karenina","Leo Tolstoy",1878,"Comics",True),
(1508,"The Catcher in the Rye","J.D. Salinger",1951,"Bildungsroman",True),
(1509,"Beloved","Toni Morrison",1987,"History",True),
(1510,"Rich Dad Poor Dad","Robert Kiyosaki and Sharon Lechter",2022,"Finance",True),
(1511,"Atomic habits","James Clear",2018,"Self-help book",True),
(1512,"The Devil in the White City","Erik Larson",2003,"crime",True),
(1513,"Mindhunter","John E. Douglas",1995,"crime",True),
(1514,"Think and Grow Rich","Napoleon Hill",1937,"Business",True),
(1515,"Thinking, Fast and Slow","Daniel Kahneman",2011,"Psychology",True),
(1516,"The Psychology of Money","Morgan Housel",2020,"Stock Market",True),
(1517,"The Algorithm Design Manual","Steven Skiena",1997,"Computer science",True),
(1518,"The Power of Your Subconscious Mind","Joseph Murphy",1963,"Psychology",True),
(1519,"Adolf Hitler","Walter Gorlitz",1952,"Biography",True),
(1520,"Wings of Fire","A. P. J. Abdul Kalam",1999,"Inspirational Fiction",True);

select * from library_books;

-- INSERT VALUES TO MEMBERS TABLE
insert into members values
(101,"Uriah","Port Greg",6368076545),
(102,"Paula","Brandonview",8367489124),
(103,"Edward","Port Briannahaven",8976123645),
(104,"Michael","Knightborough",7368145099),
(105,"Jasmine","Bruceshire",8865316698),
(106,"Maruk","Erinfort",7720130449),
(107,"Latia","New Christopher",7654530449),
(108,"Sharlene","Lowemouth",9856745862),
(109,"Jac","Johnland",8564789526),
(110,"Joseph","Lake Kimfurt",8595635200),
(111,"Myriam","Smithshire",8596477123),
(112,"Dheepa","Howardburgh",6597783655),
(113,"Bartholemew","East Jessicatown",7895658326),
(114,"Xana","Watersview",6699622659),
(115,"Prater","Port Ninaland",9865629526),
(116,"Kaylah","Lake Stuartfurt",9512620506),
(117,"Kristen","Cooleybury",6975420650),
(118,"Bobby","Larsonborough",6989895006),
(119,"Reid","Powellland",7885025065),
(120,"Hector","Chadport",7950956980);

select * from members;

-- ALTER DATATYPE INT TO BIGINT IN MEMBERS PH_NUMBER
alter table members modify ph_number bigint;

describe members;

-- TRIGGER FOR BOOK CHECK OUT TABLE
DELIMITER //
create trigger after_book_checkout
after insert on check_out
for each row
begin
declare bookname varchar(50);
select book_name into bookname
from library_books
where book_id=New.book_id;

insert into book_tracker(mem_id, mem_name, book_id, book_name, book_out)
    VALUES (NEW.mem_id, NEW.mem_name, NEW.book_id, bookName, NEW.check_out);
END //

DELIMITER ;


-- TRIGGER FOR BOOK CHECK IN TABLE
DELIMITER //
create trigger after_book_checkin
after insert on check_in
for each row
begin
update book_tracker
set book_in= new.check_in
where book_id = new.book_id
order by tracker_id desc limit 1;
END //

DELIMITER ;

select * from book_tracker;

-- INSERT VALUES TO CHECK_OUT TABLE
insert into check_out (book_id, mem_id, book_name, mem_name) value(1501, 101,"pride and prejudice","Uriah");

insert into check_out (book_id, mem_id, book_name, mem_name) value(1502, 102,"1984","Paula");

insert into check_out (book_id, mem_id, book_name, mem_name) value(1504, 104,"The Lord of the Rings","Michael");

select * from book_tracker;

select * from check_out;

-- INSERT VALUES TO CHECK_IN TABLE
insert into check_in (book_id, mem_id, book_name, mem_name) value(1501, 101,"pride and prejudice","Uriah");

insert into check_in (book_id, mem_id, book_name, mem_name) value(1502, 102,"1984","Paula");

select * from book_tracker;

select * from check_in;


select * from library_books where publish_year <1960;

select * from library_books where publish_year >1960;

select * from library_books where category ="crime";

select * from library_books where publish_year between 1900 and 2000;

select distinct category  from library_books;

select category,count(category) from library_books group by category HAVING count(category);