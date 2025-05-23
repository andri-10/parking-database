-- Tabela për historinë e kartave (audit)
CREATE TABLE historia_kartave (
  audit_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  karta_id INT NOT NULL,
  statusi_vjeter VARCHAR2(20),
  statusi_i_ri VARCHAR2(20) NOT NULL,
  data_ndryshimit TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
  arsyeja VARCHAR2(100),
  ndryshuar_nga VARCHAR2(50) NOT NULL,
  
  CONSTRAINT fk_historia_kartat FOREIGN KEY (karta_id) REFERENCES kartat(karta_id) ON DELETE CASCADE,
  CONSTRAINT ck_historia_kartat_statusi CHECK (statusi_i_ri IN ('Aktiv', 'Skaduar', 'Anuluar'))
);

