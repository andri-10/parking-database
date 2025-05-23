--Procedura per te krijuar nje transaksion
CREATE OR REPLACE PROCEDURE krijo_transaksion (
    p_aktiviteti_id IN INT,
    p_punonjes_id IN INT,
    p_metoda_pageses IN VARCHAR2,
    p_transaksion_id OUT INT,
    p_rezultati OUT VARCHAR2
) IS
    v_aktiviteti_ekziston INT;
    v_punonjes_ekziston INT;
    v_pika_parkimi_id INT;
    v_shuma NUMBER;
    v_statusi_pageses VARCHAR2(20);
BEGIN
    SELECT COUNT(*) INTO v_aktiviteti_ekziston
    FROM aktiviteti_parkimit
    WHERE aktiviteti_id = p_aktiviteti_id;
    
    IF v_aktiviteti_ekziston = 0 THEN
        p_rezultati := 'Gabim: Aktiviteti i parkimit nuk ekziston.';
        RETURN;
    END IF;
    
    SELECT COUNT(*) INTO v_punonjes_ekziston
    FROM punonjesit
    WHERE punonjes_id = p_punonjes_id;
    
    IF v_punonjes_ekziston = 0 THEN
        p_rezultati := 'Gabim: Punonjësi nuk ekziston.';
        RETURN;
    END IF;
    
    SELECT pika_parkimi_id, pagesa_total, statusi_pageses
    INTO v_pika_parkimi_id, v_shuma, v_statusi_pageses
    FROM aktiviteti_parkimit
    WHERE aktiviteti_id = p_aktiviteti_id;
    
    IF v_statusi_pageses = 'Pagesa e kryer' THEN
        p_rezultati := 'Gabim: Ky aktivitet parkimi është paguar tashmë.';
        RETURN;
    END IF;
    
    IF v_shuma <= 0 THEN
        p_rezultati := 'Gabim: Shuma e pagesës duhet të jetë pozitive.';
        RETURN;
    END IF;
    
    INSERT INTO transaksionet (
        aktiviteti_id,
        punonjes_id,
        pika_parkimi_id,
        shuma,
        metoda_pageses,
        statusi
    ) VALUES (
        p_aktiviteti_id,
        p_punonjes_id,
        v_pika_parkimi_id,
        v_shuma,
        p_metoda_pageses,
        'Perfunduar'
    ) RETURNING transaksion_id INTO p_transaksion_id;
    
    UPDATE aktiviteti_parkimit
    SET statusi_pageses = 'Pagesa e kryer'
    WHERE aktiviteti_id = p_aktiviteti_id;
    
    COMMIT;
    p_rezultati := 'Transaksioni u krijua me sukses me ID: ' || p_transaksion_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        p_rezultati := 'Gabim: Të dhënat nuk u gjetën.';
    WHEN OTHERS THEN
        ROLLBACK;
        p_rezultati := 'Gabim: ' || SQLERRM;
END krijo_transaksion;
/

--Procedura per te anuluar transaksionet e pageses
CREATE OR REPLACE PROCEDURE anulo_transaksion (
    p_transaksion_id IN INT,
    p_punonjes_id IN INT,
    p_arsyeja IN VARCHAR2 DEFAULT NULL,
    p_rezultati OUT VARCHAR2
) IS
    v_transaksion_ekzistues TRANSAKSIONET%ROWTYPE;
    v_aktiviteti_id INT;
    v_pika_parkimi_id INT;
    v_shuma NUMBER;
    v_metoda_pageses VARCHAR2(50);
    v_transaksion_i_ri INT;
BEGIN
    SELECT * INTO v_transaksion_ekzistues
    FROM TRANSAKSIONET
    WHERE transaksion_id = p_transaksion_id;
    
    IF v_transaksion_ekzistues.statusi != 'Perfunduar' THEN
        p_rezultati := 'Gabim: Vetëm transaksionet me status "Perfunduar" mund të anulohen.';
        RETURN;
    END IF;
    
    IF v_transaksion_ekzistues.anulim = 'P' THEN
        p_rezultati := 'Gabim: Ky transaksion është tashmë një anulim.';
        RETURN;
    END IF;
    
    v_aktiviteti_id := v_transaksion_ekzistues.aktiviteti_id;
    v_pika_parkimi_id := v_transaksion_ekzistues.pika_parkimi_id;
    v_shuma := -1 * v_transaksion_ekzistues.shuma;
    v_metoda_pageses := v_transaksion_ekzistues.metoda_pageses;
    
    INSERT INTO TRANSAKSIONET (
        aktiviteti_id,
        punonjes_id,
        pika_parkimi_id,
        shuma,
        metoda_pageses,
        statusi,
        pershkrimi,
        anulim,
        transaksion_origjinal_id
    ) VALUES (
        v_aktiviteti_id,
        p_punonjes_id,
        v_pika_parkimi_id,
        v_shuma,
        v_metoda_pageses,
        'Perfunduar',
        'Anulim i transaksionit #' || p_transaksion_id || 
        CASE WHEN p_arsyeja IS NOT NULL THEN ': ' || p_arsyeja ELSE '' END,
        'P',
        p_transaksion_id
    ) RETURNING transaksion_id INTO v_transaksion_i_ri;
    
    UPDATE TRANSAKSIONET
    SET statusi = 'Anuluar'
    WHERE transaksion_id = p_transaksion_id;
    
    IF v_aktiviteti_id IS NOT NULL THEN
        UPDATE AKTIVITETI_PARKIMIT
        SET statusi_pageses = 'Pagesa e anuluar'
        WHERE aktiviteti_id = v_aktiviteti_id;
    END IF;
    
    COMMIT;
    p_rezultati := 'Transaksioni u anulua me sukses. ID e anulimit: ' || v_transaksion_i_ri;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_rezultati := 'Gabim: Transaksioni me ID ' || p_transaksion_id || ' nuk ekziston.';
    WHEN OTHERS THEN
        ROLLBACK;
        p_rezultati := 'Gabim: ' || SQLERRM;
END anulo_transaksion;
/

--Procedura per te paguar abonimin
CREATE OR REPLACE PROCEDURE pagese_abonimi (
    p_abonimi_id IN INT,
    p_klient_id IN INT,
    p_shuma IN NUMBER,
    p_pagesa_id OUT INT,
    p_rezultati OUT VARCHAR2
) IS
    v_abonim_count INT;
    v_klient_id INT;
    v_statusi VARCHAR2(20);
BEGIN
    SELECT COUNT(*) INTO v_abonim_count
    FROM abonimet
    WHERE abonimi_id = p_abonimi_id;
    
    IF v_abonim_count = 0 THEN
        p_rezultati := 'Gabim: Abonimi nuk ekziston.';
        RETURN;
    END IF;
    
    SELECT klient_id, statusi INTO v_klient_id, v_statusi
    FROM abonimet
    WHERE abonimi_id = p_abonimi_id;
    
    IF v_klient_id != p_klient_id THEN
        p_rezultati := 'Gabim: Abonimi nuk i përket këtij klienti.';
        RETURN;
    END IF;
    
    IF v_statusi = 'Anuluar' THEN
        p_rezultati := 'Gabim: Nuk mund të bëhet pagesë për një abonim të anuluar.';
        RETURN;
    END IF;
    
    IF p_shuma <= 0 THEN
        p_rezultati := 'Gabim: Shuma e pagesës duhet të jetë pozitive.';
        RETURN;
    END IF;
    
    INSERT INTO pagesa_abonimi (
        abonimi_id,
        klient_id,
        shuma,
        data_pageses,
        afati_pageses
    ) VALUES (
        p_abonimi_id,
        p_klient_id,
        p_shuma,
        SYSTIMESTAMP,
        ADD_MONTHS(SYSDATE, 1)
    ) RETURNING pagesa_id INTO p_pagesa_id;
    
    UPDATE abonimet
    SET statusi = 'Aktiv',
        data_mbarimit = ADD_MONTHS(SYSDATE, 1)
    WHERE abonimi_id = p_abonimi_id
      AND lloji_abonimit = 'Mujor';
    
    COMMIT;
    p_rezultati := 'Pagesa e abonimit u regjistrua me sukses me ID: ' || p_pagesa_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        p_rezultati := 'Gabim: Të dhënat e abonimit nuk u gjetën.';
    WHEN OTHERS THEN
        ROLLBACK;
        p_rezultati := 'Gabim: ' || SQLERRM;
END pagese_abonimi;
/

--Procedura per mbyllje ditore
CREATE OR REPLACE PROCEDURE mbyllja_ditore (
    p_punonjes_id IN INT,
    p_pika_parkimi_id IN INT,
    p_data_mbylljes IN DATE DEFAULT SYSDATE,
    p_mb_ditore_id OUT INT,
    p_rezultati OUT VARCHAR2
) IS
    v_punonjes_count INT;
    v_pika_count INT;
    v_mbyllje_ekzistuese INT;
    v_vlera_totale NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_punonjes_count
    FROM punonjesit
    WHERE punonjes_id = p_punonjes_id;
    
    IF v_punonjes_count = 0 THEN
        p_rezultati := 'Gabim: Punonjësi nuk ekziston.';
        RETURN;
    END IF;
    
    SELECT COUNT(*) INTO v_pika_count
    FROM pika_parkimi
    WHERE pika_parkimi_id = p_pika_parkimi_id;
    
    IF v_pika_count = 0 THEN
        p_rezultati := 'Gabim: Pika e parkimit nuk ekziston.';
        RETURN;
    END IF;
    
    SELECT COUNT(*) INTO v_mbyllje_ekzistuese
    FROM mbyllje_ditore
    WHERE punonjes_id = p_punonjes_id
      AND pika_parkimi_id = p_pika_parkimi_id
      AND TRUNC(data_mbylljes) = TRUNC(p_data_mbylljes);
    
    IF v_mbyllje_ekzistuese > 0 THEN
        p_rezultati := 'Gabim: Mbyllja ditore për këtë punonjës, pikë parkimi dhe datë ekziston tashmë.';
        RETURN;
    END IF;
    
    SELECT NVL(SUM(shuma), 0) INTO v_vlera_totale
    FROM transaksionet
    WHERE punonjes_id = p_punonjes_id
      AND pika_parkimi_id = p_pika_parkimi_id
      AND TRUNC(data_transaksionit) = TRUNC(p_data_mbylljes);
    
    INSERT INTO mbyllje_ditore (
        punonjes_id,
        pika_parkimi_id,
        data_mbylljes,
        koha_mbylljes,
        vlera_totale,
        statusi_mbylljes
    ) VALUES (
        p_punonjes_id,
        p_pika_parkimi_id,
        p_data_mbylljes,
        SYSTIMESTAMP,
        v_vlera_totale,
        'Mbyllur'
    ) RETURNING mb_ditore_id INTO p_mb_ditore_id;
    
    COMMIT;
    p_rezultati := 'Mbyllja ditore u regjistrua me sukses. Vlera totale: ' || v_vlera_totale;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_rezultati := 'Gabim: ' || SQLERRM;
END mbyllja_ditore;
/


