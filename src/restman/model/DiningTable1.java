package restman.model;

public class DiningTable1 {
    private int id;
    private String tableCode;
    private String tableName;
    private String location;
    private String operatingStatus;
    private int minCapacity;
    private int maxCapacity;

    public DiningTable1() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTableCode() { return tableCode; }
    public void setTableCode(String tableCode) { this.tableCode = tableCode; }

    public String getTableName() { return tableName; }
    public void setTableName(String tableName) { this.tableName = tableName; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getOperatingStatus() { return operatingStatus; }
    public void setOperatingStatus(String operatingStatus) { this.operatingStatus = operatingStatus; }

    public int getMinCapacity() { return minCapacity; }
    public void setMinCapacity(int minCapacity) { this.minCapacity = minCapacity; }

    public int getMaxCapacity() { return maxCapacity; }
    public void setMaxCapacity(int maxCapacity) { this.maxCapacity = maxCapacity; }
}
