<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="restman.dao.FoodItemDAO1, restman.model.FoodItem1" %>
<%
    request.setCharacterEncoding("UTF-8");

    FoodItem1[] listFood = new FoodItemDAO1().getAllFoodItem();

    String[] categories = {"Món chính", "Món phụ", "Tráng miệng", "Đồ uống"};
    String pageTitle = "Quản lý món ăn";
    String pageSub = "Danh sách món ăn của nhà hàng";
%>
<%@ include file="inc/header.jspf" %>

<div class="toolbar">
    <div class="search">
        <input type="text" placeholder="Tìm theo tên hoặc mã món">
        <select>
            <option>Tất cả loại món</option>
            <% for (String c : categories) { %>
                <option><%= c %></option>
            <% } %>
        </select>
        <button class="btn" type="button">Tìm kiếm</button>
    </div>
    <a class="btn" href="AddFoodItemFrm1.jsp">+ Thêm món</a>
</div>
<div style="color:#6e6e6e; margin-bottom:6px;"><%= listFood.length %> món ăn</div>

<table>
    <tr>
        <th>Ảnh</th><th>Mã món</th><th>Tên món</th><th>Loại món</th>
        <th class="num">Đơn giá</th><th>Trạng thái</th><th class="num">Thao tác</th>
    </tr>
    <% if (listFood.length == 0) { %>
        <tr><td colspan="7" class="empty">Chưa có món ăn nào.</td></tr>
    <% } %>
    <% for (FoodItem1 f : listFood) { %>
    <tr>
        <td>
            <% if (f.getImage() != null && !f.getImage().isEmpty()) { %>
                <img class="thumb" src="images/food/<%= f.getImage() %>" alt="<%= f.getFoodName() %>">
            <% } else { %>
                <div class="thumb-none">Chưa có ảnh</div>
            <% } %>
        </td>
        <td><%= f.getFoodCode() %></td>
        <td><b><%= f.getFoodName() %></b><small><%= f.getDescription() %></small></td>
        <td><%= f.getFoodCategory() %></td>
        <td class="num"><%= String.format("%,d", f.getUnitPrice()) %> đ</td>
        <td><span class="badge <%= "Đang phục vụ".equals(f.getServingStatus()) ? "badge-on" : "badge-off" %>"><%= f.getServingStatus() %></span></td>
        <td class="num" style="white-space:nowrap">
            <button class="btn btn-outline btn-small" type="button">Sửa</button>
            <button class="btn btn-danger btn-small" type="button">Xóa</button>
        </td>
    </tr>
    <% } %>
</table>

<div class="actions">
    <a class="btn btn-outline" href="ManagerMainFrm1.jsp">Quay về</a>
</div>
<%@ include file="inc/footer.jspf" %>
