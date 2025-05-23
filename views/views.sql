-- View per statusin ne kohe reale te pikave te parkimit
CREATE OR REPLACE VIEW vw_dashboard_parkimi AS
SELECT 
    pp.pika_parkimi_id,
    pp.vendndodhja,
    pp.vende_total,
    pp.vende_zene,
    pp.vende_lire,
    COUNT(ap.aktiviteti_id) AS automjete_aktive,
    SUM(NVL(ap.pagesa_total, 0)) AS sot_te_hyra,
    COUNT(r.rezervime_id) AS rezervime_aktive
FROM pika_parkimi pp
LEFT JOIN aktiviteti_parkimit ap ON pp.pika_parkimi_id = ap.pika_parkimi_id 
    AND TRUNC(ap.koha_hyrjes) = TRUNC(SYSDATE)
LEFT JOIN rezervime r ON pp.pika_parkimi_id = r.pika_parkimi_id 
    AND r.statusi_rezervimit = 'Aktiv'
GROUP BY pp.pika_parkimi_id, pp.vendndodhja, pp.vende_total, pp.vende_zene, pp.vende_lire;

--View per raportet financiare
CREATE OR REPLACE VIEW vw_raporti_financiar AS
SELECT 
    TO_CHAR(t.data_transaksionit, 'YYYY-MM') AS muaji,
    pp.vendndodhja,
    COUNT(t.transaksion_id) AS numri_transaksioneve,
    SUM(t.shuma) AS te_hyrat_totale,
    COUNT(DISTINCT ap.targa) AS automjete_unik,
    AVG(t.shuma) AS mesatarja_transaksionit
FROM transaksionet t
JOIN aktiviteti_parkimit ap ON t.aktiviteti_id = ap.aktiviteti_id
JOIN pika_parkimi pp ON t.pika_parkimi_id = pp.pika_parkimi_id
WHERE t.statusi = 'Perfunduar'
GROUP BY TO_CHAR(t.data_transaksionit, 'YYYY-MM'), pp.vendndodhja
ORDER BY muaji DESC;

--View per statistikat e performances se punonjesve
CREATE OR REPLACE VIEW vw_performanca_punonjes AS
SELECT 
    p.punonjes_id,
    p.emri || ' ' || p.mbiemri AS emri_mbiemri,
    p.roli,
    pp.vendndodhja,
    COUNT(t.transaksion_id) AS transaksione,
    SUM(t.shuma) AS te_hyra_totale,
    COUNT(DISTINCT TRUNC(t.data_transaksionit)) AS dite_pune,
    CASE 
        WHEN COUNT(DISTINCT TRUNC(t.data_transaksionit)) = 0 THEN 0
        ELSE SUM(t.shuma) / COUNT(DISTINCT TRUNC(t.data_transaksionit))
    END AS te_hyra_per_dite
FROM punonjesit p
JOIN pika_parkimi pp ON p.pika_parkimi_id = pp.pika_parkimi_id
LEFT JOIN transaksionet t ON p.punonjes_id = t.punonjes_id
GROUP BY p.punonjes_id, p.emri, p.mbiemri, p.roli, pp.vendndodhja;
