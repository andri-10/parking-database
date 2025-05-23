CREATE TABLE klientet (

  klient_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  emri VARCHAR2(50) NOT NULL,
  mbiemri VARCHAR2(50) NOT NULL,
  nr_personal VARCHAR2(20) UNIQUE NOT NULL,
  adresa VARCHAR2(100),
  telefoni VARCHAR2(15) UNIQUE NOT NULL,
  email VARCHAR2(100) UNIQUE NOT NULL,
  data_regjistrimit DATE DEFAULT SYSDATE NOT NULL,

  CONSTRAINT ck_telefoni_format CHECK (REGEXP_LIKE(telefoni, '^\+[0-9]{1,14}$')),
  CONSTRAINT ck_email_format CHECK (REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'))
  
);