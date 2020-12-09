
/* LIDOSTAS GRAFIKA DATI TIPS */
create or replace type LIDOSTA_GRAFIKS_DATI_TYPE as object (
    datums_no TIMESTAMP,
    datums_lidz TIMESTAMP,
    nedelas_diena varchar2(24)
);
/

/* TABULA LIDOSTAS GRAFIKA DATI TIPS */
create or replace type TABLE_LIDOSTA_GRAFIKS_DATI_TYPE as table of LIDOSTA_GRAFIKS_DATI_TYPE;

/* LIDOSTA TIPS */
create or replace type LIDOSTA_TYPE as object (
    lidosta_id number,
    nosaukums varchar2(255),
    grafiki TABLE_LIDOSTA_GRAFIKS_DATI_TYPE
);
/

/* TABULA LIDOSTA ar kollekciju grafiki */
create table LIDOSTA of LIDOSTA_TYPE nested table grafiki store as LIDOSTA_GRAFIKS_DATI;
alter table LIDOSTA add primary key (lidosta_id);

/* LIDOSTAS DARBINIEKS GRAFIKA DATI TIPS */
create or replace type LIDOSTA_DARBINIEKS_GRAFIKS_DATI_TYPE as object (
    strada_no TIMESTAMP,
    strada_lidz TIMESTAMP,
    nedelas_diena varchar2(24)
);
/

/* TABULA LIDOSTAS DARBINIEKS GRAFIKA DATI TIPS */
create or replace type TABLE_LIDOSTA_DARBINIEKS_GRAFIKS_DATI_TYPE as table of LIDOSTA_DARBINIEKS_GRAFIKS_DATI_TYPE;

/* TABULA LIDOSTA_DARBINIEKS ar kollekciju grafiki */
create table LIDOSTA_DARBINIEKS (
                         lidosta_darbinieks_id number PRIMARY KEY,
                         vards varchar2(255),
                         uzvards varchar2(255),
                         status varchar2(255),
                         darba_pozicija varchar2(255),
                         lidosta_id number,
                         CONSTRAINT FK_PersonOrder FOREIGN KEY (lidosta_id)
                             REFERENCES LIDOSTA(lidosta_id),
                         grafiki TABLE_LIDOSTA_DARBINIEKS_GRAFIKS_DATI_TYPE
) nested table grafiki store as LIDOSTA_DARBINIEKS_GRAFIKS_DATI;

/* LIDOJUMS DATI TIPS */
create or replace type LIDOJUMS_DATI_TYPE as object (
    datums_no TIMESTAMP,
    datums_lidz TIMESTAMP,
    lidosta_no REF LIDOSTA_TYPE,
    lidosta_uz REF LIDOSTA_TYPE
);
/

/* TABULA LIDOJUMS DATI TIPS */
create or replace type TABLE_LIDOJUMS_DATI_TYPE as table of LIDOJUMS_DATI_TYPE;

/* TABULA LIDMASINA ar kollekciju lidojumi */
create table LIDMASINA (
                                    lidmasina_id number PRIMARY KEY,
                                    nosaukums varchar2(255),
                                    status varchar2(255),
                                    lidojumi TABLE_LIDOJUMS_DATI_TYPE
) nested table lidojumi store as LIDOJUMS_DATI;
