/* in terminal CREATE java CLASS
loadjava -v -u admin_temporal/admin_temporal@localhost:1522/shyrik -resolve -t
"C:\Users\shyri\IdeaProjects\RTU\DB3\ld2\src\main\java\KorolkoClass.java"
*/

/* in terminal DROP java CLASS
 dropjava -v -u admin_temporal/admin_temporal@localhost:1522/shyrik KorolkoClass.java
*/

/* show all user objects from database (also JAVA classes) */
select OBJECT_NAME, OBJECT_TYPE, STATUS
from USER_OBJECTS
where CREATED >= TO_DATE('02-12-2020', 'DD-MM-YYYY');

/* create java functions package */
create or replace package java_funkcijas_pakete as
    function prieksa(t1 in TIMESTAMP, t2 in TIMESTAMP)
        return BOOLEAN as language java name
        'KorolkoClass.prieksa(oracle.sql.TIMESTAMP, oracle.sql.TIMESTAMP) return boolean';

    function vienads(t1 in TIMESTAMP, t2 in TIMESTAMP)
        return BOOLEAN as language java name
        'KorolkoClass.vienads(oracle.sql.TIMESTAMP, oracle.sql.TIMESTAMP) return boolean';

    function dalejiNosegts(t1_no in TIMESTAMP,
                           t1_lidz in TIMESTAMP,
                           t2_no in TIMESTAMP,
                           t2_lidz in TIMESTAMP)
        return BOOLEAN as language java name
        'KorolkoClass.dalejiNosegts(oracle.sql.TIMESTAMP, oracle.sql.TIMESTAMP, oracle.sql.TIMESTAMP, oracle.sql.TIMESTAMP) return boolean';

    function ieklauj(t1_no in TIMESTAMP,
                     t1_lidz in TIMESTAMP,
                     t2_no in TIMESTAMP,
                     t2_lidz in TIMESTAMP)
        return BOOLEAN as language java name
        'KorolkoClass.ieklauj(oracle.sql.TIMESTAMP, oracle.sql.TIMESTAMP, oracle.sql.TIMESTAMP, oracle.sql.TIMESTAMP) return boolean';
end;
/
