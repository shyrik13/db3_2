LOAD DATA
INFILE	'darbinieks_vilnus.dat'
append into table LIDOSTA_DARBINIEKS
fields terminated by ","
TIMESTAMP FORMAT "yyyy-mm-dd HH24:MI:SS"
(
    lidosta_darbinieks_id  INTEGER EXTERNAL,
    vards,
    uzvards,
    status,
    darba_pozicija,
    lidosta_id INTEGER EXTERNAL,
    grafiki_file FILLER CHAR,
    grafiki      NESTED TABLE SDF(grafiki_file) COUNT (CONSTANT 5)
      (
        LIDOSTA_DARBINIEKS_GRAFIKS    COLUMN OBJECT
        (
          strada_no        POSITION(1:20) TIMESTAMP,
          strada_lidz      POSITION(21:40) TIMESTAMP,
          nedelas_diena    POSITION(41:51) CHAR(11)
        )
      )
)
