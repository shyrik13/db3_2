/* LIDOSTAS GRAFIKA SKATA TIPS */
create or replace type LIDOSTA_GRAFIKS_SKATS_TYPE as object (
    lidosta_id number,
    nosaukums varchar2(255),
    datums_no TIMESTAMP,
    datums_lidz TIMESTAMP,
    nedelas_diena varchar2(24),
    order member function SORT_BY_DATUMS_NO (grafiks LIDOSTA_GRAFIKS_SKATS_TYPE) return number,
    member function DALEJI_NOSEGT (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return number,
    member function IR_PRIEKSA (obj_no in TIMESTAMP) return number
);
/
create or replace type body LIDOSTA_GRAFIKS_SKATS_TYPE as
    order member function SORT_BY_DATUMS_NO (grafiks LIDOSTA_GRAFIKS_SKATS_TYPE) return number is
    begin
        if (JAVA_FUNKCIJAS_PAKETE.PRIEKSA(SELF.DATUMS_NO, grafiks.DATUMS_NO)) then
            return -1;
        end if;
        return 1;
    end;
    member function DALEJI_NOSEGT (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return number is
    begin
        if (JAVA_FUNKCIJAS_PAKETE.DALEJINOSEGTS(SELF.DATUMS_NO, SELF.DATUMS_LIDZ, obj_no, obj_lidz)) then
            return 1;
        end if;
        return 0;
    end;
    member function IR_PRIEKSA (obj_no in TIMESTAMP) return number is
    begin
        if (JAVA_FUNKCIJAS_PAKETE.PRIEKSA(SELF.DATUMS_LIDZ, obj_no)) then
            return 1;
        end if;
        return 0;
    end;
end;
/

/* LIDOSTAS DARBINIEKS GRAFIKA SKATA TIPS */
create or replace type LIDOSTA_DARBINIEKS_GRAFIKS_SKATS_TYPE as object (
    lidosta_darbinieks_id number,
    vards varchar2(255),
    uzvards varchar2(255),
    status varchar2(255),
    darba_pozicija varchar2(255),
    lidosta_id number,
    strada_no TIMESTAMP,
    strada_lidz TIMESTAMP,
    nedelas_diena varchar2(24),
    order member function SORT_BY_STRADA_NO (grafiks LIDOSTA_DARBINIEKS_GRAFIKS_SKATS_TYPE) return number,
    member function SAKTS_AR (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return number,
    member function BEIDZAS_AR (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return number,
    member function DALEJI_NOSEGT (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return number,
    member function IEKLAUJ (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return number
);
/

create or replace type body LIDOSTA_DARBINIEKS_GRAFIKS_SKATS_TYPE as
    order member function SORT_BY_STRADA_NO (grafiks LIDOSTA_DARBINIEKS_GRAFIKS_SKATS_TYPE) return number is
    begin
        if (JAVA_FUNKCIJAS_PAKETE.PRIEKSA(SELF.STRADA_NO, grafiks.STRADA_NO)) then
            return -1;
        end if;
        return 1;
    end;
    member function SAKTS_AR (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return number is
    begin
        if ((JAVA_FUNKCIJAS_PAKETE.VIENADS(SELF.STRADA_NO, obj_no)) and
            (JAVA_FUNKCIJAS_PAKETE.PRIEKSA(SELF.STRADA_LIDZ, obj_lidz))
            ) then
            return 1;
        end if;
        return 0;
    end;
    member function BEIDZAS_AR (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return number is
    begin
        if ((JAVA_FUNKCIJAS_PAKETE.VIENADS(SELF.STRADA_LIDZ, obj_lidz)) and
            (JAVA_FUNKCIJAS_PAKETE.PRIEKSA(obj_no, SELF.STRADA_NO))
            ) then
            return 1;
        end if;
        return 0;
    end;
    member function DALEJI_NOSEGT (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return number is
    begin
        if ((JAVA_FUNKCIJAS_PAKETE.DALEJINOSEGTS (
                SELF.STRADA_NO, SELF.STRADA_LIDZ, obj_no, obj_lidz
            ))) then
            return 1;
        end if;
        return 0;
    end;
    member function IEKLAUJ (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return number is
    begin
        if ((JAVA_FUNKCIJAS_PAKETE.IEKLAUJ (
                SELF.STRADA_NO, SELF.STRADA_LIDZ, obj_no, obj_lidz
            ))) then
            return 1;
        end if;
        return 0;
    end;
end;
/

create or replace type LIDOJUMS_SKATS_TYPE as object (
    lidmasina_id number,
    nosaukums varchar2(255),
    status varchar2(255),
    datums_no TIMESTAMP,
    datums_lidz TIMESTAMP,
    lidosta_no REF LIDOSTA_TYPE,
    lidosta_uz REF LIDOSTA_TYPE,
    order member function SORT_BY_DATUMS_NO (lidojums LIDOJUMS_SKATS_TYPE) return number,
    member function SAKTS_AR (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return number,
    member function BEIDZAS_AR (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return number,
    member function DALEJI_NOSEGT (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return number,
    member function SATIEK (obj_no in TIMESTAMP) return number
);
/

create or replace type body LIDOJUMS_SKATS_TYPE as
    order member function SORT_BY_DATUMS_NO (lidojums LIDOJUMS_SKATS_TYPE) return number is
    begin
        if (JAVA_FUNKCIJAS_PAKETE.PRIEKSA(SELF.DATUMS_NO, lidojums.DATUMS_NO)) then
            return -1;
        end if;
        return 1;
    end;
    member function SAKTS_AR (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return number is
    begin
        if ((JAVA_FUNKCIJAS_PAKETE.VIENADS(SELF.DATUMS_NO, obj_no)) and
            (JAVA_FUNKCIJAS_PAKETE.PRIEKSA(SELF.DATUMS_LIDZ, obj_lidz))) then
            return 1;
        end if;
        return 0;
    end;
    member function BEIDZAS_AR (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return number is
    begin
        if ((JAVA_FUNKCIJAS_PAKETE.VIENADS(SELF.DATUMS_LIDZ, obj_lidz)) and
            (JAVA_FUNKCIJAS_PAKETE.PRIEKSA(obj_no, SELF.DATUMS_NO))) then
            return 1;
        end if;
        return 0;
    end;
    member function DALEJI_NOSEGT (obj_no in TIMESTAMP, obj_lidz in TIMESTAMP) return number is
    begin
        if ((JAVA_FUNKCIJAS_PAKETE.DALEJINOSEGTS (SELF.DATUMS_NO, SELF.DATUMS_LIDZ, obj_no, obj_lidz))) then
            return 1;
        end if;
        return 0;
    end;
    member function SATIEK (obj_no in TIMESTAMP) return number is
    begin
        if (JAVA_FUNKCIJAS_PAKETE.VIENADS(SELF.DATUMS_LIDZ, obj_no)) then
            return 1;
        end if;
        return 0;
    end;
end;
/