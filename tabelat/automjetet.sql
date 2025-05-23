CREATE TABLE automjetet(

  automjet_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  marka VARCHAR2(50),
  modeli VARCHAR2(50),
  ngjyra VARCHAR2(20),
  targa VARCHAR2(10) NOT NULL UNIQUE,
  lloji_automjetit VARCHAR2(20),
  klient_id INT NOT NULL,
  data_regjistrimit DATE DEFAULT SYSDATE NOT NULL,

  CONSTRAINT fk_automjetet_klientet FOREIGN KEY (klient_id) REFERENCES klientet(klient_id) ON DELETE CASCADE

);

