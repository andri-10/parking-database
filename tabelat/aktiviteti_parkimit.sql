CREATE TABLE aktiviteti_parkimit (
  aktiviteti_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  pika_parkimi_id INT NOT NULL,
  targa VARCHAR2(10) NOT NULL,
  klient_id INT,
  abonim_id INT,  
  koha_hyrjes TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
  koha_daljes TIMESTAMP,
  ore_total NUMBER GENERATED ALWAYS AS (
    CASE 
      WHEN koha_daljes IS NOT NULL 
      THEN EXTRACT(DAY FROM (koha_daljes - koha_hyrjes)) * 24 +
           EXTRACT(HOUR FROM (koha_daljes - koha_hyrjes)) +
           EXTRACT(MINUTE FROM (koha_daljes - koha_hyrjes)) / 60 +
           EXTRACT(SECOND FROM (koha_daljes - koha_hyrjes)) / 3600
      ELSE NULL
    END
  ) VIRTUAL,
  pagesa_total NUMBER(10, 2) DEFAULT 0,
  statusi_pageses VARCHAR2(20) DEFAULT 'Ne pritje',
  
  CONSTRAINT fk_aktiviteti_pika FOREIGN KEY (pika_parkimi_id) REFERENCES pika_parkimi(pika_parkimi_id),
  CONSTRAINT fk_aktiviteti_klientet FOREIGN KEY (klient_id) REFERENCES klientet(klient_id),
  CONSTRAINT fk_aktiviteti_abonimet FOREIGN KEY (abonim_id) REFERENCES abonimet(abonimi_id),
  CONSTRAINT ck_aktiviteti_koha_daljes CHECK (koha_daljes IS NULL OR koha_daljes > koha_hyrjes),
  CONSTRAINT ck_aktiviteti_statusi CHECK (statusi_pageses IN ('Ne pritje', 'Pagesa e kryer', 'Pagesa e anuluar'))
);