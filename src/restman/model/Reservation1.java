package restman.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Reservation1 {
    private int id;
    private String reservationCode;
    private LocalDate arrivalDate;
    private String arrivalTime;
    private int guestCount;
    private String note;
    private LocalDateTime createdAt;
    private String reservationStatus;
    private DiningTable1 table;
    private Customer1 customer;

    public Reservation1() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getReservationCode() { return reservationCode; }
    public void setReservationCode(String reservationCode) { this.reservationCode = reservationCode; }

    public LocalDate getArrivalDate() { return arrivalDate; }
    public void setArrivalDate(LocalDate arrivalDate) { this.arrivalDate = arrivalDate; }

    public String getArrivalTime() { return arrivalTime; }
    public void setArrivalTime(String arrivalTime) { this.arrivalTime = arrivalTime; }

    public int getGuestCount() { return guestCount; }
    public void setGuestCount(int guestCount) { this.guestCount = guestCount; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public String getReservationStatus() { return reservationStatus; }
    public void setReservationStatus(String reservationStatus) { this.reservationStatus = reservationStatus; }

    public DiningTable1 getTable() { return table; }
    public void setTable(DiningTable1 table) { this.table = table; }

    public Customer1 getCustomer() { return customer; }
    public void setCustomer(Customer1 customer) { this.customer = customer; }
}
