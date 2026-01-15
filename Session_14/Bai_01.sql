create database CSDL_social_network;
use CSDL_social_network;

create table users(
user_id INT PRIMARY KEY AUTO_INCREMENT,
username VARCHAR(50) NOT NULL,
posts_count INT DEFAULT 0
);

create table posts(
post_id INT PRIMARY KEY AUTO_INCREMENT,
user_id INT NOT NULL,

FOREIGN KEY (user_id) references users(user_id),
content TEXT NOT NULL,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

insert into users (username) values
('Chien'),
('Huy');

#3) Yêu cầu
#4) Viết script SQL sử dụng TRANSACTION để thực hiện:
-- INSERT một bản ghi mới vào bảng posts (với user_id và content do bạn chọn).
start transaction;
insert into posts (user_id, content)
values (1, 'Hôm nay trời đẹp quá');

-- UPDATE tăng posts_count +1 cho user tương ứng.
update users
set posts_count = posts_count + 1
where user_id = 1;

commit;
-- Nếu bất kỳ thao tác nào thất bại, thực hiện ROLLBACK.
start transaction;
insert into posts (user_id, content)
values (999, 'Bài viết lỗi');

update users
set posts_count = posts_count + 1
where user_id = 999;
rollback;
-- Nếu thành công, thực hiện COMMIT.
select * from users;
select * from posts;