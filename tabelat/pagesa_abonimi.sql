CREATE TABLE pagesa_abonimi (
  pagesa_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  abonimi_id INT NOT NULL,
  klient_id INT NOT NULL,
  shuma DECIMAL(10, 2) NOT NULL CHECK (shuma > 0),
  data_pageses TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
  afati_pageses DATE DEFAULT SYSDATE + 30 NOT NULL,
  statusi VARCHAR2(20) DEFAULT 'Paguar',

  CONSTRAINT fk_pagesa_abonimet FOREIGN KEY (abonimi_id) REFERENCES abonimet(abonimi_id) ON DELETE CASCADE,
  CONSTRAINT fk_pagesa_klientet FOREIGN KEY (klient_id) REFERENCES klientet(klient_id) ON DELETE CASCADE,
  CONSTRAINT ck_pagesa_statusi CHECK (statusi IN ('Paguar', 'Nuk është paguar'))
);

