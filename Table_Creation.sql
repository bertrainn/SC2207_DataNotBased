CREATE TABLE COMPLAINTS_STATUS (
  STATUS_DATE DATE,
  COMPLAINTS_ID INTEGER,
  STATE VARCHAR(50),
  PRIMARY KEY (STATUS_DATE, COMPLAINTS_ID)
);

CREATE TABLE COMPLAINTS (
  COMPLAINTS_ID INTEGER,
  TEXT VARCHAR(500),
  FILLED_DATE_TIME DATETIME,
  HANDLED_DATE_TIME DATETIME,
  CID INTEGER,
  PRIMARY KEY (COMPLAINTS_ID)
);

CREATE TABLE COMPLAINTS_ON_ORDERS (
  COMPLAINTS_ID INTEGER,
  ORDERID INTEGER,
  PRIMARY KEY (COMPLAINTS_ID),
  FOREIGN KEY (COMPLAINTS_ID) REFERENCES COMPLAINTS(COMPLAINTS_ID)
);

CREATE TABLE EMPLOYEES (
  EID INTEGER,
  NAME VARCHAR(50),
  SALARY FLOAT,
  PRIMARY KEY (EID)
);

CREATE TABLE COMPLAINTS_ON_BOOKSTORE (
  COMPLAINTS_ID INTEGER,
  BOOKSTOREID INTEGER,
  PRIMARY KEY (COMPLAINTS_ID),
  FOREIGN KEY (COMPLAINTS_ID) REFERENCES COMPLAINTS(COMPLAINTS_ID)
);

CREATE TABLE BOOKSTORE (
  BOOKSTOREID INTEGER,
  PRIMARY KEY (BOOKSTOREID)
);

CREATE TABLE CUSTOMERS (
  CID INTEGER,
  NAME VARCHAR(50),
  PRIMARY KEY (CID)
);

CREATE TABLE ORDERS (
  ORDERID INTEGER,
  DATE_TIME DATETIME,
  SHIPPING_ADDRESS VARCHAR(500),
  CID INTEGER,
  PRIMARY KEY (ORDERID),
  FOREIGN KEY (CID) REFERENCES CUSTOMERS(CID)
);

CREATE TABLE PUBLICATION (
  PUBID INTEGER,
  PUBLISHER VARCHAR(50),
  YEAR INTEGER,
  PRIMARY KEY (PUBID)
);

CREATE TABLE BOOKS (
  PUBID INTEGER,
  TITLE VARCHAR(100),
  PRIMARY KEY (PUBID),
  FOREIGN KEY (PUBID) REFERENCES PUBLICATION(PUBID)
);

CREATE TABLE MAGAZINES (
  PUBID INTEGER,
  TITLE VARCHAR(100),
  ISSUE VARCHAR(20),
  PRIMARY KEY (PUBID),
  FOREIGN KEY (PUBID) REFERENCES PUBLICATION(PUBID)
);

CREATE TABLE STOCKS_IN_BOOKSTORE (
  STOCKID INTEGER,
  BOOKSTOREID INTEGER,
  PUBID INTEGER,
  STOCK_PRICE FLOAT,
  STOCK_QTY INTEGER,
  PRIMARY KEY (STOCKID),
  FOREIGN KEY (BOOKSTOREID) REFERENCES BOOKSTORE(BOOKSTOREID),
  FOREIGN KEY (PUBID) REFERENCES PUBLICATION(PUBID)
);

CREATE TABLE ITEMS_IN_ORDERS (
  ITEMID INTEGER,
  ORDERID INTEGER,
  STOCKID INTEGER,
  CID INTEGER,
  COMMENT VARCHAR(500),
  RATING INTEGER,
  DATE_TIME DATETIME,
  DELIVERY_DATE DATE,
  ITEM_PRICE FLOAT,
  ITEM_QTY INTEGER,
  PRIMARY KEY (ITEMID),
  FOREIGN KEY (ORDERID) REFERENCES ORDERS(ORDERID),
  FOREIGN KEY (STOCKID) REFERENCES STOCKS_IN_BOOKSTORE(STOCKID),
  FOREIGN KEY (CID) REFERENCES CUSTOMERS(CID)
);

CREATE TABLE STATUS_ITEMS_IN_ORDERS (
  ITEMID INTEGER,
  STATUSDATE DATE,
  STATE VARCHAR(50),
  PRIMARY KEY (ITEMID, STATUSDATE),
  FOREIGN KEY (ITEMID) REFERENCES ITEMS_IN_ORDERS(ITEMID)
);

CREATE TABLE PRICE_HISTORY (
  STOCKID INTEGER,
  PRICE FLOAT,
  START_DATE DATE,
  END_DATE DATE,
  PRIMARY KEY (STOCKID, PRICE, START_DATE, END_DATE),
  FOREIGN KEY (STOCKID) REFERENCES STOCKS_IN_BOOKSTORE (STOCKID)
  );
