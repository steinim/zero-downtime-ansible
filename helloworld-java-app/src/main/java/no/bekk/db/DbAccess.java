package no.bekk.db;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DbAccess {
    private Connection connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;
    private String user = null;
    private String password = null;
    private String dbServer = null;
    private String tablename = null;
    private String schema = null;
    private static final Logger LOG = LoggerFactory.getLogger(DbAccess.class);


    public DbAccess() {
        user = System.getProperty("db.user");
        schema = System.getProperty("db.schema");
        password = System.getProperty("db.password");
        dbServer = System.getProperty("db.server");
        tablename = System.getProperty("db.tablename");
        String dbUrl = "jdbc:postgresql://" + dbServer + "/" + schema + "?user=" + user + "&password=" + password;
        try {
            connect = DriverManager.getConnection(dbUrl);
        } catch (SQLException e) {
            LOG.error(e.getMessage() + " Tried connecting to " + dbUrl);
        }
    }

    public String sayHello() throws Exception {
        String message = null;
        try {
            if (connect == null) {
                LOG.error("No connection to database.");
                return "No connection to database :(";
            }
            statement = connect.createStatement();
            resultSet = statement.executeQuery("select * from " + tablename);
            if (resultSet == null) {
                return "Nothing :(";
            }
            while (resultSet.next()) {
                message = resultSet.getString("MESSAGE");
            }
        } catch(Exception e) {
            LOG.error(e.getMessage());
            return "An exception occurred: " +  e.getMessage() + " :(";
        }finally {
            close();
        }
        return message + " :)";
    }

    private void close() {
        try {
            if (resultSet != null) {
                resultSet.close();
            }

            if (statement != null) {
                statement.close();
            }

            if (connect != null) {
                connect.close();
            }
        } catch (Exception e) {

        }
    }

}
