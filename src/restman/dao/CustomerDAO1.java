package restman.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import restman.model.Customer1;

public class CustomerDAO1 extends DAO1 {

    public CustomerDAO1() {
        super();
    }

    // tìm khách theo số điện thoại, chưa có thì thêm mới
    public Customer1 getOrCreateCustomer(Customer1 cust) {
        try {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM Customer WHERE phoneNumber = ?");
            ps.setString(1, cust.getPhoneNumber());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Customer1 found = new Customer1();
                found.setId(rs.getInt("id"));
                found.setFullName(rs.getString("fullName"));
                found.setPhoneNumber(rs.getString("phoneNumber"));
                found.setEmail(rs.getString("email"));
                found.setNote(rs.getString("note"));
                return found;
            }

            String sql = "INSERT INTO Customer (fullName, phoneNumber, email, note) VALUES (?, ?, ?, ?)";
            PreparedStatement ps2 = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps2.setString(1, cust.getFullName());
            ps2.setString(2, cust.getPhoneNumber());
            ps2.setString(3, cust.getEmail());
            ps2.setString(4, cust.getNote());
            ps2.executeUpdate();
            ResultSet keys = ps2.getGeneratedKeys();
            if (keys.next()) {
                cust.setId(keys.getInt(1));
                return cust;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
