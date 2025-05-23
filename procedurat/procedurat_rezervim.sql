
--Procedurat per krijimin dhe aktivizimin e rezervimeve

CREATE OR REPLACE PROCEDURE krijo_rezervim (
    p_klient_id IN INT,
    p_pika_parkimi_id IN INT,
    p_automjet_id IN INT,
    p_koha_fillimit IN TIMESTAMP,
    p_koha_mbarimit IN TIMESTAMP,
    p_rezervim_id OUT INT,
    p_rezultati OUT VARCHAR2
) IS
    v_klient_count INT;
    v_pika_count INT;
    v_automjet_count INT;
    v_automjet_klient INT;
    v_vende_total INT;
    v_rezervime_count INT;
BEGIN
    SELECT COUNT(*) INTO v_klient_count
    FROM klientet
    WHERE klient_id = p_klient_id;
    
    IF v_klient_count = 0 THEN
        p_rezultati := 'Gabim: Klienti nuk ekziston.';
        RETURN;
    END IF;
    
    SELECT COUNT(*) INTO v_pika_count
    FROM pika_parkimi
    WHERE pika_parkimi_id = p_pika_parkimi_id;
    
    IF v_pika_count = 0 THEN
        p_rezultati := 'Gabim: Pika e parkimit nuk ekziston.';
        RETURN;
    END IF;
    
    SELECT COUNT(*) INTO v_automjet_count
    FROM automjetet
    WHERE automjet_id = p_automjet_id;
    
    IF v_automjet_count = 0 THEN
        p_rezultati := 'Gabim: Automjeti nuk ekziston.';
        RETURN;
    END IF;
    
    SELECT klient_id INTO v_automjet_klient
    FROM automjetet
    WHERE automjet_id = p_automjet_id;
    
    IF v_automjet_klient != p_klient_id THEN
        p_rezultati := 'Gabim: Automjeti nuk i perket ketij klienti.';
        RETURN;
    END IF;
    
    IF p_koha_fillimit < SYSTIMESTAMP THEN
        p_rezultati := 'Gabim: Koha e fillimit nuk mund te jete ne te kaluaren.';
        RETURN;
    END IF;
    
    IF p_koha_mbarimit <= p_koha_fillimit THEN
        p_rezultati := 'Gabim: Koha e mbarimit duhet te jete pas kohes se fillimit.';
        RETURN;
    END IF;
    
    SELECT vende_total INTO v_vende_total
    FROM pika_parkimi
    WHERE pika_parkimi_id = p_pika_parkimi_id;
    
    SELECT COUNT(*) INTO v_rezervime_count
    FROM rezervime
    WHERE pika_parkimi_id = p_pika_parkimi_id
      AND statusi_rezervimit = 'Aktiv'
      AND ((p_koha_fillimit BETWEEN koha_fillimit AND koha_mbarimit)
           OR (p_koha_mbarimit BETWEEN koha_fillimit AND koha_mbarimit)
           OR (koha_fillimit BETWEEN p_koha_fillimit AND p_koha_mbarimit));
    
    IF v_rezervime_count >= v_vende_total THEN
        p_rezultati := 'Gabim: Nuk ka vende te disponueshme per rezervim ne kete periudhe kohore.';
        RETURN;
    END IF;
    
    INSERT INTO rezervime (
        klient_id,
        pika_parkimi_id,
        automjet_id,
        koha_fillimit,
        koha_mbarimit
    ) VALUES (
        p_klient_id,
        p_pika_parkimi_id,
        p_automjet_id,
        p_koha_fillimit,
        p_koha_mbarimit
    ) RETURNING rezervime_id INTO p_rezervim_id;
    
    COMMIT;
    p_rezultati := 'Rezervimi u krijua me sukses me ID: ' || p_rezervim_id;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_rezultati := 'Gabim: ' || SQLERRM;
END krijo_rezervim;
/

CREATE OR REPLACE PROCEDURE aktivizo_rezervim (
    p_rezervim_id IN INT,
    p_aktiviteti_id OUT INT,
    p_rezultati OUT VARCHAR2
) IS
    v_klient_id INT;
    v_pika_parkimi_id INT;
    v_automjet_id INT;
    v_targa VARCHAR2(50);
    v_koha_fillimit TIMESTAMP;
    v_koha_mbarimit TIMESTAMP;
    v_statusi VARCHAR2(20);
    v_rezervim_count INT;
    v_vende_lire INT;
BEGIN
    SELECT COUNT(*) INTO v_rezervim_count
    FROM rezervime
    WHERE rezervime_id = p_rezervim_id;
    
    IF v_rezervim_count = 0 THEN
        p_rezultati := 'Gabim: Rezervimi nuk ekziston.';
        RETURN;
    END IF;
    
    SELECT klient_id, pika_parkimi_id, automjet_id, koha_fillimit, 
           koha_mbarimit, statusi_rezervimit
    INTO v_klient_id, v_pika_parkimi_id, v_automjet_id, v_koha_fillimit, 
         v_koha_mbarimit, v_statusi
    FROM rezervime
    WHERE rezervime_id = p_rezervim_id;
    
    IF v_statusi != 'Aktiv' THEN
        p_rezultati := 'Gabim: Rezervimi nuk është aktiv.';
        RETURN;
    END IF;
    
    IF SYSTIMESTAMP < v_koha_fillimit THEN
        p_rezultati := 'Gabim: Nuk mund të aktivizoni një rezervim përpara kohës së fillimit.';
        RETURN;
    END IF;
    
    IF SYSTIMESTAMP > v_koha_mbarimit THEN
        p_rezultati := 'Gabim: Rezervimi ka skaduar.';
        RETURN;
    END IF;
    
    SELECT targa INTO v_targa
    FROM automjetet
    WHERE automjet_id = v_automjet_id;
    
    SELECT (vende_total - vende_zene) INTO v_vende_lire
    FROM pika_parkimi
    WHERE pika_parkimi_id = v_pika_parkimi_id;
    
    IF v_vende_lire <= 0 THEN
        p_rezultati := 'Gabim: Nuk ka vende të lira në këtë pikë parkimi.';
        RETURN;
    END IF;
    
    INSERT INTO aktiviteti_parkimit (
        pika_parkimi_id,
        targa,
        klient_id,
        koha_hyrjes
    ) VALUES (
        v_pika_parkimi_id,
        v_targa,
        v_klient_id,
        GREATEST(SYSTIMESTAMP, v_koha_fillimit)
    ) RETURNING aktiviteti_id INTO p_aktiviteti_id;
    
    UPDATE rezervime
    SET statusi_rezervimit = 'Përfunduar'
    WHERE rezervime_id = p_rezervim_id;
    
    COMMIT;
    p_rezultati := 'Rezervimi u aktivizua me sukses. ID e aktivitetit: ' || p_aktiviteti_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        p_rezultati := 'Gabim: Të dhënat e rezervimit nuk u gjetën.';
    WHEN OTHERS THEN
        ROLLBACK;
        p_rezultati := 'Gabim: ' || SQLERRM;
END aktivizo_rezervim;
/