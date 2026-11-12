<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.File, javax.servlet.http.Part, restman.dao.FoodItemDAO1, restman.model.FoodItem1" %>
<%
    request.setCharacterEncoding("UTF-8");

    String error = null;
    boolean success = false;

    String foodCode = "", foodName = "", foodCategory = "Món chính", description = "", unitPrice = "";
    String servingStatus = "Đang phục vụ";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        foodName = request.getParameter("txtFoodName").trim();
        foodCategory = request.getParameter("selFoodCategory");
        description = request.getParameter("txtDescription").trim();
        unitPrice = request.getParameter("txtUnitPrice").trim();
        servingStatus = request.getParameter("selServingStatus");
        Part imagePart = request.getPart("fileImage");
        boolean hasImage = imagePart != null && imagePart.getSize() > 0;

        int price = 0;
        String imageExt = "";
        if (foodName.isEmpty() || unitPrice.isEmpty()) {
            error = "Vui lòng nhập đầy đủ tên món và đơn giá.";
        } else {
            try {
                price = Integer.parseInt(unitPrice);
                if (price <= 0) {
                    error = "Đơn giá phải lớn hơn 0.";
                }
            } catch (NumberFormatException e) {
                error = "Đơn giá phải là số nguyên.";
            }
        }
        if (error == null && hasImage) {
            String fileName = imagePart.getSubmittedFileName().toLowerCase();
            imageExt = fileName.substring(fileName.lastIndexOf('.') + 1);
            if (!imageExt.matches("jpg|jpeg|png|gif|webp")) {
                error = "Hình ảnh chỉ nhận định dạng JPG, PNG, GIF hoặc WEBP.";
            } else if (imagePart.getSize() > 2 * 1024 * 1024) {
                error = "Hình ảnh không được lớn hơn 2 MB.";
            }
        }

        // mã món do hệ thống tự sinh khi lưu
        if (error == null) {
            FoodItemDAO1 dao = new FoodItemDAO1();
            String imageName = "";
            if (hasImage) {
                String dir = application.getRealPath("/images/food");
                new File(dir).mkdirs();
                imageName = "food_" + java.util.UUID.randomUUID().toString().substring(0, 8) + "." + imageExt;
                imagePart.write(new File(dir, imageName).getAbsolutePath());
            }

            FoodItem1 foodItem = new FoodItem1();
            foodItem.setFoodName(foodName);
            foodItem.setFoodCategory(foodCategory);
            foodItem.setDescription(description);
            foodItem.setUnitPrice(price);
            foodItem.setImage(imageName);
            foodItem.setServingStatus(servingStatus);
            if (dao.addFoodItem(foodItem)) {
                success = true;
                foodCode = foodItem.getFoodCode();
            } else {
                error = "Không lưu được món ăn. Vui lòng thử lại.";
            }
        }
    }

    String pageTitle = "Thêm món ăn";
    String pageSub = success ? "Món ăn đã được thêm vào thực đơn" : "Nhập thông tin món ăn mới";
    String[] categories = {"Món chính", "Món phụ", "Tráng miệng", "Đồ uống"};
%>
<%@ include file="inc/header.jspf" %>

<% if (success) { %>
    <div class="ok">Thêm món ăn thành công. Mã món: <b><%= foodCode %></b></div>
    <div class="actions end">
        <a class="btn" href="DishManagementFrm1.jsp">Tiếp</a>
    </div>
<% } else { %>
    <% if (error != null) { %><div class="error"><%= error %></div><% } %>
    <form method="post" action="AddFoodItemFrm1.jsp" enctype="multipart/form-data">
        <table class="form">
            <tr><td class="label">Tên món <span>*</span></td>
                <td><input type="text" name="txtFoodName" value="<%= foodName %>"></td></tr>
            <tr><td class="label">Loại món</td>
                <td><select name="selFoodCategory">
                    <% for (String c : categories) { %>
                        <option <%= c.equals(foodCategory) ? "selected" : "" %>><%= c %></option>
                    <% } %>
                </select></td></tr>
            <tr><td class="label">Mô tả</td>
                <td><input type="text" name="txtDescription" value="<%= description %>"></td></tr>
            <tr><td class="label">Đơn giá (VNĐ) <span>*</span></td>
                <td><input type="text" name="txtUnitPrice" value="<%= unitPrice %>" placeholder="Ví dụ: 120000"></td></tr>
            <tr><td class="label">Hình ảnh</td>
                <td><input type="file" name="fileImage" accept="image/*">
                    <div class="hint">JPG, PNG, GIF hoặc WEBP, tối đa 2 MB.</div></td></tr>
            <tr><td class="label">Trạng thái phục vụ</td>
                <td><select name="selServingStatus">
                    <option <%= "Đang phục vụ".equals(servingStatus) ? "selected" : "" %>>Đang phục vụ</option>
                    <option <%= "Tạm ngừng".equals(servingStatus) ? "selected" : "" %>>Tạm ngừng</option>
                </select></td></tr>
        </table>
        <div class="actions">
            <a class="btn btn-outline" href="DishManagementFrm1.jsp">Quay lại</a>
            <button class="btn" type="submit">Thêm</button>
        </div>
    </form>
<% } %>
<%@ include file="inc/footer.jspf" %>
