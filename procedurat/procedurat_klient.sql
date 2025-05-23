-- Procedura per krijimin e nje klienti te ri
CREATE OR REPLACE PROCEDURE krijo_klient (
    p_emri IN VARCHAR2,
    p_mbiemri IN VARCHAR2,
    p_nr_personal IN VARCHAR2,
    p_adresa IN VARCHAR2,
    p_telefoni IN VARCHAR2,
    p_email IN VARCHAR2,
    p_klient_id OUT INT,
    p_rezultati OUT VARCHAR2
) IS
BEGIN
  INSERT INTO klientet (emri, mbiemri, nr_personal, adresa, telefoni, email)
  VALUES (p_emri, p_mbiemri, p_nr_personal, p_adresa, p_telefoni, p_email) 
  RETURNING klient_id INTO p_klient_id;
  COMMIT;
  p_rezultati := 'Klienti u krijua me sukses me ID: ' || p_klient_id;
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    p_rezultati := 'Gabim: Klienti me nr_personal ose email ekziston tashme.';
  WHEN OTHERS THEN
    p_rezultati := 'Gabim: ' || SQLERRM;
END krijo_klient;
/

--Procedura per regjistrimin e nje automjeti te ri
CREATE OR REPLACE PROCEDURE regjistro_automjet (
    p_klient_id IN INT,
    p_marka IN VARCHAR2,
    p_modeli IN VARCHAR2,
    p_ngjyra IN VARCHAR2,
    p_targa IN VARCHAR2,
    P_lloji_automjetit IN VARCHAR2,
    p_automjet_id OUT INT,
    p_rezultati OUT VARCHAR2
) IS
BEGIN
  INSERT INTO automjetet (klient_id, marka, modeli, ngjyra, targa, lloji_automjetit)
  VALUES (p_klient_id, p_marka, p_modeli, p_ngjyra, p_targa, P_lloji_automjetit) 
  RETURNING automjet_id INTO p_automjet_id;
  COMMIT;
  p_rezultati := 'Automjeti u regjistrua me sukses me ID: ' || p_automjet_id;
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    p_rezultati := 'Gabim: Automjeti me targa ekziston tashme.';
  WHEN OTHERS THEN
    p_rezultati := 'Gabim: ' || SQLERRM;
END regjistro_automjet;
/

--Procedura per te leshuar nje karte antaresie
CREATE OR REPLACE PROCEDURE lesho_karte_antaresie (
    p_klient_id IN INT,
    p_pika_parkimi_id IN INT,
    p_data_leshimit IN DATE,
    p_data_skadences IN DATE DEFAULT NULL,
    p_karta_id OUT INT,
    p_rezultati OUT VARCHAR2
) IS
BEGIN
  INSERT INTO kartat (klient_id, pika_parkimi_id, data_leshimit)
  VALUES (p_klient_id, p_pika_parkimi_id, p_data_leshimit) 
  RETURNING karta_id INTO p_karta_id;
  COMMIT;
  p_rezultati := 'Karta e antarësisë u leshua me sukses me ID: ' || p_karta_id;
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    p_rezultati := 'Gabim: Karta e antarësisë ekziston tashme.';
  WHEN OTHERS THEN
    p_rezultati := 'Gabim: ' || SQLERRM;
END lesho_karte_antaresie;
/

--Procedura per te krijuar nje abonim
CREATE OR REPLACE PROCEDURE krijo_abonim (
    p_klient_id IN INT,
    p_pika_parkimi_id IN INT,
    p_lloji_abonimit IN VARCHAR2,
    p_data_mbarimit IN DATE DEFAULT NULL,
    p_perdorimi_maksimal IN INT DEFAULT 1,
    p_abonim_id OUT INT,
    p_rezultati OUT VARCHAR2
) IS
  v_perdorimi_mbetur INT;
  v_perdorime_max INT;
BEGIN

  IF p_lloji_abonimit = 'Me perdorim' THEN
    IF p_perdorimi_maksimal <= 0 THEN
      p_rezultati := 'Gabim: Numri i perdorimeve maksimale duhet te jete pozitiv per abonimet me perdorim.';
      RETURN;
    END IF;
    v_perdorimi_mbetur := p_perdorimi_maksimal;
    v_perdorime_max := p_perdorimi_maksimal;

    ELSIF p_lloji_abonimit = 'Mujor' THEN
      IF p_data_mbarimit IS NULL THEN
        p_rezultati := 'Gabim: Data e mbarimit duhet te jete e caktuar per abonimet mujore.';
        RETURN;
      END IF;
      v_perdorimi_mbetur := 0;
      v_perdorime_max := 1;
  ELSE
    p_rezultati := 'Gabim: Lloji i abonimit duhet te jete "Mujor" ose "Me perdorim".';
    RETURN;
  END IF;

  INSERT INTO abonimet (
    klient_id, 
    pika_parkimi_id, 
    lloji_abonimit, 
    data_mbarimit, 
    perdorimi_maksimal, 
    perdorime_mbetur
  ) VALUES (
    p_klient_id, 
    p_pika_parkimi_id, 
    p_lloji_abonimit, 
    p_data_mbarimit, 
    v_perdorime_max, 
    v_perdorimi_mbetur
  ) RETURNING abonimi_id INTO p_abonim_id;

  COMMIT;
  p_rezultati := 'Abonimi u krijua me sukses me ID: ' || p_abonim_id;
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    p_rezultati := 'Gabim: Abonimi ekziston tashme.';
  WHEN OTHERS THEN
    ROLLBACK;
    p_rezultati := 'Gabim: ' || SQLERRM;
END krijo_abonim;
/

--Procedura per kontrollin e historikut te pageses per klientet
CREATE OR REPLACE PROCEDURE kontrollo_historik_pagese (
    p_klient_id IN INT,
    p_lejohet OUT BOOLEAN,
    p_rezultati OUT VARCHAR2
) IS
    v_klient_count INT;
    v_vonesa_count INT;
    v_abonim_count INT;
    v_start_date DATE;
    v_end_date DATE;
BEGIN
    -- Check if client exists
    SELECT COUNT(*) INTO v_klient_count
    FROM klientet
    WHERE klient_id = p_klient_id;
    
    IF v_klient_count = 0 THEN
        p_lejohet := FALSE;
        p_rezultati := 'Gabim: Klienti nuk ekziston.';
        RETURN;
    END IF;
    
    -- Check if client has active monthly subscription
    SELECT COUNT(*) INTO v_abonim_count
    FROM abonimet
    WHERE klient_id = p_klient_id
      AND lloji_abonimit = 'Mujor'
      AND statusi = 'Aktiv';
    
    IF v_abonim_count = 0 THEN
        p_lejohet := FALSE;
        p_rezultati := 'Gabim: Klienti nuk ka abonim mujor aktiv.';
        RETURN;
    END IF;
    
    v_end_date := TRUNC(SYSDATE);
    v_start_date := ADD_MONTHS(v_end_date, -5);
    
    SELECT COUNT(*) INTO v_vonesa_count
    FROM pagesa_abonimi pa
    WHERE pa.klient_id = p_klient_id
      AND pa.afati_pageses BETWEEN v_start_date AND v_end_date
      AND (pa.data_pageses > pa.afati_pageses OR pa.statusi = 'Nuk është paguar');
    
    IF v_vonesa_count > 0 THEN
        p_lejohet := FALSE;
        p_rezultati := 'Klienti ka ' || v_vonesa_count || ' vonesa në pagesat e 5 muajve të fundit.';
    ELSE
        p_lejohet := TRUE;
        p_rezultati := 'Klienti nuk ka vonesa në 5 muajt e fundit dhe lejohet të parkojë.';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        p_lejohet := FALSE;
        p_rezultati := 'Gabim në procedurë: ' || SQLERRM;
END kontrollo_historik_pagese;
/

--Procedura per te perditesuar statusin e abonimit
CREATE OR REPLACE PROCEDURE perditeso_status_abonim (
    p_abonimi_id IN INT,
    p_statusi_ri IN VARCHAR2,
    p_rezultati OUT VARCHAR2
) IS
    v_abonim_count INT;
    v_statusi_aktual VARCHAR2(20);
BEGIN
    SELECT COUNT(*) INTO v_abonim_count
    FROM abonimet
    WHERE abonimi_id = p_abonimi_id;
    
    IF v_abonim_count = 0 THEN
        p_rezultati := 'Gabim: Abonimi nuk ekziston.';
        RETURN;
    END IF;
    
    SELECT statusi INTO v_statusi_aktual
    FROM abonimet
    WHERE abonimi_id = p_abonimi_id;
    
    IF p_statusi_ri NOT IN ('Aktiv', 'Skaduar', 'Anuluar') THEN
        p_rezultati := 'Gabim: Statusi i ri duhet të jetë Aktiv, Skaduar ose Anuluar.';
        RETURN;
    END IF;
    
    UPDATE abonimet
    SET statusi = p_statusi_ri
    WHERE abonimi_id = p_abonimi_id;
    
    COMMIT;
    p_rezultati := 'Statusi i abonimit u ndryshua nga ' || v_statusi_aktual || ' në ' || p_statusi_ri;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_rezultati := 'Gabim: ' || SQLERRM;
END perditeso_status_abonim;
/




