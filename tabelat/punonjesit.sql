CREATE TABLE punonjesit (
    
    punonjes_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pika_parkimi_id INT NOT NULL,
    emri VARCHAR2(50) NOT NULL,
    mbiemri VARCHAR2(50) NOT NULL,
    roli VARCHAR2(20),
    numri_telefonit VARCHAR2(15) UNIQUE,
    email VARCHAR2(100) UNIQUE,
    data_punesimit DATE DEFAULT SYSDATE NOT NULL,
    statusi_punonjesit VARCHAR2(20) DEFAULT 'Aktiv' NOT NULL,
    
    CONSTRAINT fk_punonjesit_pika FOREIGN KEY (pika_parkimi_id) REFERENCES pika_parkimi(pika_parkimi_id),
    CONSTRAINT ck_numri_telefonit_punonjes CHECK (REGEXP_LIKE(numri_telefonit, '^\+[0-9]{1,14}$')),
    CONSTRAINT ck_email_punonjes CHECK (REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')),
    CONSTRAINT ck_roli CHECK (roli IN ('Kontrollor', 'Punonjes', 'Administrator')),
    CONSTRAINT ck_statusi_punonjesit CHECK (statusi_punonjesit IN ('Aktiv', 'Jo Aktiv'))

);

