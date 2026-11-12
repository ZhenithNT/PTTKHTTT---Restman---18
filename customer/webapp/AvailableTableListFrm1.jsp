<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDate, java.time.LocalTime, java.time.format.DateTimeFormatter, java.net.URLEncoder" %>
<%@ page import="restman.dao.DiningTableDAO1, restman.model.DiningTable1" %>
<%
    request.setCharacterEncoding("UTF-8");

    String arrivalDate = request.getParameter("arrivalDate");
    String arrivalTime = request.getParameter("arrivalTime");
    String guestCount = request.getParameter("guestCount");

    // thiếu hoặc sai tham số thì quay về trang nhập
    LocalDate date;
    int guests;
    try {
        date = LocalDate.parse(arrivalDate);
        LocalTime.parse(arrivalTime);
        guests = Integer.parseInt(guestCount);
    } catch (Exception e) {
        response.sendRedirect("SearchAvailableTableFrm1.jsp");
        return;
    }

    DiningTableDAO1 dao = new DiningTableDAO1();
    DiningTable1[] listAvailableTable = dao.searchAvailableTables(date, guests);

    String criteria = "&arrivalDate=" + arrivalDate
            + "&arrivalTime=" + URLEncoder.encode(arrivalTime, "UTF-8")
            + "&guestCount=" + guestCount;

    String pageTitle = "Chọn bàn";
    String pageSub = "Các bàn còn trống phù hợp với yêu cầu của bạn";
    int step = 2;
%>
<%@ include file="inc/header.jspf" %>

<div class="criteria">
    <div><span>Ngày đến</span><b><%= date.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) %></b></div>
    <div><span>Giờ đến</span><b><%= arrivalTime %></b></div>
    <div><span>Số khách</span><b><%= guestCount %></b></div>
</div>

<% if (listAvailableTable.length == 0) { %>
    <div class="error">Rất tiếc, không còn bàn phù hợp. Vui lòng thử ngày hoặc số lượng khách khác.</div>
<% } else { %>
    <table>
        <tr><th>Mã bàn</th><th>Tên bàn</th><th>Vị trí</th><th>Phù hợp cho</th><th></th></tr>
        <% for (DiningTable1 t : listAvailableTable) { %>
        <tr>
            <td><%= t.getTableCode() %></td>
            <td><b><%= t.getTableName() %></b></td>
            <td><%= t.getLocation() %></td>
            <td><%= t.getMinCapacity() %>-<%= t.getMaxCapacity() %> người</td>
            <td class="num"><a class="btn btn-small" href="ConfirmReservationFrm1.jsp?tableId=<%= t.getId() %><%= criteria %>">Chọn</a></td>
        </tr>
        <% } %>
    </table>
<% } %>

<div class="actions">
    <a class="btn btn-outline" href="SearchAvailableTableFrm1.jsp">Quay lại</a>
</div>
<%@ include file="inc/footer.jspf" %>
