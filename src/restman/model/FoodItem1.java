package restman.model;

public class FoodItem1 {
    private int id;
    private String foodCode;
    private String foodName;
    private String foodCategory;
    private String description;
    private int unitPrice;
    private String image;
    private String servingStatus;

    public FoodItem1() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFoodCode() { return foodCode; }
    public void setFoodCode(String foodCode) { this.foodCode = foodCode; }

    public String getFoodName() { return foodName; }
    public void setFoodName(String foodName) { this.foodName = foodName; }

    public String getFoodCategory() { return foodCategory; }
    public void setFoodCategory(String foodCategory) { this.foodCategory = foodCategory; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getUnitPrice() { return unitPrice; }
    public void setUnitPrice(int unitPrice) { this.unitPrice = unitPrice; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public String getServingStatus() { return servingStatus; }
    public void setServingStatus(String servingStatus) { this.servingStatus = servingStatus; }
}
