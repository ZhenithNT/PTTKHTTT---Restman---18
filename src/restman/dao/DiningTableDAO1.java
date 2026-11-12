package restman.dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import restman.model.DiningTable1;

public class DiningTableDAO1 extends DAO1 {

    public DiningTableDAO1() {
        super();
    }

    // bàn đang hoạt động, vừa số khách và chưa ai đặt trong ngày đó
    public DiningTable1[] searchAvailableTables(LocalDate arrivalDate, int guestCount) {
        ArrayList<DiningTable1> list = new ArrayList<DiningTable1>();
        String sql = "SELECT * FROM DiningTable1 t "
                + "WHERE t.operatingStatus = 'Hoạt động' AND t.minCapacity <= ? AND t.maxCapacity >= ? "
                + "AND NOT EXISTS (SELECT 1 FROM Reservation1 r WHERE r.tableId = t.id "
                + "AND r.arrivalDate = ? AND r.reservationStatus = 'Đã đặt') "
                + "ORDER BY t.maxCapacity, t.tableCode";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, guestCount);
            ps.setInt(2, guestCount);
            ps.setDate(3, Date.valueOf(arrivalDate));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(readTable(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list.toArray(new DiningTable1[0]);
    }

    // kiểm tra lại bàn còn trống trong ngày không
    public boolean checkTableAvailable(int tableId, LocalDate arrivalDate) {
        String sql = "SELECT id FROM Reservation1 WHERE tableId = ? AND arrivalDate = ? "
                + "AND reservationStatus = 'Đã đặt'";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, tableId);
            ps.setDate(2, Date.valueOf(arrivalDate));
            return !ps.executeQuery().next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public DiningTable1 getTableById(int tableId) {
        try {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM DiningTable1 WHERE id = ?");
            ps.setInt(1, tableId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return readTable(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private DiningTable1 readTable(ResultSet rs) throws Exception {
        DiningTable1 t = new DiningTable1();
        t.setId(rs.getInt("id"));
        t.setTableCode(rs.getString("tableCode"));
        t.setTableName(rs.getString("tableName"));
        t.setLocation(rs.getString("location"));
        t.setOperatingStatus(rs.getString("operatingStatus"));
        t.setMinCapacity(rs.getInt("minCapacity"));
        t.setMaxCapacity(rs.getInt("maxCapacity"));
        return t;
    }
}
