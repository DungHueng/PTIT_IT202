#1. Sử dụng lại database social_network_pro để thực hành
CREATE DATABASE IF NOT EXISTS social_network_pro
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE social_network_pro;

SET FOREIGN_KEY_CHECKS = 0;

#2. Tạo chỉ mục phức hợp (Composite Index)
-- Tạo một truy vấn để tìm tất cả các bài viết (posts) trong năm 2026 của người dùng có user_id là 1. Trả về các cột post_id, content, và created_at.
explain analyze 
select post_id, content, created_at
from posts 
where user_id = 1 and year(created_at) = 2026;

-- Tạo chỉ mục phức hợp với tên idx_created_at_user_id trên bảng posts sử dụng các cột created_at và user_id.
create index idx_created_at_user_id on posts(created_at, user_id);

-- Sử dụng EXPLAIN ANALYZE để kiểm tra kế hoạch thực thi của truy vấn trên trước và sau khi tạo chỉ mục idx_created_at_user_id. So sánh kết quả thực thi giữa hai lần này.
 explain analyze 
select post_id, content,  created_at        
from posts 
where user_id = 1 and year(created_at) = 2026;

#3. Tạo chỉ mục duy nhất (Unique Index)
-- Tạo một truy vấn để tìm tất cả các người dùng (users) có email là 'an@gmail.com'. Trả về các cột user_id, username, và email.
explain analyze 
select user_id, username, email
from users
where email = 'an@gmail.com';

-- Tạo chỉ mục duy nhất với tên idx_email trên cột email trong bảng users.
  create unique index idx_email on users(email);
  
-- Sử dụng EXPLAIN ANALYZE để kiểm tra kế hoạch thực thi của truy vấn trên trước và sau khi tạo chỉ mục idx_email. So sánh kết quả thực thi giữa hai lần này.
explain analyze 
select user_id, username, email
from users
where email = 'an@gmail.com';

#4. Xóa chỉ mục
-- Xóa chỉ mục idx_created_at_user_id khỏi bảng posts.
  drop index idx_created_at_user_id on posts;
  
-- Xóa chỉ mục idx_email khỏi bảng users.
drop index idx_email on users;