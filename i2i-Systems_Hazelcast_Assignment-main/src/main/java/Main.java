import com.hazelcast.collection.IList;
import com.hazelcast.core.Hazelcast;
import com.hazelcast.core.HazelcastInstance;

import java.util.Random;
import java.sql.*;

public class Main {

    public static void main(String[] args) throws SQLException, ClassNotFoundException {

        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/database", "sys",
                "123");

        String queryInsert = "INSERT INTO NUM VALUES (dbms_random.random)";
        String querySelect = "SELECT * FROM NUM";

        Statement st = con.createStatement();

        Random random = new Random();
        HazelcastInstance Instance = Hazelcast.newHazelcastInstance();
        IList<Integer> randNumList = Instance.getList("randNumList");

        long startTimeInsert = System.currentTimeMillis();
        for (int i = 0; i < 100000; i++){
            randNumList.add(random.nextInt());
        }
        long endTimeInsert = System.currentTimeMillis();

        long startTimeGet = System.currentTimeMillis();
        for (int i = 0; i < 100000; i++){
            randNumList.get(i);
        }
        long endTimeGet = System.currentTimeMillis();

        randNumList.destroy();
        Instance.shutdown();

        long startTimeOracleInsert = System.currentTimeMillis();
        for (int i = 0; i < 100000; i++){
            st.executeUpdate(queryInsert);
        }
        long endTimeOracleInsert = System.currentTimeMillis();

        long startTimeOracleSelect = System.currentTimeMillis();
        ResultSet rs = st.executeQuery(querySelect);

        for (int i = 0; i < 100000; i++){
            rs.next();
            System.out.println(rs.getInt(1));
        }
        long endTimeOracleSelect = System.currentTimeMillis();


        System.out.println("Runtime for Hazelcast insert: " + (endTimeInsert - startTimeInsert)+" ms");
        System.out.println("Runtime for Hazelcast select: " + (endTimeGet - startTimeGet)+" ms");

        System.out.println("Runtime for Oracle insert: "+ (endTimeOracleInsert - startTimeOracleInsert)+" ms");
        System.out.println("Runtime for Oracle select: "+ (endTimeOracleSelect - startTimeOracleSelect)+" ms");
    }
}
