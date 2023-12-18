CREATE TABLE PUBLISHER
(NAME VARCHAR2 (20) PRIMARY KEY,
ADDRESS VARCHAR2 (20),
PHONE NUMBER (10));

CREATE TABLE BOOK
(BOOK_ID NUMBER(4) PRIMARY KEY,
TITLE VARCHAR2 (20),
PUB_YEAR VARCHAR2 (20),
PUBLISHER_NAME VARCHAR2(20),
FOREIGN KEY (PUBLISHER_NAME) REFERENCES PUBLISHER (NAME) ON DELETE CASCADE);

CREATE TABLE BOOK_AUTHORS
(BOOK_ID NUMBER(4),
AUTHOR_NAME VARCHAR2 (20),
PRIMARY KEY (BOOK_ID, AUTHOR_NAME),
FOREIGN KEY (BOOK_ID) REFERENCES BOOK (BOOK_ID) ON DELETE CASCADE);

CREATE TABLE LIBRARY_BRANCH
(BRANCH_ID INTEGER PRIMARY KEY,
BRANCH_NAME VARCHAR2 (20),
ADDRESS VARCHAR2 (30));

CREATE TABLE BOOK_COPIES
(BOOK_ID NUMBER(4),
BRANCH_ID NUMBER(5),
NO_OF_COPIES INTEGER,
PRIMARY KEY (BOOK_ID, BRANCH_ID),
FOREIGN KEY (BOOK_ID) REFERENCES BOOK (BOOK_ID) ON DELETE CASCADE,
FOREIGN KEY (BRANCH_ID) REFERENCES LIBRARY_BRANCH (BRANCH_ID) ON DELETE CASCADE);

CREATE TABLE CARD
(CARD_NO INTEGER PRIMARY KEY);

CREATE TABLE BOOK_LENDING
(BOOK_ID NUMBER(4),
BRANCH_ID NUMBER(5),
CARD_NO NUMBER(6) NOT NULL,
DATE_OUT DATE,
DUE_DATE DATE,
PRIMARY KEY (BOOK_ID, BRANCH_ID, CARD_NO),
FOREIGN KEY (BOOK_ID) REFERENCES BOOK (BOOK_ID) ON DELETE CASCADE,
FOREIGN KEY (BRANCH_ID) REFERENCES LIBRARY_BRANCH (BRANCH_ID) ON DELETE CASCADE);



INSERT INTO PUBLISHER VALUES ('ABC', 'BELGAUM', 7700006587);
INSERT INTO PUBLISHER VALUES ('BCD', 'PUNA', 7800006565);
INSERT INTO PUBLISHER VALUES ('CDE', 'HYDERABAD', 7400007345);
INSERT INTO PUBLISHER VALUES ('DEF', 'HUBLI', 8700002340);
INSERT INTO PUBLISHER VALUES ('EFG', 'BANGALORE', 7700000238);

INSERT INTO BOOK VALUES (1,'DBMS','JAN-2017', 'ABC');
INSERT INTO BOOK VALUES (2,'ADBMS','JUN-2016', 'ABC');
INSERT INTO BOOK VALUES (3,'CN','SEP-2016', 'BCD');
INSERT INTO BOOK VALUES (4,'CG','SEP-2015', 'EFG');
INSERT INTO BOOK VALUES (5,'OS','MAY-2016', 'BCD');

INSERT INTO BOOK_AUTHORS VALUES (1, 'SHIV');
INSERT INTO BOOK_AUTHORS VALUES (2, 'SHIV');
INSERT INTO BOOK_AUTHORS VALUES (3, 'RUDHRA');
INSERT INTO BOOK_AUTHORS VALUES (4, 'BOLE');
INSERT INTO BOOK_AUTHORS VALUES (5, 'KEDHAR');

INSERT INTO LIBRARY_BRANCH VALUES (10,'SHANTI NAGAR','BANGALORE');
INSERT INTO LIBRARY_BRANCH VALUES (11,'AMCEC','BANGALORE');
INSERT INTO LIBRARY_BRANCH VALUES (12,'SHIVAJI NAGAR', 'BANGALORE');
INSERT INTO LIBRARY_BRANCH VALUES (13,'AU','MANGALORE');
INSERT INTO LIBRARY_BRANCH VALUES (14,'MANIPAL','UDUPI');

INSERT INTO BOOK_COPIES VALUES (1, 10, 10);
INSERT INTO BOOK_COPIES VALUES (1, 11, 5);
INSERT INTO BOOK_COPIES VALUES (2, 12, 2);
INSERT INTO BOOK_COPIES VALUES (2, 13, 5);
INSERT INTO BOOK_COPIES VALUES (3, 14, 7);
INSERT INTO BOOK_COPIES VALUES (5, 10, 1);
INSERT INTO BOOK_COPIES VALUES (4, 11, 3);

INSERT INTO CARD VALUES (100);
INSERT INTO CARD VALUES (101);
INSERT INTO CARD VALUES (102);
INSERT INTO CARD VALUES (103);
INSERT INTO CARD VALUES (104);

INSERT INTO BOOK_LENDING VALUES (1, 10, 101, '01-JAN-23', '01-JUN-23'); 
INSERT INTO BOOK_LENDING VALUES (3, 14, 101, '11-JAN-23', '11-MAR-23'); 
INSERT INTO BOOK_LENDING VALUES (2, 13, 101, '21-FEB-23', '21-APR-23'); 
INSERT INTO BOOK_LENDING VALUES (4, 11, 101, '15-MAR-23', '15-JUL-23'); 
INSERT INTO BOOK_LENDING VALUES (1, 11, 104, '12-APR-23', '12-MAY-23'); 



/*                                 QUESTION 1. 
Retrieve details of all books in the library – id, title, name of publisher, authors, 
number of copies in each branch, etc. */

SELECT B.BOOK_ID, B.TITLE, B.PUBLISHER_NAME, A.AUTHOR_NAME, C.NO_OF_COPIES, L.BRANCH_ID
FROM BOOK B, BOOK_AUTHORS A, BOOK_COPIES C, LIBRARY_BRANCH L
WHERE B.BOOK_ID=A.BOOK_ID AND
	B.BOOK_ID=C.BOOK_ID AND
	L.BRANCH_ID=C.BRANCH_ID;



/*                                   QUESTION 2. 
Get the particulars of borrowers who have borrowed more than 3 books, but from 
Jan 2023 to Jun 2023. */

select CARD_NO 
from book_lending 
where DATE_OUT between '01-JAN-17' and '01-JUL-17' 
group by(CARD_NO) 
having count(CARD_NO)>3 ;



/*                                  QUESTION 3. 
Delete a book in BOOK table. Update the contents of other tables to reflect this data 
manipulation operation. */

DELETE FROM BOOK WHERE BOOK_ID=3;

SELECT * FROM BOOK;


/*                                 QUESTION 4. 
Partition the BOOK table based on year of publication. Demonstrate its working with a simple query. */

CREATE VIEW YEAR AS
SELECT PUB_YEAR
FROM BOOK;

SELECT * FROM YEAR;



/*                                 QUESTION 5. 
Create a view of all books and its number of copies that are currently available in the Library. */

CREATE VIEW V_BOOKS AS
SELECT B.BOOK_ID, B.TITLE, C.NO_OF_COPIES
FROM BOOK B, BOOK_COPIES C
WHERE B.BOOK_ID=C.BOOK_ID;

SELECT * FROM V_BOOKS;



