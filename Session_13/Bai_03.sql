#1)Đảm bảo các bảng users, posts, likes đã tồn tại từ các bài trước.
use ss_13;
#3) Tạo/cập nhật trigger trên likes:
-- BEFORE INSERT: Kiểm tra không cho phép user like bài đăng của chính mình (nếu user_id = user_id của post thì RAISE ERROR).
DELIMITER //
create trigger trg_before_insert_like
before insert on likes
for each row
begin
    declare post_owner_id int;

    select user_id
    into post_owner_id
    from posts
    where post_id = new.post_id;

    if new.user_id = post_owner_id then
        signal sqlstate '45000' set message_text = 'khong the like bai dang cua chinh minh';
    end if;
end //
-- AFTER INSERT/DELETE/UPDATE: Cập nhật like_count trong posts tương ứng (tăng/giảm khi thêm/xóa, điều chỉnh khi UPDATE post_id).
#before insert
DELIMITER //
create trigger before_like_insert
before insert on likes
for each row
begin
    if new.user_id = (select user_id from posts where post_id = new.post_id) then
        signal sqlstate '45000' set message_text = 'không thể tự like bài đăng của chính mình';
    end if;
end //

#after insert
DELIMITER //
create trigger trg_after_insert_like
after insert on likes
for each row
begin
    update posts
    set like_count = like_count + 1
    where post_id = new.post_id;
end //

#after delete
DELIMITER //
create trigger trg_after_delete_like
after delete on likes
for each row
begin
    update posts
    set like_count = like_count - 1
    where post_id = old.post_id;
end //

#after update
DELIMITER //
create trigger after_like_update
after update on likes
for each row
begin
    if old.post_id <> new.post_id then
        update posts
        set like_count = like_count - 1
        where post_id = old.post_id;
        update posts
        set like_count = like_count + 1
        where post_id = new.post_id;
    end if;
end //
#4) Thực hiện các thao tác kiểm thử:
-- Thử like bài của chính mình (phải báo lỗi).
insert into likes (user_id, post_id)
values (1, 1);

-- Thêm like hợp lệ, kiểm tra like_count.
insert into likes (user_id, post_id)
values (2, 1);
select post_id, like_count
from posts
where post_id = 1;

-- UPDATE một like sang post khác, kiểm tra like_count của cả hai post.
update likes
set post_id = 4
where user_id = 2 and post_id = 1
limit 1;
select post_id, like_count
from posts
where post_id in (1, 4);

-- Xóa like và kiểm tra.
delete from likes
where user_id = 2 and post_id = 4
limit 1;
select post_id, like_count
from posts
where post_id = 4;

#5) Truy vấn SELECT từ posts và user_statistics (từ bài 2) để kiểm chứng.
select * from posts;

select * from user_statistics;