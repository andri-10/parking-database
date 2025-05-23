CREATE TABLE pika_parkimi(

  pika_parkimi_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  vendndodhja VARCHAR2(50) NOT NULL,
  adresa VARCHAR2(100) NOT NULL,
  vende_total INT NOT NULL CHECK (vende_total > 0),
  vende_zene INT NOT NULL,
  vende_lire AS (vende_total - vende_zene) VIRTUAL,
  is_active CHAR(1) DEFAULT 'Y' NOT NULL CHECK (is_active IN ('Y', 'N')),

  CONSTRAINT chk_vende_zene CHECK (vende_zene >= 0 AND vende_zene <= vende_total)
  
);