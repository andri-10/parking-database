CREATE TABLE kartat(

  karta_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  klient_id INT NOT NULL,
  pika_parkimi_id INT NOT NULL,
  data_leshimit DATE DEFAULT SYSDATE NOT NULL,
  data_skadences DATE,
  statusi VARCHAR2(20) DEFAULT 'Aktiv' NOT NULL,

  CONSTRAINT fk_kartat_klientet FOREIGN KEY (klient_id) REFERENCES klientet(klient_id) ON DELETE CASCADE,
  CONSTRAINT fk_kartat_pika_parkimi FOREIGN KEY (pika_parkimi_id) REFERENCES pika_parkimi(pika_parkimi_id) ON DELETE CASCADE,
  CONSTRAINT ck_kartat_data_skadences CHECK (data_skadences > data_leshimit),
  CONSTRAINT ck_kartat_statusi CHECK (statusi IN ('Aktiv', 'Skaduar', 'Anuluar')),
  CONSTRAINT uk_kartat_klient_pika UNIQUE (klient_id, pika_parkimi_id)
  
);



