<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDate, java.time.LocalDateTime, java.time.format.DateTimeFormatter, java.net.URLEncoder" %>
<%@ page import="restman.dao.*, restman.model.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    String tableId = request.getParameter("tableId");
    String arrivalDate = request.getParameter("arrivalDate");
    String arrivalTime = request.getParameter("arrivalTime");
    String guestCount = request.getParameter("guestCount");

    // thiếu hoặc sai tham số thì quay về trang nhập
    LocalDate date;
    DiningTable1 table;
    DiningTableDAO1 tableDao = new DiningTableDAO1();
    try {
        date = LocalDate.parse(arrivalDate);
        java.time.LocalTime.parse(arrivalTime);
        Integer.parseInt(guestCount);
        table = tableDao.getTableById(Integer.parseInt(tableId));
    } catch (Exception e) {
        response.sendRedirect("SearchAvailableTableFrm1.jsp");
        return;
    }
    if (table == null) {
        response.sendRedirect("SearchAvailableTableFrm1.jsp");
        return;
    }

    String error = null;
    boolean tableTaken = false;
    String fullName = "", phone = "", email = "", note = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        fullName = request.getParameter("txtFullName").trim();
        phone = request.getParameter("txtPhoneNumber").trim();
        email = request.getParameter("txtEmail").trim();
        note = request.getParameter("txtNote").trim();

        if (fullName.isEmpty() || phone.isEmpty()) {
            error = "Vui lòng nhập họ tên và số điện thoại.";
        } else if (!phone.matches("[0-9]{9,11}")) {
            error = "Số điện thoại phải gồm 9 đến 11 chữ số.";
        } else if (!tableDao.checkTableAvailable(table.getId(), date)) {
            // bàn vừa bị người khác đặt
            tableTaken = true;
        } else {
            Customer1 customer = new Customer1();
            customer.setFullName(fullName);
            customer.setPhoneNumber(phone);
            customer.setEmail(email);
            customer.setNote("");
            customer = new CustomerDAO1().getOrCreateCustomer(customer);

            Reservation1 reservation = new Reservation1();
            reservation.setArrivalDate(date);
            reservation.setArrivalTime(arrivalTime);
            reservation.setGuestCount(Integer.parseInt(guestCount));
            reservation.setNote(note);
            reservation.setCreatedAt(LocalDateTime.now());
            reservation.setReservationStatus("Đã đặt");
            reservation.setTable(table);
            reservation.setCustomer(customer);

            if (new ReservationDAO1().createReservation(reservation)) {
                response.sendRedirect("ReservationResultFrm1.jsp?resId=" + reservation.getId() + "&new=1");
                return;
            }
            error = "Không lưu được đơn đặt bàn. Vui lòng thử lại.";
        }
    }
    String backUrl = "AvailableTableListFrm1.jsp?arrivalDate=" + arrivalDate
            + "&arrivalTime=" + URLEncoder.encode(arrivalTime, "UTF-8") + "&guestCount=" + guestCount;

    String pageTitle = "Thông tin đặt bàn";
    String pageSub = "Kiểm tra bàn đã chọn và nhập thông tin liên hệ";
    int step = 3;
%>
<%@ include file="inc/header.jspf" %>

<% if (tableTaken) { %>
    <div class="error">Bàn <%= table.getTableCode() %> vừa được khách khác đặt. Vui lòng chọn bàn khác.</div>
    <div class="actions end">
        <a class="btn" href="<%= backUrl %>">Chọn bàn khác</a>
    </div>
<% } else { %>
    <table class="info">
        <tr><td class="label">Bàn</td><td><b><%= table.getTableCode() %> - <%= table.getTableName() %></b>
            (<%= table.getLocation() %>, <%= table.getMinCapacity() %>-<%= table.getMaxCapacity() %> người)</td></tr>
        <tr><td class="label">Ngày đến</td><td><%= date.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) %></td></tr>
        <tr><td class="label">Giờ đến</td><td><%= arrivalTime %></td></tr>
        <tr><td class="label">Số lượng khách</td><td><%= guestCount %></td></tr>
    </table>

    <br>
    <% if (error != null) { %><div class="error"><%= error %></div><% } %>

    <form method="post" action="ConfirmReservationFrm1.jsp">
        <input type="hidden" name="tableId" value="<%= tableId %>">
        <input type="hidden" name="arrivalDate" value="<%= arrivalDate %>">
        <input type="hidden" name="arrivalTime" value="<%= arrivalTime %>">
        <input type="hidden" name="guestCount" value="<%= guestCount %>">
        <table class="form">
            <tr><td class="label">Họ tên <span>*</span></td>
                <td><input type="text" name="txtFullName" value="<%= fullName %>"></td></tr>
            <tr><td class="label">Số điện thoại <span>*</span></td>
                <td><input type="text" name="txtPhoneNumber" value="<%= phone %>" placeholder="Ví dụ: 0987654321"></td></tr>
            <tr><td class="label">Email</td>
                <td><input type="text" name="txtEmail" value="<%= email %>"></td></tr>
            <tr><td class="label">Ghi chú</td>
                <td><input type="text" name="txtNote" value="<%= note %>" placeholder="Yêu cầu thêm (nếu có)"></td></tr>
        </table>
        <div class="actions">
            <a class="btn btn-outline" href="<%= backUrl %>">Quay lại</a>
            <button class="btn" type="submit">Đặt bàn</button>
        </div>
    </form>
<% } %>
<%@ include file="inc/footer.jspf" %>
