--Procedura per te parkur nje automjet
CREATE OR REPLACE PROCEDURE parkim_automjeti (
    p_pika_parkimi_id IN INT,
    p_targa IN VARCHAR2,
    p_klient_id IN INT DEFAULT NULL,
    p_abonim_id IN INT DEFAULT NULL,
    p_aktiviteti_id OUT INT,
    p_rezultati OUT VARCHAR2
) IS
  v_klient_id INT := 0;
  v_abonim_id INT := 0;
  v_vende_lire INT;
BEGIN
  SELECT (vende_total - vende_zene) INTO v_vende_lire
  FROM pika_parkimi
  WHERE pika_parkimi_id = p_pika_parkimi_id;
  
  IF v_vende_lire <= 0 THEN
    p_rezultati := 'Gabim: Nuk ka vende të lira në këtë pikë parkimi.';
    RETURN;
  END IF;

  IF p_klient_id IS NOT NULL THEN
    SELECT COUNT(*) INTO v_klient_id
    FROM klientet
    WHERE klient_id = p_klient_id;

    IF v_klient_id = 0 THEN
      p_rezultati := 'Gabim: Klienti me ID ' || p_klient_id || ' nuk ekziston.';
      RETURN;
    END IF;
    
    IF p_abonim_id IS NOT NULL THEN
      SELECT COUNT(*) INTO v_abonim_id
      FROM abonimet
      WHERE abonimi_id = p_abonim_id AND klient_id = p_klient_id;

      IF v_abonim_id = 0 THEN
        p_rezultati := 'Gabim: Abonimi i specifikuar nuk ekziston ose nuk i përket këtij klienti.';
        RETURN;
      END IF;
    END IF;
  END IF;

  INSERT INTO aktiviteti_parkimit (
    pika_parkimi_id,
    targa,
    klient_id,
    abonim_id
  ) VALUES (
    p_pika_parkimi_id,
    p_targa,
    p_klient_id,
    p_abonim_id
  ) RETURNING aktiviteti_id INTO p_aktiviteti_id;
  
  COMMIT;
  p_rezultati := 'Automjeti u regjistrua me sukses në parkim. ID e aktivitetit: ' || p_aktiviteti_id;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    ROLLBACK;
    p_rezultati := 'Gabim: Pika e parkimit nuk ekziston.';
  WHEN OTHERS THEN
    ROLLBACK;
    p_rezultati := 'Gabim: ' || SQLERRM;
END parkim_automjeti;
/

--Funksioni per te llogaritur cmimin e parkimit
CREATE OR REPLACE FUNCTION llogarit_cmimin (
    p_pika_parkimi_id IN INT,
    p_koha_hyrjes IN TIMESTAMP,
    p_koha_daljes IN TIMESTAMP
) RETURN NUMBER IS
    v_cmimi NUMBER := 0;
    v_ore_total NUMBER;
    v_cmimi_gjetur BOOLEAN := FALSE;
BEGIN
    IF p_koha_daljes IS NULL OR p_koha_daljes <= p_koha_hyrjes THEN
        RETURN 0;
    END IF;
    
    v_ore_total := EXTRACT(DAY FROM (p_koha_daljes - p_koha_hyrjes)) * 24 + 
                 EXTRACT(HOUR FROM (p_koha_daljes - p_koha_hyrjes)) + 
                 EXTRACT(MINUTE FROM (p_koha_daljes - p_koha_hyrjes)) / 60;
    
    FOR cmim_rec IN (
        SELECT cmimi, ora_fillimit, ora_mbarimit
        FROM cmime_parkimi
        WHERE pika_parkimi_id = p_pika_parkimi_id
        ORDER BY ora_fillimit
    ) LOOP
        IF v_ore_total > cmim_rec.ora_fillimit AND v_ore_total <= cmim_rec.ora_mbarimit THEN
            v_cmimi := cmim_rec.cmimi;
            v_cmimi_gjetur := TRUE;
            EXIT;
        END IF;
    END LOOP;
    
    IF NOT v_cmimi_gjetur AND v_ore_total > 0 THEN
        SELECT MAX(cmimi) INTO v_cmimi
        FROM cmime_parkimi
        WHERE pika_parkimi_id = p_pika_parkimi_id;
    END IF;
    
    RETURN v_cmimi;
END llogarit_cmimin;
/

--Procedura per te shfaqur raport ditor
CREATE OR REPLACE PROCEDURE shfaq_raporti_ditor (
    p_pika_parkimi_id IN INT,
    p_data IN DATE DEFAULT SYSDATE,
    p_rezultati OUT VARCHAR2
) IS
    v_totali NUMBER := 0;
    v_automjete_total INT := 0;
    v_ora_mesatare NUMBER := 0;
    v_punonjes_count INT := 0;
BEGIN
    -- Totali i transaksioneve
    SELECT NVL(SUM(shuma), 0) INTO v_totali
    FROM transaksionet
    WHERE pika_parkimi_id = p_pika_parkimi_id
      AND TRUNC(data_transaksionit) = TRUNC(p_data);
    
    -- Numri i automjeteve të parkuara
    SELECT COUNT(*) INTO v_automjete_total
    FROM aktiviteti_parkimit
    WHERE pika_parkimi_id = p_pika_parkimi_id
      AND TRUNC(koha_hyrjes) = TRUNC(p_data);
    
    -- Ora mesatare e parkimit
    SELECT NVL(AVG(ore_total), 0) INTO v_ora_mesatare
    FROM aktiviteti_parkimit
    WHERE pika_parkimi_id = p_pika_parkimi_id
      AND TRUNC(koha_hyrjes) = TRUNC(p_data)
      AND koha_daljes IS NOT NULL;
    
    p_rezultati := 'RAPORTI DITOR - ' || TO_CHAR(p_data, 'DD/MM/YYYY') || chr(10) ||
                   '=====================================' + chr(10)||
                   'Totali i të hyrjeve: ' || v_totali || ' LEK'+chr(10)||
                   'Automjete të parkuara: ' || v_automjete_total+chr(10)||
                   'Kohëzgjatja mesatare: ' || ROUND(v_ora_mesatare, 2) || ' orë';
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_rezultati := 'Nuk u gjetën të dhëna për datën e specifikuar.';
    WHEN OTHERS THEN
        p_rezultati := 'Gabim: ' || SQLERRM;
END shfaq_raporti_ditor;
/

--Procedura per te shfaqur raport mujor
CREATE OR REPLACE PROCEDURE shfaq_raporti_mujor (
    p_muaji IN INT,
    p_viti IN INT,
    p_rezultati OUT VARCHAR2
) IS
    CURSOR c_raporte IS
        SELECT pp.vendndodhja,
               COUNT(t.transaksion_id) as numri_transaksioneve,
               SUM(t.shuma) as te_hyrat_totale,
               COUNT(DISTINCT ap.targa) as automjete_unik
        FROM transaksionet t
        JOIN aktiviteti_parkimit ap ON t.aktiviteti_id = ap.aktiviteti_id
        JOIN pika_parkimi pp ON t.pika_parkimi_id = pp.pika_parkimi_id
        WHERE EXTRACT(MONTH FROM t.data_transaksionit) = p_muaji
          AND EXTRACT(YEAR FROM t.data_transaksionit) = p_viti
        GROUP BY pp.vendndodhja
        ORDER BY te_hyrat_totale DESC;
    
    v_raporti VARCHAR2(4000);
    v_totali NUMBER := 0;
BEGIN
    v_raporti := 'RAPORTI MUJOR - ' || p_muaji || '/' || p_viti || chr(10) ||
                 '=====================================' || chr(10);
    
    FOR rec IN c_raporte LOOP
        v_raporti := v_raporti || rec.vendndodhja || ':' || chr(10) ||
                     '  Transaksione: ' || rec.numri_transaksioneve || chr(10) ||
                     '  Të hyra: ' || rec.te_hyrat_totale || ' LEK' || chr(10) ||
                     '  Automjete unik: ' || rec.automjete_unik || chr(10) ||
                     '-----------------------------' || chr(10);
        v_totali := v_totali + rec.te_hyrat_totale;
    END LOOP;
    
    v_raporti := v_raporti || '=====================================' || chr(10) ||
                 'TOTALI I TE HYRJEVE: ' || v_totali || ' LEK';
    
    p_rezultati := v_raporti;
EXCEPTION
    WHEN OTHERS THEN
        p_rezultati := 'Gabim: ' || SQLERRM;
END shfaq_raporti_mujor;
/