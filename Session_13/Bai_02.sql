use ss_13;
#1) Tạo bảng likes
create table likes (
    like_id int primary key auto_increment,
    user_id int,
    post_id int,
    liked_at datetime default current_timestamp,
    constraint fk_likes_users
        foreign key (user_id)
        references users(user_id)
        on delete cascade,
    constraint fk_likes_posts
        foreign key (post_id)
        references posts(post_id)
        on delete cascade
);
#2) Thêm dữ liệu mẫu vào likes (sử dụng các post_id hiện có)
insert into likes (user_id, post_id, liked_at) values
(2, 1, '2025-01-10 11:00:00'),
(3, 1, '2025-01-10 13:00:00'),
(1, 3, '2025-01-11 10:00:00'),
(3, 4, '2025-01-12 16:00:00');

#3) Tạo trigger AFTER INSERT và AFTER DELETE trên likes để tự động cập nhật like_count trong bảng posts.
DELIMITER //
create trigger trg_after_insert_like
after insert on likes
for each row
begin
    update posts
    set like_count = like_count + 1
    where post_id = new.post_id;
end //

#4) Tạo một View tên user_statistics hiển thị: user_id, username, post_count, total_likes (tổng like_count của tất cả bài đăng của người dùng đó).
DELIMITER //
create trigger trg_after_delete_like
after delete on likes
for each row
begin
    update posts
    set like_count = like_count - 1
    where post_id = old.post_id;
end //

#5)Thực hiện thêm/xóa một lượt thích và kiểm chứng:
create view user_statistics as
select 
    u.user_id,
    u.username,
    u.post_count,
    coalesce(sum(p.like_count), 0) as total_likes
from users u
left join posts p on u.user_id = p.user_id
group by u.user_id, u.username, u.post_count;

insert into likes (user_id, post_id, liked_at)
values (2, 4, now());

select * from posts where post_id = 4;
select * from user_statistics;

#6) Xóa một lượt thích và kiểm chứng lại View.
delete from likes
where user_id = 2 and post_id = 4
limit 1;

select * from posts where post_id = 4;
select * from user_statistics;
