-- Trigger per te vendosur automatikisht daten e skadences
CREATE OR REPLACE TRIGGER trg_kartat_set_skadence
BEFORE INSERT ON kartat
FOR EACH ROW
BEGIN
  IF :NEW.data_skadences IS NULL THEN
    :NEW.data_skadences := :NEW.data_leshimit + 365;
  END IF;
END;
/


--Trigger per te ndaluar parkimin e automjeteve me te njejten targe
CREATE OR REPLACE TRIGGER trg_ndalimi_parkimit_duplikat
BEFORE INSERT ON aktiviteti_parkimit
FOR EACH ROW
DECLARE
  v_parked_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_parked_count
  FROM aktiviteti_parkimit
  WHERE targa = :NEW.targa 
    AND koha_daljes IS NULL;
  
  IF v_parked_count > 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Automjeti me targe ' || :NEW.targa || ' eshte tashme i parkuar!');
  END IF;
END ndalimi_parkimit_duplikat;
/

--Trigger per te perditesuar numrin e vendeve te zena ne pikat e parkimit
CREATE OR REPLACE TRIGGER trg_perditesimi_vendit_parkimit
BEFORE INSERT OR UPDATE ON aktiviteti_parkimit
FOR EACH ROW
BEGIN
  IF UPDATING AND :OLD.koha_daljes IS NULL AND :NEW.koha_daljes IS NOT NULL THEN
    UPDATE PIKA_PARKIMI
    SET VENDE_ZENE = VENDE_ZENE - 1
    WHERE pika_parkimi_id = :NEW.pika_parkimi_id;
  END IF;
  
  IF INSERTING AND :NEW.koha_daljes IS NULL THEN
    UPDATE PIKA_PARKIMI
    SET VENDE_ZENE = VENDE_ZENE + 1
    WHERE pika_parkimi_id = :NEW.pika_parkimi_id;
  END IF;
END perditesimi_vendit_parkimit;
/

--Trigger per te plotesuar tabelen audit te historikut te kartave
CREATE OR REPLACE TRIGGER trg_audit_historia_kartat
AFTER UPDATE OF statusi ON kartat
FOR EACH ROW
BEGIN
  INSERT INTO historia_kartave (karta_id, statusi_vjeter, statusi_i_ri, data_ndryshimit, arsyeja, ndryshuar_nga)
  VALUES (:NEW.karta_id, :OLD.statusi, :NEW.statusi, SYSTIMESTAMP, 
         CASE
            WHEN :OLD.statusi = 'Aktiv' AND :NEW.statusi = 'Skaduar' THEN 'Karta ka skaduar.'
            WHEN :OLD.statusi = 'Aktiv' AND :NEW.statusi = 'Anuluar' THEN 'Karta eshte anuluar.'
            WHEN :OLD.statusi = 'Skaduar' AND :NEW.statusi = 'Aktiv' THEN 'Karta rinovohet.'
            WHEN :OLD.statusi = 'Anuluar' AND :NEW.statusi = 'Aktiv' THEN 'Karta rinovohet.'
            ELSE NULL
          END,
          SYS_CONTEXT('USERENV', 'SESSION_USER'));
END;
/

--Trigger per te llogaritur automatikisht cmimin e parkimit
CREATE OR REPLACE TRIGGER trg_llogaritja_cmimit_parkimit
BEFORE UPDATE ON aktiviteti_parkimit
FOR EACH ROW
BEGIN
  IF :NEW.koha_daljes IS NOT NULL THEN
    :NEW.pagesa_total := llogarit_cmimin(:NEW.pika_parkimi_id, :NEW.koha_hyrjes, :NEW.koha_daljes);
  END IF;
END trg_llogaritja_cmimit_parkimit;
/

--Trigger per te perditesuar abonimin
CREATE OR REPLACE TRIGGER trg_perditesimi_abonimit
AFTER INSERT ON aktiviteti_parkimit
FOR EACH ROW
DECLARE
  v_lloji_abonimit VARCHAR2(50);
  v_perdorime_mbetur INT;
BEGIN
  IF :NEW.abonim_id IS NOT NULL THEN
    SELECT lloji_abonimit, perdorime_mbetur INTO v_lloji_abonimit, v_perdorime_mbetur
    FROM abonimet
    WHERE abonimi_id = :NEW.abonim_id;
    
    IF v_lloji_abonimit = 'Me perdorim' AND v_perdorime_mbetur > 0 THEN
      UPDATE abonimet
      SET perdorime_mbetur = perdorime_mbetur - 1
      WHERE abonimi_id = :NEW.abonim_id;
    END IF;
  END IF;
END trg_perditesimi_abonimit;
/

--Trigger per te validuar rezervimin e automjetit
CREATE OR REPLACE TRIGGER trg_validim_rezervimi
BEFORE INSERT ON rezervime
FOR EACH ROW
DECLARE
  v_rezervim_count INT;
BEGIN
  SELECT COUNT(*) INTO v_rezervim_count
  FROM rezervime
  WHERE automjet_id = :NEW.automjet_id 
    AND statusi_rezervimit = 'Aktiv'
    AND (((:NEW.koha_fillimit >= koha_fillimit AND :NEW.koha_fillimit < koha_mbarimit) OR
          (:NEW.koha_mbarimit > koha_fillimit AND :NEW.koha_mbarimit <= koha_mbarimit) OR
          (:NEW.koha_fillimit <= koha_fillimit AND :NEW.koha_mbarimit >= koha_mbarimit)));
  
  IF v_rezervim_count > 0 THEN
    RAISE_APPLICATION_ERROR(-20002, 'Automjeti ka rezervim aktiv qe mbivendoset me kete kohe.');
  END IF;
  
  IF :NEW.koha_fillimit >= :NEW.koha_mbarimit THEN
    RAISE_APPLICATION_ERROR(-20003, 'Koha e fillimit duhet te jete para kohes se mbarimit.');
  END IF;
  
  IF :NEW.koha_fillimit < SYSTIMESTAMP THEN
    RAISE_APPLICATION_ERROR(-20004, 'Nuk mund te beni rezervim ne te kaluaren.');
  END IF;
END trg_validim_rezervimi;
/

--Trigger per te kontrolluar skadimin e abonimit
CREATE OR REPLACE TRIGGER trg_kontrollo_skadim
BEFORE INSERT ON aktiviteti_parkimit
FOR EACH ROW
DECLARE
  v_statusi VARCHAR2(20);
  v_data_mbarimit TIMESTAMP;
  v_lloji_abonimit VARCHAR2(50);
BEGIN
    SELECT statusi, data_mbarimit, lloji_abonimit
    INTO v_statusi, v_data_mbarimit, v_lloji_abonimit
    FROM abonimet
    WHERE abonimi_id = :NEW.abonim_id;
    
    IF v_statusi != 'Aktiv' THEN
      RAISE_APPLICATION_ERROR(-20005, 'Abonimi nuk eshte aktiv.');
    END IF;
    
    IF v_lloji_abonimit = 'Mujor' AND v_data_mbarimit < SYSTIMESTAMP THEN
      RAISE_APPLICATION_ERROR(-20006, 'Abonimi mujor ka skaduar.');
    END IF;
    
    IF v_lloji_abonimit = 'Me perdorim' THEN
      DECLARE
        v_perdorime_mbetur INT;
      BEGIN
        SELECT perdorime_mbetur INTO v_perdorime_mbetur
        FROM abonimet
        WHERE abonimi_id = :NEW.abonim_id;
        
        IF v_perdorime_mbetur <= 0 THEN
          RAISE_APPLICATION_ERROR(-20007, 'Abonimi me perdorim nuk ka perdorime te mbetura.');
        END IF;
      END;
    END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20008, 'Abonimi nuk ekziston.');
END trg_kontrollo_skadim;
/


select * from historia_kartave;