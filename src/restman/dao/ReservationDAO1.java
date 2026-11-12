package restman.dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import restman.model.Customer1;
import restman.model.DiningTable1;
import restman.model.Reservation1;

public class ReservationDAO1 extends DAO1 {

    private static final String SELECT_ALL =
            "SELECT r.*, t.tableCode, t.tableName, t.location, t.minCapacity, t.maxCapacity, c.fullName, c.phoneNumber, c.email "
            + "FROM Reservation1 r JOIN DiningTable1 t ON r.tableId = t.id "
            + "JOIN Customer1 c ON r.customerId = c.id ";

    public ReservationDAO1() {
        super();
    }

    // lưu đơn mới, mã đặt bàn dạng DB0001, DB0002...
    public boolean createReservation(Reservation1 res) {
        String sql = "INSERT INTO Reservation1 (reservationCode, arrivalDate, arrivalTime, guestCount, note, "
                + "createdAt, reservationStatus, tableId, customerId) VALUES ('TMP', ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setDate(1, Date.valueOf(res.getArrivalDate()));
            ps.setString(2, res.getArrivalTime());
            ps.setInt(3, res.getGuestCount());
            ps.setString(4, res.getNote());
            ps.setTimestamp(5, Timestamp.valueOf(res.getCreatedAt()));
            ps.setString(6, res.getReservationStatus());
            ps.setInt(7, res.getTable().getId());
            ps.setInt(8, res.getCustomer().getId());
            ps.executeUpdate();

            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) {
                int id = keys.getInt(1);
                String code = String.format("DB%04d", id);
                PreparedStatement ps2 = con.prepareStatement("UPDATE Reservation1 SET reservationCode = ? WHERE id = ?");
                ps2.setString(1, code);
                ps2.setInt(2, id);
                ps2.executeUpdate();
                res.setId(id);
                res.setReservationCode(code);
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Reservation1 getReservationById(int resId) {
        try {
            PreparedStatement ps = con.prepareStatement(SELECT_ALL + "WHERE r.id = ?");
            ps.setInt(1, resId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return readReservation(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private Reservation1 readReservation(ResultSet rs) throws Exception {
        DiningTable1 t = new DiningTable1();
        t.setId(rs.getInt("tableId"));
        t.setTableCode(rs.getString("tableCode"));
        t.setTableName(rs.getString("tableName"));
        t.setLocation(rs.getString("location"));
        t.setMinCapacity(rs.getInt("minCapacity"));
        t.setMaxCapacity(rs.getInt("maxCapacity"));

        Customer1 c = new Customer1();
        c.setId(rs.getInt("customerId"));
        c.setFullName(rs.getString("fullName"));
        c.setPhoneNumber(rs.getString("phoneNumber"));
        c.setEmail(rs.getString("email"));

        Reservation1 r = new Reservation1();
        r.setId(rs.getInt("id"));
        r.setReservationCode(rs.getString("reservationCode"));
        r.setArrivalDate(rs.getDate("arrivalDate").toLocalDate());
        r.setArrivalTime(rs.getString("arrivalTime"));
        r.setGuestCount(rs.getInt("guestCount"));
        r.setNote(rs.getString("note"));
        r.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());
        r.setReservationStatus(rs.getString("reservationStatus"));
        r.setTable(t);
        r.setCustomer(c);
        return r;
    }
}
