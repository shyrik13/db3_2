
/* INSERT LIDOSTA dati */
begin
    insert into LIDOSTA VALUES (1, 'Lidosta Riga', TABLE_LIDOSTA_GRAFIKS_DATI_TYPE (
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-01 6:00:00', TIMESTAMP '2020-12-02 1:00:00', 'otrdiena'),
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-02 6:00:00', TIMESTAMP '2020-12-03 1:00:00', 'tresdiena'),
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-03 6:00:00', TIMESTAMP '2020-12-04 1:00:00', 'ceturtdiena'),
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-04 6:00:00', TIMESTAMP '2020-12-05 1:00:00', 'piektdiena'),
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-05 6:30:00', TIMESTAMP '2020-12-06 0:30:00', 'sestdiena'),
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-06 6:30:00', TIMESTAMP '2020-12-07 0:30:00', 'svetdiena'),
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-07 6:00:00', TIMESTAMP '2020-12-08 1:00:00', 'pirmdiena')
        ));

    insert into LIDOSTA VALUES (2, 'Lidosta Vilnus', TABLE_LIDOSTA_GRAFIKS_DATI_TYPE (
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-01 5:30:00', TIMESTAMP '2020-12-02 0:30:00', 'otrdiena'),
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-02 5:30:00', TIMESTAMP '2020-12-03 0:30:00', 'tresdiena'),
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-03 5:30:00', TIMESTAMP '2020-12-04 0:30:00', 'ceturtdiena'),
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-04 5:30:00', TIMESTAMP '2020-12-05 0:30:00', 'piektdiena'),
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-05 6:30:00', TIMESTAMP '2020-12-06 0:00:00', 'sestdiena'),
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-06 5:30:00', TIMESTAMP '2020-12-07 0:00:00', 'svetdiena'),
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-07 5:30:00', TIMESTAMP '2020-12-08 0:30:00', 'pirmdiena')
        ));

    insert into LIDOSTA VALUES (3, 'Lidosta Berlin', TABLE_LIDOSTA_GRAFIKS_DATI_TYPE (
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-01 6:30:00', TIMESTAMP '2020-12-02 1:30:00', 'otrdiena'),
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-02 6:30:00', TIMESTAMP '2020-12-03 1:30:00', 'tresdiena'),
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-03 6:30:00', TIMESTAMP '2020-12-04 1:30:00', 'ceturtdiena'),
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-04 6:30:00', TIMESTAMP '2020-12-05 1:30:00', 'piektdiena'),
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-05 6:45:00', TIMESTAMP '2020-12-06 0:45:00', 'sestdiena'),
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-06 6:45:00', TIMESTAMP '2020-12-07 0:45:00', 'svetdiena'),
            LIDOSTA_GRAFIKS_DATI_TYPE (TIMESTAMP '2020-12-07 6:30:00', TIMESTAMP '2020-12-08 1:30:00', 'pirmdiena')
        ));
end;

/* INSERT LIDMASINA dati */
DECLARE
    lidosta1  REF LIDOSTA_TYPE;
    lidosta2  REF LIDOSTA_TYPE;
    lidosta3  REF LIDOSTA_TYPE;
BEGIN
    SELECT  REF(l)
    INTO    lidosta1
    FROM    LIDOSTA l
    WHERE   LIDOSTA_ID = 1;

    SELECT  REF(l)
    INTO    lidosta2
    FROM    LIDOSTA l
    WHERE   LIDOSTA_ID = 2;

    SELECT  REF(l)
    INTO    lidosta3
    FROM    LIDOSTA l
    WHERE   LIDOSTA_ID = 3;

    INSERT INTO LIDMASINA VALUES (1, 'LIDM_001', 'viss kartiba', TABLE_LIDOJUMS_DATI_TYPE (
        LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-01 06:00:00', TIMESTAMP '2020-12-01 10:00:00', lidosta1, lidosta3),
        LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-01 14:00:00', TIMESTAMP '2020-12-01 18:00:00', lidosta3, lidosta2),
        LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-02 00:00:00', TIMESTAMP '2020-12-02 07:00:00', lidosta2, lidosta1),

        LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-02 12:00:00', TIMESTAMP '2020-12-02 16:00:00', lidosta1, lidosta3),
        LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-03 01:00:00', TIMESTAMP '2020-12-03 06:00:00', lidosta3, lidosta2),
        LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-03 11:00:00', TIMESTAMP '2020-12-03 17:00:00', lidosta2, lidosta1),

        LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-03 22:00:00', TIMESTAMP '2020-12-04 01:00:00', lidosta1, lidosta3),
        LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-04 06:30:00', TIMESTAMP '2020-12-04 12:00:00', lidosta3, lidosta2),
        LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-04 15:00:00', TIMESTAMP '2020-12-04 20:00:00', lidosta2, lidosta1)
    ));
    INSERT INTO LIDMASINA VALUES (2, 'LIDM_002', 'viss kartiba', TABLE_LIDOJUMS_DATI_TYPE (
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-01 06:30:00', TIMESTAMP '2020-12-01 10:00:00', lidosta3, lidosta1),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-01 14:00:00', TIMESTAMP '2020-12-01 18:00:00', lidosta3, lidosta2),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-01 20:00:00', TIMESTAMP '2020-12-02 0:00:00', lidosta2, lidosta3),

            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-02 06:30:00', TIMESTAMP '2020-12-02 16:00:00', lidosta3, lidosta2),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-02 19:00:00', TIMESTAMP '2020-12-02 23:30:00', lidosta2, lidosta1),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-03 06:00:00', TIMESTAMP '2020-12-03 10:30:00', lidosta1, lidosta3),

            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-03 18:00:00', TIMESTAMP '2020-12-03 23:00:00', lidosta1, lidosta3),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-04 07:30:00', TIMESTAMP '2020-12-04 11:00:00', lidosta3, lidosta2),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-04 16:00:00', TIMESTAMP '2020-12-04 21:30:00', lidosta2, lidosta1)
        ));
    INSERT INTO LIDMASINA VALUES (3, 'LIDM_003', 'problemas ar kreiso sparni', TABLE_LIDOJUMS_DATI_TYPE (
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-01 08:00:00', TIMESTAMP '2020-12-01 12:30:00', lidosta1, lidosta2),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-01 15:00:00', TIMESTAMP '2020-12-01 19:30:00', lidosta2, lidosta3),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-02 00:00:00', TIMESTAMP '2020-12-02 06:00:00', lidosta3, lidosta1),

            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-02 09:30:00', TIMESTAMP '2020-12-02 15:00:00', lidosta1, lidosta3),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-02 19:30:00', TIMESTAMP '2020-12-03 00:00:00', lidosta3, lidosta1),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-04 07:45:00', TIMESTAMP '2020-12-04 12:15:00', lidosta1, lidosta2),

            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-04 14:00:00', TIMESTAMP '2020-12-04 18:00:00', lidosta2, lidosta3),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-04 21:30:00', TIMESTAMP '2020-12-05 01:00:00', lidosta2, lidosta1),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-05 08:15:00', TIMESTAMP '2020-12-05 11:45:00', lidosta1, lidosta3)
        ));
    INSERT INTO LIDMASINA VALUES (4, 'LIDM_004', 'viss kartiba', TABLE_LIDOJUMS_DATI_TYPE (
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-01 08:15:00', TIMESTAMP '2020-12-01 12:30:00', lidosta1, lidosta2),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-01 15:00:00', TIMESTAMP '2020-12-01 19:00:00', lidosta2, lidosta1),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-01 22:00:00', TIMESTAMP '2020-12-02 01:30:00', lidosta1, lidosta3),

            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-02 07:00:00', TIMESTAMP '2020-12-02 11:30:00', lidosta3, lidosta2),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-02 13:30:00', TIMESTAMP '2020-12-02 16:45:00', lidosta2, lidosta1),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-02 19:00:00', TIMESTAMP '2020-12-02 23:30:00', lidosta1, lidosta3),

            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-03 06:30:00', TIMESTAMP '2020-12-03 11:00:00', lidosta3, lidosta2),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-03 14:30:00', TIMESTAMP '2020-12-03 17:00:00', lidosta2, lidosta1),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-03 21:00:00', TIMESTAMP '2020-12-04 00:00:00', lidosta1, lidosta2)
        ));
    INSERT INTO LIDMASINA VALUES (5, 'LIDM_005', 'problemas ar labo sparni', TABLE_LIDOJUMS_DATI_TYPE (
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-01 08:00:00', TIMESTAMP '2020-12-01 13:00:00', lidosta2, lidosta3),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-01 16:00:00', TIMESTAMP '2020-12-01 19:00:00', lidosta3, lidosta2),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-01 22:00:00', TIMESTAMP '2020-12-02 01:00:00', lidosta2, lidosta1),

            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-02 07:00:00', TIMESTAMP '2020-12-02 10:00:00', lidosta1, lidosta2),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-02 12:00:00', TIMESTAMP '2020-12-02 15:00:00', lidosta2, lidosta1),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-02 17:00:00', TIMESTAMP '2020-12-02 21:00:00', lidosta1, lidosta3),

            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-02 22:00:00', TIMESTAMP '2020-12-03 00:30:00', lidosta3, lidosta2),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-03 05:30:00', TIMESTAMP '2020-12-03 09:00:00', lidosta2, lidosta1),
            LIDOJUMS_DATI_TYPE (TIMESTAMP '2020-12-03 13:30:00', TIMESTAMP '2020-12-03 16:45:00', lidosta1, lidosta2)
        ));
END;