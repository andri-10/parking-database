CREATE TABLE abonimet (
  abonimi_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  klient_id INT NOT NULL,
  pika_parkimi_id INT NOT NULL,
  lloji_abonimit VARCHAR2(50) NOT NULL,
  data_fillimit TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
  data_mbarimit TIMESTAMP,
  perdorimi_maksimal INT NOT NULL CHECK (perdorimi_maksimal > 0),
  perdorime_mbetur INT CHECK (perdorime_mbetur >= 0),
  statusi VARCHAR2(20) DEFAULT 'Aktiv',

  CONSTRAINT fk_abonimet_klientet FOREIGN KEY (klient_id) REFERENCES klientet(klient_id) ON DELETE CASCADE,
  CONSTRAINT fk_abonimet_pika FOREIGN KEY (pika_parkimi_id) REFERENCES pika_parkimi(pika_parkimi_id) ON DELETE CASCADE,
  CONSTRAINT ck_abonimet_statusi CHECK (statusi IN ('Aktiv', 'Skaduar', 'Anuluar')),
  CONSTRAINT ck_abonimet_data_mbarimit CHECK (data_mbarimit IS NULL OR data_mbarimit > data_fillimit),
  CONSTRAINT ck_abonimet_lloji_abonimit check (lloji_abonimit in ('Mujor', 'Me perdorim'))
);
