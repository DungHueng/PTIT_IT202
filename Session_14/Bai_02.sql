use CSDL_social_network;

create table likes (
    like_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    
        foreign key (post_id) references posts(post_id),
        foreign key (user_id) references users(user_id)
);
alter table posts
add column likes_count int default 0;

#3) Yêu cầu
#4) Viết script SQL sử dụng TRANSACTION để:
-- INSERT vào bảng likes (post_id và user_id do bạn chọn).
start transaction;
insert into likes (post_id, user_id)
values (1, 2);

-- UPDATE tăng likes_count +1 cho bài viết tương ứng.
update posts
set likes_count = likes_count + 1
where post_id = 1;
commit;
-- Nếu vi phạm UNIQUE constraint (đã like trước đó) hoặc lỗi khác, ROLLBACK.
start transaction;
insert into likes (post_id, user_id)
values (1, 2);

update posts
set likes_count = likes_count + 1
where post_id = 1;
rollback;
-- Nếu thành công, COMMIT.
select * from likes;
select post_id, likes_count from posts;