<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.format.DateTimeFormatter, restman.dao.ReservationDAO1, restman.model.Reservation1" %>
<%
    boolean isNew = "1".equals(request.getParameter("new"));

    int resId = 0;
    try {
        resId = Integer.parseInt(request.getParameter("resId"));
    } catch (Exception e) {
        resId = 0;
    }
    Reservation1 reservation = new ReservationDAO1().getReservationById(resId);

    String status = reservation == null ? "" : reservation.getReservationStatus();

    String pageTitle = "Phiếu đặt bàn";
    String pageSub = isNew ? "Cảm ơn bạn đã đặt bàn tại RestMan" : "Thông tin chi tiết phiếu đặt bàn";
    int step = isNew ? 4 : 0;
%>
<%@ include file="inc/header.jspf" %>

<% if (reservation == null) { %>
    <div class="error">Không tìm thấy phiếu đặt bàn.</div>
<% } else { %>
    <% if (isNew) { %>
        <div class="ok">Đặt bàn thành công. Vui lòng lưu lại mã đặt bàn và đến đúng giờ.</div>
    <% } %>
    <table class="info">
        <tr><td class="label">Mã đặt bàn</td><td><b><%= reservation.getReservationCode() %></b></td></tr>
        <tr><td class="label">Trạng thái</td>
            <td><span class="badge <%= "Đã đặt".equals(status) ? "badge-on" : "badge-off" %>"><%= status %></span></td></tr>
        <tr><td class="label">Khách hàng</td>
            <td><%= reservation.getCustomer().getFullName() %> - <%= reservation.getCustomer().getPhoneNumber() %>
                <% if (reservation.getCustomer().getEmail() != null && !reservation.getCustomer().getEmail().isEmpty()) { %>
                    <small><%= reservation.getCustomer().getEmail() %></small>
                <% } %></td></tr>
        <tr><td class="label">Bàn</td>
            <td><%= reservation.getTable().getTableCode() %> - <%= reservation.getTable().getTableName() %>
                <small><%= reservation.getTable().getLocation() %></small></td></tr>
        <tr><td class="label">Thời gian</td>
            <td><%= reservation.getArrivalDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) %>, <%= reservation.getArrivalTime() %></td></tr>
        <tr><td class="label">Số lượng khách</td><td><%= reservation.getGuestCount() %></td></tr>
        <tr><td class="label">Ghi chú</td><td><%= reservation.getNote() == null || reservation.getNote().isEmpty() ? "-" : reservation.getNote() %></td></tr>
        <tr><td class="label">Thời điểm đặt</td>
            <td><%= reservation.getCreatedAt().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")) %></td></tr>
    </table>
<% } %>

<div class="actions">
    <a class="btn" href="CustomerMainFrm1.jsp">Quay về</a>
</div>
<%@ include file="inc/footer.jspf" %>
