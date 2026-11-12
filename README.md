# RestMan - Đề 18
Hệ thống quản lý nhà hàng, làm hai module:

- **Thêm thông tin món ăn** (nhân viên quản lý): ứng dụng `restman-quanly`
- **Đặt bàn trực tuyến** (khách hàng): ứng dụng `restman-khach`

Công nghệ: Java 17, JSP, JDBC, MySQL (XAMPP), Tomcat 8.5. Các trang JSP gọi trực tiếp lớp DAO, mọi DAO kế thừa `DAO1` (giữ kết nối CSDL dùng chung).

## Cách chạy
1. Bật MySQL trong XAMPP Control Panel.
2. Tạo CSDL và dữ liệu mẫu (chạy trong thư mục `RestMan`, file này xóa CSDL `restman` cũ nếu có):
   ```
   C:\xampp\mysql\bin\mysql.exe -uroot --default-character-set=utf8mb4 -e "source database/schema.sql"
   ```
3. Chạy `build_and_deploy.bat` để biên dịch và copy 2 ứng dụng vào Tomcat của XAMPP. Sau mỗi lần sửa code chạy lại và đợi khoảng 15 giây.
4. Chạy `start_tomcat.bat` và giữ cửa sổ mở.
5. Mở:
   - Quản lý: http://localhost:8080/restman-quanly/
   - Khách hàng: http://localhost:8080/restman-khach/

Nếu MySQL không dùng tài khoản `root` không mật khẩu thì sửa trong `src/restman/dao/DAO1.java`.

## Cấu trúc
```
database/schema.sql      CSDL và dữ liệu mẫu
src/restman/model/       các lớp thực thể
src/restman/dao/         DAO1, FoodItemDAO1, DiningTableDAO1, CustomerDAO1, ReservationDAO1
manager/webapp/          các trang của nhân viên quản lý
customer/webapp/         các trang của khách hàng
common/css/style.css     giao diện dùng chung
lib/                     mysql-connector-j
```

## Các trang
**Quản lý**
- `ManagerMainFrm1`: giao diện chính
- `DishManagementFrm1`: danh sách món ăn (ô tìm kiếm, nút Sửa, nút Xóa chỉ hiển thị)
- `AddFoodItemFrm1`: thêm món ăn, mã món tự sinh (MA001, MA002...)

**Khách hàng**
- `CustomerMainFrm1`: giao diện chính
- `SearchAvailableTableFrm1`: nhập ngày đến, giờ đến, số khách
- `AvailableTableListFrm1`: danh sách bàn trống, chọn bàn
- `ConfirmReservationFrm1`: nhập thông tin khách và đặt bàn
- `ReservationResultFrm1`: phiếu đặt bàn vừa đặt

## Quy tắc đặt bàn
- Giờ đến từ 11:00 đến 22:00, theo mốc 00, 15, 30, 45 phút. Số khách từ 2 đến 10.
- Mỗi bàn nhận khách theo một khoảng (2-4, 4-6, 6-8, 8-10 người).
- Bàn trống trong một ngày là bàn đang hoạt động, vừa số khách và chưa có phiếu "Đã đặt" của ngày đó.
- Đặt bàn thành công ngay, phiếu có trạng thái "Đã đặt".
- Ảnh món ăn lưu trong `images/food` của ứng dụng Quản lý, CSDL chỉ lưu tên file.
