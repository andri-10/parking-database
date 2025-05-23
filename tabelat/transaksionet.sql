CREATE TABLE transaksionet (

    transaksion_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    aktiviteti_id INT,
    punonjes_id INT NOT NULL,
    pika_parkimi_id INT NOT NULL,
    shuma DECIMAL(10, 2) NOT NULL CHECK (shuma > 0),
    metoda_pageses VARCHAR2(50) NOT NULL CHECK (metoda_pageses IN ('Cash', 'Kartë krediti', 'Transfertë bankare')),
    data_transaksionit TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    statusi VARCHAR2(20) DEFAULT 'Perfunduar' NOT NULL,
    pershkrimi VARCHAR2(200),
    anulim CHAR(1) DEFAULT 'J' CHECK (anulim IN ('P', 'J')),
    transaksion_origjinal_id INT,
    
    CONSTRAINT fk_transaksionet_aktiviteti FOREIGN KEY (aktiviteti_id) 
        REFERENCES aktiviteti_parkimit(aktiviteti_id),
    CONSTRAINT fk_transaksionet_punonjes FOREIGN KEY (punonjes_id) 
        REFERENCES punonjesit(punonjes_id),
    CONSTRAINT fk_transaksionet_pika FOREIGN KEY (pika_parkimi_id) 
        REFERENCES pika_parkimi(pika_parkimi_id),
    CONSTRAINT fk_transaksionet_origjinal FOREIGN KEY (transaksion_origjinal_id) 
        REFERENCES transaksionet(transaksion_id),
    CONSTRAINT ck_transaksionet_statusi CHECK (statusi IN ('Perfunduar', 'Anuluar'))
    
);

