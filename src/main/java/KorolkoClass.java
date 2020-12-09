import java.sql.*;
import oracle.sql.TIMESTAMP;

public class KorolkoClass {

    public static boolean prieksa (
            TIMESTAMP t1,
            TIMESTAMP t2
    ) throws SQLException {
        return t1.timestampValue().before(t2.timestampValue());
    }

    public static boolean vienads (
            TIMESTAMP t1,
            TIMESTAMP t2
    ) throws SQLException {
        return t1.timestampValue().equals(t2.timestampValue());
    }

    public static boolean dalejiNosegts (
            TIMESTAMP t1_no,
            TIMESTAMP t1_lidz,
            TIMESTAMP t2_no,
            TIMESTAMP t2_lidz
    ) throws SQLException {
        return t1_no.timestampValue().before(t2_no.timestampValue()) &&
               t1_lidz.timestampValue().after(t2_no.timestampValue()) &&
               t1_lidz.timestampValue().before(t2_lidz.timestampValue());
    }

    public static boolean ieklauj (
            TIMESTAMP t1_no,
            TIMESTAMP t1_lidz,
            TIMESTAMP t2_no,
            TIMESTAMP t2_lidz
    ) throws SQLException {
        return t1_no.timestampValue().before(t2_no.timestampValue()) &&
                t1_lidz.timestampValue().after(t2_lidz.timestampValue());
    }

}
