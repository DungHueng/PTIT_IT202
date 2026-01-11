CREATE DATABASE IF NOT EXISTS social_network_pro
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE social_network_pro;

SET FOREIGN_KEY_CHECKS = 0;

#1. Tạo chỉ mục có tên idx_hometown trên cột hometown của bảng users
create index idx_hometown on users(hometown);

#2. Thực hiện truy vấn với các yêu cầu sau:
-- Viết một câu truy vấn để tìm tất cả các người dùng (users) có hometown là "Hà Nội"
select *
from users 
where hometown = 'Hà Nội';

-- Kết hợp với bảng posts để hiển thị thêm post_id và content về các lần đăng bài. 
select u.username, p.post_id, p.content
from users u
join posts p on u.user_id = p.user_id
where u.hometown = 'Hà Nội';

-- Sắp xếp danh sách theo username giảm dần và giới hạn kết quả chỉ hiển thị 10 bài đăng đầu tiên.
select u.username, p.post_id, p.content
from users u
join posts p on u.user_id = p.user_id
where u.hometown = 'Hà Nội'
order by u.username desc
limit 10;

#3. Sử dụng EXPLAIN ANALYZE để kiểm tra lại kế hoạch thực thi trước và sau khi có chỉ mục.
explain analyze
select u.username, p.post_id, p.content
from users u
join posts p on u.user_id = p.user_id
where u.hometown = 'Hà Nội'
order by u.username desc
limit 10;