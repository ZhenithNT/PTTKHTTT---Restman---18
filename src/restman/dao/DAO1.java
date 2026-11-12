package restman.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO1 {
    public static Connection con;

    public DAO1() {
        if (con == null) {
            String dbUrl = "jdbc:mysql://localhost:3306/restman?autoReconnect=true"
                    + "&useUnicode=true&characterEncoding=UTF-8";
            String dbClass = "com.mysql.cj.jdbc.Driver";
            try {
                Class.forName(dbClass);
                con = DriverManager.getConnection(dbUrl, "root", "");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
