package restman.model;

public class Employee1 {
    private int id;
    private String fullName;
    private String phoneNumber;
    private String email;
    private String position;
    private String workingStatus;
    private Account1 account;

    public Employee1() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }

    public String getWorkingStatus() { return workingStatus; }
    public void setWorkingStatus(String workingStatus) { this.workingStatus = workingStatus; }

    public Account1 getAccount() { return account; }
    public void setAccount(Account1 account) { this.account = account; }
}
