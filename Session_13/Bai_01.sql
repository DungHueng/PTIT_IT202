#1)Tạo bảng users và posts . Đảm bảo posts có khóa ngoại tham chiếu users.user_id với ON DELETE CASCADE.
create database ss_13;
use ss_13;

create table users (
    user_id int primary key auto_increment,
    username varchar(50) not null unique,
    email varchar(100) not null unique,
    created_at date,
    follower_count int default 0,
    post_count int default 0
);

create table posts (
    post_id int primary key auto_increment,
    user_id int,
    content text,
    created_at datetime,
    like_count int default 0,
    constraint fk_posts_users
        foreign key (user_id) references users(user_id)
        on delete cascade
);

#2) Thêm dữ liệu mẫu dưới đây
insert into users (username, email, created_at) values
('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');
#3) Tạo 2 trigger:
-- Trigger AFTER INSERT trên posts: Khi thêm bài đăng mới, tăng post_count của người dùng tương ứng lên 1.
-- Trigger AFTER DELETE trên posts: Khi xóa bài đăng, giảm post_count của người dùng tương ứng đi 1.
DELIMITER //
create trigger trg_after_insert_post
after insert on posts
for each row
begin
    update users
    set post_count = post_count + 1
    where user_id = new.user_id;
END //
#4) Thực hiện insert các bài đăng sau và hiển thị bảng users để kiểm chứng:
insert into posts (user_id, content, created_at) values
(1, 'Hello world from Alice!', '2025-01-10 10:00:00'),
(1, 'Second post by Alice', '2025-01-10 12:00:00'),
(2, 'Bob first post', '2025-01-11 09:00:00'),
(3, 'Charlie sharing thoughts', '2025-01-12 15:00:00');

select * from users;
#5) Xóa một bài đăng bất kỳ (ví dụ post_id = 2) rồi hiển thị lại bảng users để kiểm tra.
delete from posts where post_id = 2;

select * from users;