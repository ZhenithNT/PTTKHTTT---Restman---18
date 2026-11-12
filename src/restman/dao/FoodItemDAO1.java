package restman.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import restman.model.FoodItem1;

public class FoodItemDAO1 extends DAO1 {

    public FoodItemDAO1() {
        super();
    }

    public FoodItem1[] getAllFoodItem() {
        ArrayList<FoodItem1> list = new ArrayList<FoodItem1>();
        try {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM FoodItem1 ORDER BY id");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(readFood(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list.toArray(new FoodItem1[0]);
    }

    // lưu món mới, mã món tự sinh dạng MA001, MA002... theo id
    public boolean addFoodItem(FoodItem1 food) {
        String sql = "INSERT INTO FoodItem1 (foodCode, foodName, foodCategory, description, image, servingStatus, unitPrice) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, "T" + System.currentTimeMillis()); // mã tạm
            ps.setString(2, food.getFoodName());
            ps.setString(3, food.getFoodCategory());
            ps.setString(4, food.getDescription());
            ps.setString(5, food.getImage());
            ps.setString(6, food.getServingStatus());
            ps.setInt(7, food.getUnitPrice());
            if (ps.executeUpdate() == 0) {
                return false;
            }
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) {
                int id = keys.getInt(1);
                String code = String.format("MA%03d", id);
                PreparedStatement up = con.prepareStatement("UPDATE FoodItem1 SET foodCode = ? WHERE id = ?");
                up.setString(1, code);
                up.setInt(2, id);
                up.executeUpdate();
                food.setId(id);
                food.setFoodCode(code);
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private FoodItem1 readFood(ResultSet rs) throws Exception {
        FoodItem1 f = new FoodItem1();
        f.setId(rs.getInt("id"));
        f.setFoodCode(rs.getString("foodCode"));
        f.setFoodName(rs.getString("foodName"));
        f.setFoodCategory(rs.getString("foodCategory"));
        f.setDescription(rs.getString("description"));
        f.setImage(rs.getString("image"));
        f.setServingStatus(rs.getString("servingStatus"));
        f.setUnitPrice(rs.getInt("unitPrice"));
        return f;
    }
}
