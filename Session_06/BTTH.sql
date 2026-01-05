/* =========================================================
   FILE SQL: ecommerce_practice.sql
   MÔN HỌC : CƠ SỞ DỮ LIỆU / SQL
   CHỦ ĐỀ  : JOIN – AGGREGATE – GROUP BY – HAVING
   MÔ TẢ   : CSDL mẫu hệ thống thương mại điện tử (eCommerce)
   ========================================================= */


/* =========================================================
   1. TẠO CƠ SỞ DỮ LIỆU
   ========================================================= */

CREATE DATABASE ecommerce_db;
USE ecommerce_db;


/* =========================================================
   2. TẠO BẢNG KHÁCH HÀNG
   ========================================================= */

CREATE TABLE customers (
    customer_id   INT PRIMARY KEY,        -- Mã khách hàng
    customer_name VARCHAR(100),            -- Tên khách hàng
    email         VARCHAR(100),            -- Email
    city          VARCHAR(50)               -- Thành phố
);


/* =========================================================
   3. TẠO BẢNG SẢN PHẨM
   ========================================================= */

CREATE TABLE products (
    product_id   INT PRIMARY KEY,          -- Mã sản phẩm
    product_name VARCHAR(100),              -- Tên sản phẩm
    price        DECIMAL(12,2),              -- Giá bán
    category     VARCHAR(50)                -- Loại sản phẩm
);


/* =========================================================
   4. TẠO BẢNG ĐƠN HÀNG
   ========================================================= */

CREATE TABLE orders (
    order_id    INT PRIMARY KEY,            -- Mã đơn hàng
    customer_id INT,                        -- Khách hàng đặt
    order_date  DATE,                       -- Ngày đặt hàng
    status      VARCHAR(30),                -- Trạng thái đơn
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


/* =========================================================
   5. TẠO BẢNG CHI TIẾT ĐƠN HÀNG
   ========================================================= */

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,          -- Mã chi tiết đơn
    order_id      INT,                      -- Mã đơn hàng
    product_id    INT,                      -- Mã sản phẩm
    quantity      INT,                      -- Số lượng
    unit_price    DECIMAL(12,2),             -- Giá bán tại thời điểm đặt
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


/* =========================================================
   6. DỮ LIỆU MẪU - KHÁCH HÀNG
   ========================================================= */

INSERT INTO customers VALUES
(1, 'Nguyen Van An',  'an@gmail.com',   'Ha Noi'),
(2, 'Tran Thi Binh',  'binh@gmail.com', 'Da Nang'),
(3, 'Le Van Cuong',   'cuong@gmail.com','Ho Chi Minh'),
(4, 'Pham Thi Dao',   'dao@gmail.com',  'Ha Noi'),
(5, 'Hoang Van Em',   'em@gmail.com',   'Can Tho');


/* =========================================================
   7. DỮ LIỆU MẪU - SẢN PHẨM
   ========================================================= */

INSERT INTO products VALUES
(1, 'Laptop Dell',          20000000, 'Electronics'),
(2, 'iPhone 15',            25000000, 'Electronics'),
(3, 'Tai nghe Bluetooth',    1500000, 'Accessories'),
(4, 'Chuột không dây',        500000, 'Accessories'),
(5, 'Bàn phím cơ',           2000000, 'Accessories');


/* =========================================================
   8. DỮ LIỆU MẪU - ĐƠN HÀNG
   ========================================================= */

INSERT INTO orders VALUES
(101, 1, '2025-01-05', 'Completed'),
(102, 2, '2025-01-06', 'Completed'),
(103, 3, '2025-01-07', 'Completed'),
(104, 1, '2025-01-08', 'Completed'),
(105, 4, '2025-01-09', 'Completed'),
(106, 5, '2025-01-10', 'Completed'),
(107, 2, '2025-01-11', 'Completed'),
(108, 3, '2025-01-12', 'Completed');


/* =========================================================
   9. DỮ LIỆU MẪU - CHI TIẾT ĐƠN HÀNG
   ========================================================= */

INSERT INTO order_items VALUES
-- Đơn 101
(1, 101, 1, 1, 20000000),
(2, 101, 3, 2, 1500000),

-- Đơn 102
(3, 102, 2, 1, 25000000),
(4, 102, 4, 1, 500000),

-- Đơn 103
(5, 103, 5, 2, 2000000),
(6, 103, 3, 1, 1500000),

-- Đơn 104
(7, 104, 1, 1, 20000000),
(8, 104, 5, 1, 2000000),

-- Đơn 105
(9, 105, 4, 3, 500000),

-- Đơn 106
(10, 106, 3, 5, 1500000),

-- Đơn 107
(11, 107, 2, 1, 25000000),
(12, 107, 3, 2, 1500000),

-- Đơn 108
(13, 108, 1, 1, 20000000),
(14, 108, 4, 2, 500000);


/* =========================================================
   10. KIỂM TRA NHANH DỮ LIỆU (OPTIONAL)
   ========================================================= */

-- Kiểm tra số lượng bản ghi
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_products  FROM products;
SELECT COUNT(*) AS total_orders    FROM orders;
SELECT COUNT(*) AS total_items     FROM order_items;

-- Inner join
select c.*, o.status
from customers c
inner join orders o on c.customer_id = o.customer_id;

-- left join, right join
select *
from orders c
right join customers o on c.customer_id = o.customer_id;

-- full outer join
select *
from orders c
left join customers o on c.customer_id = o.customer_id
union -- phép hợp
select *
from orders c
right join customers o on c.customer_id = o.customer_id;

-- Bài tập tự luyện
# B1: Lấy tất cả thông tin gồm tên khách hàng, mã đơn hàng, tên sản phẩm, số lượng, đơn giá
select c.customer_name, o.order_id, p.product_name, oi.unit_price, oi.quantity * oi.unit_price
from customers c 
inner join orders o on c.customer_id = o.customer_id 
inner join order_items oi on o.order_id = oi.order_id 
inner join products p on oi.product_id = p.product_id;

-- Hàm tổng hợp
select count(*), max(price), min(price) from products;

-- Hàm làm việc với chuỗi
-- Hàm làm việc với thời gian
-- Hàm làm việc với số

-- Group by: gom, nhóm dữ liệu
select category, count(product_id), max(price) from products
group by category;

# Ví dụ áp dụng
# 1.1: Tính tổng tiền của mỗi đơn hàng (thông tin lấy gồm mã đơn hàng, trạng thái, tổng tiền)
select o.order_id, o.status, sum(oi.quantity*oi.unit_price)
from orders o
join order_items oi on o.order_id = oi.order_id
group by o.order_id;
-- 1.2: Tính tổng doanh thu theo từng sản phẩm: Lấy tên sản phẩm và tổng doanh thu
select p.product_name, sum(oi.quantity*oi.unit_price)
from products p
join order_items oi on p.product_id = oi.product_id
group by p.product_id
having sum(oi.quantity*oi.unit_price) > 1000000;

-- Áp dụng:
-- Lấy tất cả sản phẩm có tổng số lượng bán ra > 1000000
select p.*, sum(oi.quantity)
from products p 
join order_items oi on p.product_id = oi.product_id
group by p.product_id
having sum(oi.quantity) > 5;
-- Lấy tất cả khách hàng mua từ 2 đơn hàng trở lên
select c.*, count(o.order_id)
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id
having count(o.order_id) >= 2;
-- Lấy tất cả đơn hàng có số loại SP mua từ 2 loại SP
select o.*, count(distinct oi.product_id)
from orders o join order_items oi on o.order_id = oi.order_id
group by o.order_id
having count(distinct oi.product_id) >= 2;


-- 1.3: Tính tổng số tiền đã chi của từng khách hàng, sắp xếp theo tổng tiền giảm dần
select c.customer_id, c.customer_name,sum(oi.quantity * oi.unit_price) `total_amount`
from customers c
join orders o on o.customer_id = c.customer_id
join order_items oi on oi.order_id = o.order_id

group by c.customer_id
order by `total_amount` desc;
/* =========================================================
   KẾT THÚC FILE SQL
   ========================================================= */