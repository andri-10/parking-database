CREATE TABLE mbyllje_ditore (

    mb_ditore_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pika_parkimi_id INT NOT NULL,
    punonjes_id INT NOT NULL,
    data_mbylljes DATE DEFAULT SYSDATE NOT NULL,
    koha_mbylljes TIMESTAMP NOT NULL,
    vlera_totale NUMBER(10, 2) NOT NULL,
    statusi_mbylljes VARCHAR2(20) DEFAULT 'Aktiv',

    CONSTRAINT fk_mbyllje_pika FOREIGN KEY (pika_parkimi_id) REFERENCES pika_parkimi(pika_parkimi_id),
    CONSTRAINT fk_mbyllje_punonjes FOREIGN KEY (punonjes_id) REFERENCES punonjesit(punonjes_id),
    CONSTRAINT ck_mbyllje_statusi CHECK (statusi_mbylljes IN ('Aktiv', 'Mbyllur')),
    CONSTRAINT ck_mbyllje_vlera CHECK (vlera_totale >= 0),
    CONSTRAINT uk_mbyllje_unik UNIQUE (pika_parkimi_id, punonjes_id, data_mbylljes),
    CONSTRAINT ck_mbyllje_data_koha CHECK (TRUNC(koha_mbylljes) = data_mbylljes)
    
);