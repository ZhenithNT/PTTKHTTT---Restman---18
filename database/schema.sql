-- CSDL RestMan (2 module: them mon an, dat ban truc tuyen)

DROP DATABASE IF EXISTS restman;
CREATE DATABASE restman CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE restman;

-- Mon an (lop FoodItem1)
CREATE TABLE FoodItem1 (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    foodCode      VARCHAR(20)  NOT NULL UNIQUE,
    foodName      VARCHAR(255) NOT NULL,
    foodCategory  VARCHAR(255) NOT NULL,
    description   VARCHAR(255),
    image         VARCHAR(255),
    servingStatus VARCHAR(50)  NOT NULL,
    unitPrice     INT          NOT NULL
);

-- Ban an (lop DiningTable1)
CREATE TABLE DiningTable1 (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    tableCode       VARCHAR(20)  NOT NULL UNIQUE,
    tableName       VARCHAR(255) NOT NULL,
    location        VARCHAR(255) NOT NULL,
    operatingStatus VARCHAR(50)  NOT NULL,
    minCapacity     INT          NOT NULL,
    maxCapacity     INT          NOT NULL
);

-- Khach hang (lop Customer1)
CREATE TABLE Customer1 (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    fullName    VARCHAR(255) NOT NULL,
    phoneNumber VARCHAR(20)  NOT NULL UNIQUE,
    email       VARCHAR(255),
    note        VARCHAR(255)
);

-- Don dat ban (lop Reservation1)
CREATE TABLE Reservation1 (
    id                INT AUTO_INCREMENT PRIMARY KEY,
    reservationCode   VARCHAR(20)  NOT NULL,
    arrivalDate       DATE         NOT NULL,
    arrivalTime       VARCHAR(5)   NOT NULL,
    guestCount        INT          NOT NULL,
    note              VARCHAR(255),
    createdAt         DATETIME     NOT NULL,
    reservationStatus VARCHAR(50)  NOT NULL,
    tableId           INT          NOT NULL,
    customerId        INT          NOT NULL,
    FOREIGN KEY (tableId)    REFERENCES DiningTable1(id),
    FOREIGN KEY (customerId) REFERENCES Customer1(id)
);

-- du lieu mau
INSERT INTO FoodItem1 (foodCode, foodName, foodCategory, description, image, servingStatus, unitPrice) VALUES
('MA001', 'Bò Wagyu áp chảo',          'Món chính',   'Bò Wagyu A5 áp chảo, sốt rượu vang đỏ, khoai tây nghiền bơ', '', 'Đang phục vụ', 1250000),
('MA002', 'Cá tuyết sốt bơ chanh',     'Món chính',   'Cá tuyết Alaska nướng, sốt bơ chanh, măng tây',               '', 'Đang phục vụ', 690000),
('MA003', 'Sườn cừu nướng thảo mộc',   'Món chính',   'Sườn cừu New Zealand nướng thảo mộc, sốt bạc hà',             '', 'Đang phục vụ', 820000),
('MA004', 'Tôm hùm nướng phô mai',     'Món chính',   'Tôm hùm Canada nướng phô mai Parmesan',                       '', 'Đang phục vụ', 1450000),
('MA005', 'Vịt quay sốt cam',          'Món chính',   'Ức vịt áp chảo, sốt cam mật ong',                             '', 'Đang phục vụ', 560000),
('MA006', 'Risotto nấm truffle',       'Món chính',   'Cơm Ý nấu nấm truffle đen và phô mai Parmesan',               '', 'Đang phục vụ', 480000),
('MA007', 'Súp bí đỏ kem tươi',        'Món phụ',     'Súp bí đỏ mịn, kem tươi, hạt bí rang',                        '', 'Đang phục vụ', 160000),
('MA008', 'Salad cua hoàng đế',        'Món phụ',     'Thịt cua hoàng đế, bơ, rau mầm, sốt chanh dây',               '', 'Đang phục vụ', 320000),
('MA009', 'Hàu tươi Pháp',             'Món phụ',     '6 con hàu tươi, chanh và sốt mignonette',                     '', 'Đang phục vụ', 420000),
('MA010', 'Gan ngỗng áp chảo',         'Món phụ',     'Gan ngỗng áp chảo, bánh brioche, mứt vả',                     '', 'Tạm ngừng',    540000),
('MA011', 'Crème brûlée vani',         'Tráng miệng', 'Bánh kem trứng vani, lớp đường cháy giòn',                    '', 'Đang phục vụ', 150000),
('MA012', 'Fondant chocolate nóng',    'Tráng miệng', 'Bánh chocolate nóng chảy, kem vani',                          '', 'Đang phục vụ', 170000),
('MA013', 'Rượu vang đỏ Bordeaux (ly)', 'Đồ uống',   'Vang đỏ Pháp, hương trái cây đen',                            '', 'Đang phục vụ', 220000),
('MA014', 'Trà ô long hoa nhài',       'Đồ uống',     'Trà ô long ướp hoa nhài, phục vụ nguyên ấm',                  '', 'Đang phục vụ', 120000);

INSERT INTO DiningTable1 (tableCode, tableName, location, operatingStatus, minCapacity, maxCapacity) VALUES
('B01', 'Bàn 01', 'Tầng 1 - Cạnh cửa sổ',   'Hoạt động', 2, 4),
('B02', 'Bàn 02', 'Tầng 1 - Khu trung tâm', 'Hoạt động', 2, 4),
('B03', 'Bàn 03', 'Tầng 1 - Ngoài sân',     'Hoạt động', 4, 6),
('B04', 'Bàn 04', 'Tầng 2 - Ban công',      'Hoạt động', 4, 6),
('B05', 'Bàn 05', 'Tầng 2 - Khu trung tâm', 'Hoạt động', 6, 8),
('B06', 'Bàn 06', 'Tầng 2 - Cạnh cửa sổ',   'Hoạt động', 6, 8),
('B07', 'Bàn 07', 'Tầng 2 - Phòng riêng',   'Hoạt động', 8, 10);

INSERT INTO Customer1 (fullName, phoneNumber, email, note) VALUES
('Nguyễn Minh Anh', '0987654321', 'minhanh@gmail.com', '');
