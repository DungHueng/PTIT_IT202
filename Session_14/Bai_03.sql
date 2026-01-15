use CSDL_social_network;

create table followers (
    follower_id int not null,
    followed_id int not null,
    primary key (follower_id, followed_id),
        foreign key (follower_id) references users(user_id),
        foreign key (followed_id) references users(user_id)
);
alter table users
add column following_count int default 0,
add column followers_count int default 0;

#Yêu cầu
#4) Tạo bảng followers và các cột count nếu chưa có.
#5) Viết Stored Procedure sp_follow_user với tham số:
-- p_follower_id INT
-- p_followed_id INT

DELIMITER //
create procedure sp_follow_user(
    in p_follower_id int,
    in p_followed_id int
)
begin
    declare v_count int;
    begin
        rollback;
    end;
    start transaction;
    -- kiểm tra user tồn tại
    select count(*) into v_count
    from users
    where user_id in (p_follower_id, p_followed_id);

    if v_count < 2 then
        insert into follow_log (follower_id, followed_id, error_message)
        values (p_follower_id, p_followed_id, 'User không tồn tại');
        rollback;

    -- không được tự follow chính mình
    elseif p_follower_id = p_followed_id then
        insert into follow_log (follower_id, followed_id, error_message)
        values (p_follower_id, p_followed_id, 'Không thể tự follow chính mình');
        rollback;

    -- kiểm tra đã follow trước đó chưa
    elseif exists (
        select 1 from followers
        where follower_id = p_follower_id
          and followed_id = p_followed_id
    ) then
        insert into follow_log (follower_id, followed_id, error_message)
        values (p_follower_id, p_followed_id, 'Đã follow trước đó');
        rollback;

    else
        -- thêm follow
        insert into followers (follower_id, followed_id)
        values (p_follower_id, p_followed_id);

        -- tăng following_count
        update users
        set following_count = following_count + 1
        where user_id = p_follower_id;

        -- tăng followers_count
        update users
        set followers_count = followers_count + 1
        where user_id = p_followed_id;

        commit;
    end if;
end //