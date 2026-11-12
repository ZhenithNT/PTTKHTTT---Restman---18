<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDate, java.time.LocalTime, java.net.URLEncoder" %>
<%
    request.setCharacterEncoding("UTF-8");

    String error = null;
    String arrivalDate = "", arrivalTime = "", guestCount = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        arrivalDate = request.getParameter("txtArrivalDate");
        arrivalTime = request.getParameter("txtArrivalTime");
        guestCount = request.getParameter("txtGuestCount");
        guestCount = guestCount == null ? "" : guestCount.trim();

        if (arrivalDate == null || arrivalDate.isEmpty() || arrivalTime == null || arrivalTime.isEmpty()
                || guestCount.isEmpty()) {
            error = "Vui lòng nhập đầy đủ ngày đến, giờ đến và số lượng khách.";
        } else if (LocalDate.parse(arrivalDate).isBefore(LocalDate.now())) {
            error = "Ngày đến không được nằm trong quá khứ.";
        } else if (LocalTime.parse(arrivalTime).isBefore(LocalTime.of(11, 0))
                || LocalTime.parse(arrivalTime).isAfter(LocalTime.of(22, 0))) {
            error = "Nhà hàng nhận khách từ 11:00 đến 22:00.";
        } else if (LocalTime.parse(arrivalTime).getMinute() % 15 != 0) {
            error = "Giờ đến chỉ nhận các mốc 00, 15, 30 hoặc 45 phút (ví dụ 19:15).";
        } else if (LocalDate.parse(arrivalDate).equals(LocalDate.now())
                && LocalTime.parse(arrivalTime).isBefore(LocalTime.now())) {
            error = "Giờ đến hôm nay không được nằm trong quá khứ.";
        } else {
            try {
                int n = Integer.parseInt(guestCount);
                if (n < 2 || n > 10) {
                    error = "Số lượng khách phải từ 2 đến 10 người.";
                }
            } catch (NumberFormatException e) {
                error = "Số lượng khách phải là số.";
            }
        }

        if (error == null) {
            response.sendRedirect("AvailableTableListFrm1.jsp?arrivalDate=" + arrivalDate
                    + "&arrivalTime=" + URLEncoder.encode(arrivalTime, "UTF-8")
                    + "&guestCount=" + guestCount);
            return;
        }
    }
    String pageTitle = "Đặt bàn trực tuyến";
    String pageSub = "Chọn ngày, giờ đến và số lượng khách để tìm bàn trống";
    int step = 1;
%>
<%@ include file="inc/header.jspf" %>

<% if (error != null) { %><div class="error"><%= error %></div><% } %>

<form method="post" action="SearchAvailableTableFrm1.jsp">
    <table class="form">
        <tr><td class="label">Ngày đến <span>*</span></td>
            <td><input type="date" name="txtArrivalDate" value="<%= arrivalDate %>" min="<%= LocalDate.now() %>"></td></tr>
        <tr><td class="label">Giờ đến <span>*</span></td>
            <td><input type="time" name="txtArrivalTime" value="<%= arrivalTime %>" min="11:00" max="22:00" step="900"></td></tr>
        <tr><td class="label">Số lượng khách <span>*</span></td>
            <td><input type="text" name="txtGuestCount" value="<%= guestCount %>" placeholder="Từ 2 đến 10 người"></td></tr>
    </table>
    <div class="actions">
        <a class="btn btn-outline" href="CustomerMainFrm1.jsp">Quay lại</a>
        <button class="btn" type="submit">Tìm bàn</button>
    </div>
</form>
<%@ include file="inc/footer.jspf" %>
