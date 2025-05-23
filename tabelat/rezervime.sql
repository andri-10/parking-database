CREATE TABLE rezervime (
    rezervime_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    klient_id INT NOT NULL,
    pika_parkimi_id INT NOT NULL,
    automjet_id INT NOT NULL,
    data_rezervimit DATE DEFAULT SYSDATE NOT NULL,
    koha_fillimit TIMESTAMP NOT NULL,
    koha_mbarimit TIMESTAMP NOT NULL,
    statusi_rezervimit VARCHAR2(20) DEFAULT 'Aktiv',

    CONSTRAINT fk_rezervime_klient FOREIGN KEY (klient_id) REFERENCES klientet(klient_id),
    CONSTRAINT fk_rezervime_pika FOREIGN KEY (pika_parkimi_id) REFERENCES pika_parkimi(pika_parkimi_id),
    CONSTRAINT fk_rezervime_automjet FOREIGN KEY (automjet_id) REFERENCES automjetet(automjet_id),
    CONSTRAINT ck_rezervime_statusi CHECK (statusi_rezervimit IN ('Aktiv', 'Anuluar', 'Përfunduar')),
    CONSTRAINT ck_rezervime_koha CHECK (koha_mbarimit > koha_fillimit)
);

