use CSDL_social_network;

create table comments (
    comment_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
        foreign key (post_id) references posts(post_id),
        foreign key (user_id) references users(user_id)
);

DELIMITER //
create procedure sp_post_comment(
    in p_post_id int,
    in p_user_id int,
    in p_content text
)
begin
    -- bắt lỗi SQL chung
    declare exit handler for sqlexception
    begin
        rollback;
    end;

    start transaction;
    -- thêm comment
    insert into comments (post_id, user_id, content)
    values (p_post_id, p_user_id, p_content);

    -- tạo savepoint sau khi insert comment
    savepoint after_insert;

	-- Nếu có lỗi ở bước UPDATE (giả sử gây lỗi cố ý trong test), ROLLBACK TO after_insert
    if p_post_id = -1 then
        signal sqlstate '45000'
        set message_text = 'Lỗi giả lập khi update comments_count';
    end if;

    -- tăng số lượng comment của bài viết
    update posts
    set comments_count = comments_count + 1
    where post_id = p_post_id;
    commit;
end //