
/* LIDOSTAS GRAFIKA DATI TIPS */
create or replace type LIDOSTA_GRAFIKS_DATI_TYPE as object (
    datums_no TIMESTAMP,
    datums_lidz TIMESTAMP,
    nedelas_diena varchar2(24),
    order member function SORT_BY_DATUMS_NO (grafiks LIDOSTA_GRAFIKS_DATI_TYPE) return number,
    member function DALEJI_NOSEGT (obj_no in TIMESTAMP) return boolean,
    member function IR_PRIEKSA (obj_no in TIMESTAMP) return boolean
);
/
create or replace type body LIDOSTA_GRAFIKS_DATI_TYPE as
    order member function SORT_BY_DATUMS_NO (grafiks LIDOSTA_GRAFIKS_DATI_TYPE) return number is
    begin
        if (JAVA_FUNKCIJAS_PAKETE.PRIEKSA(SELF.DATUMS_NO, grafiks.DATUMS_NO)) then
            return -1;
        end if;
        return 1;
    end;
    member function DALEJI_NOSEGT (obj_no in TIMESTAMP) return boolean is
    begin
        return (JAVA_FUNKCIJAS_PAKETE.DALEJINOSEGTS(
            SELF.DATUMS_NO, SELF.DATUMS_LIDZ, obj_no)
            );
    end;
    member function IR_PRIEKSA (obj_no in TIMESTAMP) return boolean is
    begin
        return JAVA_FUNKCIJAS_PAKETE.PRIEKSA(SELF.DATUMS_LIDZ, obj_no);
    end;
end;
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

/* TABULA LIDOSTA ar kollekciju grafiki *//*
create table LIDOSTA (
                         lidosta_id number PRIMARY KEY,
                         nosaukums varchar2(255),
                         grafiki TABLE_LIDOSTA_GRAFIKS_DATI_TYPE
) nested table grafiki store as LIDOSTA_GRAFIKS_DATI;*/

/* LIDOSTAS DARBINIEKS GRAFIKA DATI TIPS */
create or replace type LIDOSTA_DARBINIEKS_GRAFIKS_DATI_TYPE as object (
    strada_no TIMESTAMP,
    strada_lidz TIMESTAMP,
    nedelas_diena varchar2(24),
    order member function SORT_BY_STRADA_NO (grafiks LIDOSTA_DARBINIEKS_GRAFIKS_DATI_TYPE) return number,
    member function SAKTS_AR (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return boolean,
    member function BEIDZAS_AR (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return boolean,
    member function DALEJI_NOSEGT (obj_no in TIMESTAMP) return boolean,
    member function IEKLAUJ (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return boolean
);
/
create or replace type body LIDOSTA_DARBINIEKS_GRAFIKS_DATI_TYPE as
    order member function SORT_BY_STRADA_NO (grafiks LIDOSTA_DARBINIEKS_GRAFIKS_DATI_TYPE) return number is
    begin
        if (JAVA_FUNKCIJAS_PAKETE.PRIEKSA(SELF.STRADA_NO, grafiks.STRADA_NO)) then
            return -1;
        end if;
        return 1;
    end;
    member function SAKTS_AR (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return boolean is
    begin
        return (JAVA_FUNKCIJAS_PAKETE.VIENADS(SELF.STRADA_NO, obj_no)) and
               (JAVA_FUNKCIJAS_PAKETE.PRIEKSA(SELF.STRADA_LIDZ, obj_lidz))
        ;
    end;
    member function BEIDZAS_AR (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return boolean is
    begin
        return (JAVA_FUNKCIJAS_PAKETE.VIENADS(SELF.STRADA_LIDZ, obj_lidz)) and
               (JAVA_FUNKCIJAS_PAKETE.PRIEKSA(obj_no, SELF.STRADA_NO))
        ;
    end;
    member function DALEJI_NOSEGT (obj_no in TIMESTAMP) return boolean is
    begin
        return (JAVA_FUNKCIJAS_PAKETE.DALEJINOSEGTS (
                SELF.STRADA_NO, SELF.STRADA_LIDZ, obj_no
        ));
    end;
    member function IEKLAUJ (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return boolean is
    begin
        return (JAVA_FUNKCIJAS_PAKETE.IEKLAUJ (
            SELF.STRADA_NO, SELF.STRADA_LIDZ, obj_no, obj_lidz
        ));
    end;
end;
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
    lidosta_uz REF LIDOSTA_TYPE,
    order member function SORT_BY_DATUMS_NO (lidojums LIDOJUMS_DATI_TYPE) return number,
    member function SAKTS_AR (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return boolean,
    member function BEIDZAS_AR (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return boolean,
    member function DALEJI_NOSEGT (obj_no in TIMESTAMP) return boolean,
    member function SATIEK (obj_no in TIMESTAMP) return boolean,
    member function GET_LIDOSTA_NO return LIDOSTA_TYPE,
    member function GET_LIDOSTA_UZ return LIDOSTA_TYPE
);
/
create or replace type body LIDOJUMS_DATI_TYPE as
    order member function SORT_BY_DATUMS_NO (lidojums LIDOJUMS_DATI_TYPE) return number is
    begin
        if (JAVA_FUNKCIJAS_PAKETE.PRIEKSA(SELF.DATUMS_NO, lidojums.DATUMS_NO)) then
            return -1;
        end if;
        return 1;
    end;
    member function SAKTS_AR (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return boolean is
    begin
        return (JAVA_FUNKCIJAS_PAKETE.VIENADS(SELF.DATUMS_NO, obj_no)) and
               (JAVA_FUNKCIJAS_PAKETE.PRIEKSA(SELF.DATUMS_LIDZ, obj_lidz))
        ;
    end;
    member function BEIDZAS_AR (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return boolean is
    begin
        return (JAVA_FUNKCIJAS_PAKETE.VIENADS(SELF.DATUMS_LIDZ, obj_lidz)) and
               (JAVA_FUNKCIJAS_PAKETE.PRIEKSA(obj_no, SELF.DATUMS_NO))
        ;
    end;
    member function DALEJI_NOSEGT (obj_no in TIMESTAMP) return boolean is
    begin
        return (JAVA_FUNKCIJAS_PAKETE.DALEJINOSEGTS (
                SELF.DATUMS_NO, SELF.DATUMS_LIDZ, obj_no
            ));
    end;
    member function SATIEK (obj_no in TIMESTAMP) return boolean is
    begin
        return (JAVA_FUNKCIJAS_PAKETE.VIENADS(SELF.DATUMS_LIDZ, obj_no));
    end;
    member function GET_LIDOSTA_NO return LIDOSTA_TYPE is
    begin
        return DEREF(SELF.LIDOSTA_NO);
    end;
    member function GET_LIDOSTA_UZ return LIDOSTA_TYPE is
    begin
        return DEREF(SELF.LIDOSTA_UZ);
    end;
end;
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
