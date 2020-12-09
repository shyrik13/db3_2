/* 1 vaicajums */
select LDGS.VARDS as vards,
       LDGS.UZVARDS as uzvards, LDGS.DARBA_POZICIJA as darbs,
       TO_CHAR (LDGS.STRADA_NO, 'YYYY-MM-DD HH24:MI:SS') as darb_no, TO_CHAR (LDGS.STRADA_LIDZ, 'YYYY-MM-DD HH24:MI:SS') as darb_lidz,
       LGS.NOSAUKUMS, TO_CHAR (LGS.DATUMS_NO, 'YYYY-MM-DD HH24:MI:SS') as datums_no, TO_CHAR (LGS.DATUMS_LIDZ, 'YYYY-MM-DD HH24:MI:SS') as datums_lidz
from LIDOSTA_DARBINIEKS_GRAFIKS_SKATS LDGS
         inner join LIDOSTA_GRAFIKS_SKATS LGS on LDGS.LIDOSTA_ID = LGS.LIDOSTA_ID and LDGS.NEDELAS_DIENA = LGS.NEDELAS_DIENA
where (VALUE (LDGS).SAKTS_AR(LGS.DATUMS_NO, LGS.DATUMS_LIDZ)) = 1 or (VALUE (LDGS).BEIDZAS_AR(LGS.DATUMS_NO, LGS.DATUMS_LIDZ)) = 1
;

/* 1 vaicajums check */
select LDGS.VARDS as vards,
       LDGS.UZVARDS as uzvards, LDGS.DARBA_POZICIJA as darbs,
       (LDGS.STRADA_NO - LGS.DATUMS_NO) diff_sakums,
       (LDGS.STRADA_LIDZ - LGS.DATUMS_LIDZ) diff_beigums
from LIDOSTA_DARBINIEKS_GRAFIKS_SKATS LDGS
         inner join LIDOSTA_GRAFIKS_SKATS LGS on LDGS.LIDOSTA_ID = LGS.LIDOSTA_ID and LDGS.NEDELAS_DIENA = LGS.NEDELAS_DIENA
where (VALUE (LDGS).SAKTS_AR(LGS.DATUMS_NO, LGS.DATUMS_LIDZ)) = 1 or (VALUE (LDGS).BEIDZAS_AR(LGS.DATUMS_NO, LGS.DATUMS_LIDZ)) = 1
;


/* 2 vaicajums */
select LDGS.VARDS as vards,
       LDGS.UZVARDS as uzvards, LDGS.DARBA_POZICIJA as darbs,
       TO_CHAR (LDGS.STRADA_NO, 'YYYY-MM-DD HH24:MI:SS') as darb_no, TO_CHAR (LDGS.STRADA_LIDZ, 'YYYY-MM-DD HH24:MI:SS') as darb_lidz,
       LS.NOSAUKUMS,
       TO_CHAR (LS.DATUMS_NO, 'YYYY-MM-DD HH24:MI:SS') as izlidojums, TO_CHAR (LS.DATUMS_LIDZ, 'YYYY-MM-DD HH24:MI:SS') as atlidojums
from LIDOSTA_DARBINIEKS_GRAFIKS_SKATS LDGS
         inner join LIDOJUMS_SKATS LS on
        LDGS.LIDOSTA_ID = DEREF(LS.LIDOSTA_NO).LIDOSTA_ID
where (VALUE (LDGS).DALEJI_NOSEGT(LS.DATUMS_NO, LS.DATUMS_LIDZ)) = 1
;

/* 2 vaicajums check */
select LDGS.VARDS as vards,
       LDGS.UZVARDS as uzvards,
       LS.NOSAUKUMS,
       (LDGS.STRADA_NO - LS.DATUMS_NO) diff_sakums,
       (LDGS.STRADA_LIDZ - LS.DATUMS_NO) diff_sakums_beigums,
       (LDGS.STRADA_LIDZ - LS.DATUMS_LIDZ) diff_beigums
from LIDOSTA_DARBINIEKS_GRAFIKS_SKATS LDGS
         inner join LIDOJUMS_SKATS LS on
        LDGS.LIDOSTA_ID = DEREF(LS.LIDOSTA_NO).LIDOSTA_ID
where (VALUE (LDGS).DALEJI_NOSEGT(LS.DATUMS_NO, LS.DATUMS_LIDZ)) = 1
;

/* 3 vaicajums */
select LS.LIDMASINA_ID, LS.NOSAUKUMS,
       TO_CHAR (LS.DATUMS_NO, 'YYYY-MM-DD HH24:MI:SS') izlidojums,
       TO_CHAR (LS.DATUMS_LIDZ, 'YYYY-MM-DD HH24:MI:SS') atlidojums,
       DEREF(LS.LIDOSTA_NO).NOSAUKUMS lidosta_no, DEREF(LS.LIDOSTA_UZ).NOSAUKUMS lidosta_uz
from LIDOJUMS_SKATS LS
where LS.DATUMS_NO < (TIMESTAMP '2020-12-02 12:00:00') and
        LS.DATUMS_LIDZ > (TIMESTAMP '2020-12-02 12:00:00')
;

/* 3 vaicajums check */
select LS.LIDMASINA_ID, LS.NOSAUKUMS,
       ((TIMESTAMP '2020-12-02 12:00:00') - LS.DATUMS_NO) diff_sakums,
       ((TIMESTAMP '2020-12-02 12:00:00') - LS.DATUMS_LIDZ) diff_beigums,
       DEREF(LS.LIDOSTA_NO).NOSAUKUMS lidosta_no, DEREF(LS.LIDOSTA_UZ).NOSAUKUMS lidosta_uz
from LIDOJUMS_SKATS LS
where LS.DATUMS_NO < (TIMESTAMP '2020-12-02 12:00:00') and
        LS.DATUMS_LIDZ > (TIMESTAMP '2020-12-02 12:00:00')
;

/* 4 vaicajums */
select LS.LIDMASINA_ID, LS.NOSAUKUMS,
       TO_CHAR (LS.DATUMS_NO, 'YYYY-MM-DD HH24:MI:SS') izlidojums,
       TO_CHAR (LS.DATUMS_LIDZ, 'YYYY-MM-DD HH24:MI:SS') atlidojums,
       DEREF(LS.LIDOSTA_NO).NOSAUKUMS lidosta_izlidojums,
       DEREF(LS.LIDOSTA_UZ).NOSAUKUMS lidosta_atlidojums
from LIDOJUMS_SKATS LS
         inner join LIDOSTA_GRAFIKS_SKATS LGS_NO on LGS_NO.LIDOSTA_ID = DEREF(LS.LIDOSTA_NO).LIDOSTA_ID
         inner join LIDOSTA_GRAFIKS_SKATS LGS_UZ on LGS_UZ.LIDOSTA_ID = DEREF(LS.LIDOSTA_UZ).LIDOSTA_ID
where VALUE(LGS_NO).DALEJI_NOSEGT(LS.DATUMS_NO, LS.DATUMS_LIDZ) = 1 and
        VALUE(LS).DALEJI_NOSEGT(VALUE(LGS_UZ).DATUMS_NO, VALUE(LGS_UZ).DATUMS_LIDZ) = 1 and
        VALUE(LGS_NO).IR_PRIEKSA(VALUE(LGS_UZ).DATUMS_NO) = 1
;

/* 4 vaicajums check */
select LS.NOSAUKUMS,
       DEREF(LS.LIDOSTA_NO).NOSAUKUMS lidosta_izlidojums,
       DEREF(LS.LIDOSTA_UZ).NOSAUKUMS lidosta_atlidojums,
       (VALUE(LGS_NO).DATUMS_NO - LS.DATUMS_NO) no_diff_sakums,
       (VALUE(LGS_NO).DATUMS_LIDZ - LS.DATUMS_NO) no_diff_sakums_beigums,
       (VALUE(LGS_NO).DATUMS_LIDZ - LS.DATUMS_LIDZ) no_diff_beigums,
       (LS.DATUMS_NO - VALUE(LGS_UZ).DATUMS_NO) uz_diff_sakums,
       (LS.DATUMS_LIDZ - VALUE(LGS_UZ).DATUMS_NO) uz_diff_sakums_beigums,
       (LS.DATUMS_LIDZ - VALUE(LGS_UZ).DATUMS_LIDZ) uz_diff_beigums,
       (VALUE(LGS_NO).DATUMS_LIDZ - VALUE(LGS_UZ).DATUMS_NO) lidostas_diff
from LIDOJUMS_SKATS LS
         inner join LIDOSTA_GRAFIKS_SKATS LGS_NO on LGS_NO.LIDOSTA_ID = DEREF(LS.LIDOSTA_NO).LIDOSTA_ID
         inner join LIDOSTA_GRAFIKS_SKATS LGS_UZ on LGS_UZ.LIDOSTA_ID = DEREF(LS.LIDOSTA_UZ).LIDOSTA_ID
where VALUE(LGS_NO).DALEJI_NOSEGT(LS.DATUMS_NO, LS.DATUMS_LIDZ) = 1 and
        VALUE(LS).DALEJI_NOSEGT(VALUE(LGS_UZ).DATUMS_NO, VALUE(LGS_UZ).DATUMS_LIDZ) = 1 and
        VALUE(LGS_NO).IR_PRIEKSA(VALUE(LGS_UZ).DATUMS_NO) = 1
;

/* 5 vaicajums */
select LS.NOSAUKUMS,
       TO_CHAR (LS.DATUMS_NO, 'YYYY-MM-DD HH24:MI:SS') izlidojums_l1,
       TO_CHAR (LS.DATUMS_LIDZ, 'YYYY-MM-DD HH24:MI:SS') atlidojums_l1,
       LS2.NOSAUKUMS,
       TO_CHAR (LS2.DATUMS_NO, 'YYYY-MM-DD HH24:MI:SS') izlidojums_l2,
       TO_CHAR (LS2.DATUMS_LIDZ, 'YYYY-MM-DD HH24:MI:SS') atlidojums_l2,
       DEREF(LS.LIDOSTA_NO).NOSAUKUMS lidosta_izlidojums_l1,
       DEREF(LS.LIDOSTA_UZ).NOSAUKUMS lidosta_atlidojums_l1,
       DEREF(LS2.LIDOSTA_NO).NOSAUKUMS lidosta_atlidojums_l2,
       DEREF(LS2.LIDOSTA_UZ).NOSAUKUMS lidosta_atlidojums_l2
from LIDOJUMS_SKATS LS
         inner join LIDOJUMS_SKATS LS2 on (DEREF(LS2.LIDOSTA_NO).LIDOSTA_ID =
                                           DEREF(LS.LIDOSTA_NO).LIDOSTA_ID or
                                           DEREF(LS2.LIDOSTA_UZ).LIDOSTA_ID =
                                           DEREF(LS.LIDOSTA_NO).LIDOSTA_ID or
                                           DEREF(LS2.LIDOSTA_NO).LIDOSTA_ID =
                                           DEREF(LS.LIDOSTA_UZ).LIDOSTA_ID or
                                           DEREF(LS2.LIDOSTA_UZ).LIDOSTA_ID =
                                           DEREF(LS.LIDOSTA_UZ).LIDOSTA_ID)
where VALUE(LS) != VALUE(LS2) and
    (((VALUE(LS).SAKTS_AR(VALUE(LS2).DATUMS_NO, VALUE(LS2).DATUMS_LIDZ) = 1 or
       VALUE(LS2).SAKTS_AR(VALUE(LS).DATUMS_NO, VALUE(LS).DATUMS_LIDZ) = 1) and
      DEREF(LS2.LIDOSTA_NO).LIDOSTA_ID = DEREF(LS.LIDOSTA_NO).LIDOSTA_ID) or
     (VALUE(LS).SATIEK(VALUE(LS2).DATUMS_NO) = 1 and
      DEREF(LS2.LIDOSTA_NO).LIDOSTA_ID = DEREF(LS.LIDOSTA_UZ).LIDOSTA_ID) or
     (VALUE(LS2).SATIEK(VALUE(LS).DATUMS_NO) = 1 and
      DEREF(LS2.LIDOSTA_UZ).LIDOSTA_ID = DEREF(LS.LIDOSTA_NO).LIDOSTA_ID) or
     ((VALUE(LS).BEIDZAS_AR(VALUE(LS2).DATUMS_NO, VALUE(LS2).DATUMS_LIDZ) = 1 or
       VALUE(LS2).BEIDZAS_AR(VALUE(LS).DATUMS_NO, VALUE(LS).DATUMS_LIDZ) = 1) and
      DEREF(LS2.LIDOSTA_UZ).LIDOSTA_ID = DEREF(LS.LIDOSTA_UZ).LIDOSTA_ID))
;

/* 5 vaicajums check */
select LS.NOSAUKUMS,
       LS2.NOSAUKUMS,
       case when (
               ((LS.DATUMS_NO - LS2.DATUMS_NO) = interval '0' second and (LS.DATUMS_LIDZ - LS2.DATUMS_LIDZ) < interval '0' second) or
               ((LS2.DATUMS_NO - LS.DATUMS_NO) = interval '0' second and (LS2.DATUMS_LIDZ - LS.DATUMS_LIDZ) < interval '0' second)
           ) then 'true' else 'false' end sakas_ar,
       case when ((LS.DATUMS_LIDZ - LS2.DATUMS_NO) = interval '0' second or (LS2.DATUMS_LIDZ - LS.DATUMS_NO) = interval '0' second) then 'true' else 'false' end satiek,
       case when (
               ((LS.DATUMS_LIDZ - LS2.DATUMS_LIDZ) = interval '0' second and (LS.DATUMS_NO - LS2.DATUMS_NO) < interval '0' second) or
               ((LS2.DATUMS_LIDZ - LS.DATUMS_LIDZ) = interval '0' second and (LS2.DATUMS_NO - LS.DATUMS_NO) < interval '0' second)
           ) then 'true' else 'false' end beidzas_ar
from LIDOJUMS_SKATS LS
         inner join LIDOJUMS_SKATS LS2 on (DEREF(LS2.LIDOSTA_NO).LIDOSTA_ID =
                                           DEREF(LS.LIDOSTA_NO).LIDOSTA_ID or
                                           DEREF(LS2.LIDOSTA_UZ).LIDOSTA_ID =
                                           DEREF(LS.LIDOSTA_NO).LIDOSTA_ID or
                                           DEREF(LS2.LIDOSTA_NO).LIDOSTA_ID =
                                           DEREF(LS.LIDOSTA_UZ).LIDOSTA_ID or
                                           DEREF(LS2.LIDOSTA_UZ).LIDOSTA_ID =
                                           DEREF(LS.LIDOSTA_UZ).LIDOSTA_ID)
where VALUE(LS) != VALUE(LS2) and
    (((VALUE(LS).SAKTS_AR(VALUE(LS2).DATUMS_NO, VALUE(LS2).DATUMS_LIDZ) = 1 or
       VALUE(LS2).SAKTS_AR(VALUE(LS).DATUMS_NO, VALUE(LS).DATUMS_LIDZ) = 1) and
      DEREF(LS2.LIDOSTA_NO).LIDOSTA_ID = DEREF(LS.LIDOSTA_NO).LIDOSTA_ID) or
     (VALUE(LS).SATIEK(VALUE(LS2).DATUMS_NO) = 1 and
      DEREF(LS2.LIDOSTA_NO).LIDOSTA_ID = DEREF(LS.LIDOSTA_UZ).LIDOSTA_ID) or
     (VALUE(LS2).SATIEK(VALUE(LS).DATUMS_NO) = 1 and
      DEREF(LS2.LIDOSTA_UZ).LIDOSTA_ID = DEREF(LS.LIDOSTA_NO).LIDOSTA_ID) or
     ((VALUE(LS).BEIDZAS_AR(VALUE(LS2).DATUMS_NO, VALUE(LS2).DATUMS_LIDZ) = 1 or
       VALUE(LS2).BEIDZAS_AR(VALUE(LS).DATUMS_NO, VALUE(LS).DATUMS_LIDZ) = 1) and
      DEREF(LS2.LIDOSTA_UZ).LIDOSTA_ID = DEREF(LS.LIDOSTA_UZ).LIDOSTA_ID))
;

/* 6 vaicajums */
select LDGS.VARDS, LDGS.UZVARDS,
       LDGS.DARBA_POZICIJA,
       TO_CHAR (LDGS.STRADA_NO, 'YYYY-MM-DD HH24:MI:SS') strada_no,
       TO_CHAR (LDGS.STRADA_LIDZ, 'YYYY-MM-DD HH24:MI:SS') strada_lidz,
       LS.NOSAUKUMS,
       TO_CHAR (LS.DATUMS_NO, 'YYYY-MM-DD HH24:MI:SS') izlidojums,
       TO_CHAR (LS.DATUMS_LIDZ, 'YYYY-MM-DD HH24:MI:SS') atlidojums,
       DEREF(LS.LIDOSTA_NO).NOSAUKUMS, DEREF(LS.LIDOSTA_UZ).NOSAUKUMS
from LIDOSTA_DARBINIEKS_GRAFIKS_SKATS LDGS
         inner join LIDOJUMS_SKATS LS on (DEREF(LS.LIDOSTA_NO).LIDOSTA_ID = LDGS.LIDOSTA_ID or
                                          DEREF(LS.LIDOSTA_UZ).LIDOSTA_ID = LDGS.LIDOSTA_ID)
where (VALUE(LS).SAKTS_AR(LDGS.STRADA_NO, LDGS.STRADA_LIDZ) = 1 or
       VALUE(LS).BEIDZAS_AR(LDGS.STRADA_NO, LDGS.STRADA_LIDZ) = 1 or
       VALUE(LDGS).IEKLAUJ(LS.DATUMS_NO, LS.DATUMS_LIDZ) = 1) and
        LDGS.DARBA_POZICIJA like '%despetceris%'
;

/* 6 vaicajums check */
select LDGS.VARDS, LDGS.UZVARDS,
       LDGS.DARBA_POZICIJA,
       LS.NOSAUKUMS,
       case when (
           ((LS.DATUMS_NO - LDGS.STRADA_NO) = interval '0' second and (LS.DATUMS_LIDZ - LDGS.STRADA_LIDZ) < interval '0' second)
           ) then 'true' else 'false' end sakas_ar,
       case when ((LDGS.STRADA_NO - LS.DATUMS_NO) < interval '0' second and (LDGS.STRADA_LIDZ - LS.DATUMS_LIDZ) > interval '0' second) then 'true' else 'false' end ieklauj,
       case when (
           ((LS.DATUMS_LIDZ - LDGS.STRADA_LIDZ) = interval '0' second and (LDGS.STRADA_NO - LS.DATUMS_NO) < interval '0' second)
           ) then 'true' else 'false' end beidzas_ar
from LIDOSTA_DARBINIEKS_GRAFIKS_SKATS LDGS
         inner join LIDOJUMS_SKATS LS on (DEREF(LS.LIDOSTA_NO).LIDOSTA_ID = LDGS.LIDOSTA_ID or
                                          DEREF(LS.LIDOSTA_UZ).LIDOSTA_ID = LDGS.LIDOSTA_ID)
where (VALUE(LS).SAKTS_AR(LDGS.STRADA_NO, LDGS.STRADA_LIDZ) = 1 or
       VALUE(LS).BEIDZAS_AR(LDGS.STRADA_NO, LDGS.STRADA_LIDZ) = 1 or
       VALUE(LDGS).IEKLAUJ(LS.DATUMS_NO, LS.DATUMS_LIDZ) = 1) and
        LDGS.DARBA_POZICIJA like '%despetceris%'
;