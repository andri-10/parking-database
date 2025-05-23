CREATE TABLE cmime_parkimi (

  cmimi_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  pika_parkimi_id INT NOT NULL,
  cmimi DECIMAL(10, 2) NOT NULL CHECK (cmimi > 0),
  ora_fillimit NUMBER NOT NULL,
  ora_mbarimit NUMBER,

  CONSTRAINT fk_cmime_pika FOREIGN KEY (pika_parkimi_id) REFERENCES pika_parkimi(pika_parkimi_id) ON DELETE CASCADE,
  CONSTRAINT ck_cmime_ora_fillimit CHECK (ora_fillimit >= 0 AND ora_fillimit <= 24),
  CONSTRAINT ck_cmime_ora_mbarimit CHECK (ora_mbarimit > ora_fillimit AND ora_mbarimit <= 24)

);

