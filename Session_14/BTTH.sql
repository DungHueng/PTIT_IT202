create database BTTH_14;
use BTTH_14;

create table Users(
	user_id int primary key auto_increment,
    username varchar(50) not null,
    total_posts int default	0
);

create table posts(
	post_id int primary key auto_increment,
    user_id int,
    content text,
    create_at datetime default current_timestamp,
    foreign key (user_id) references Users(user_id)
);

INSERT INTO users (username, total_posts) VALUES 
('nguyen_van_a', 0), 
('le_thi_b', 0);

delimiter //
delimiter //

create procedure sp_create_post(in p_user_id int, in p_content text)
begin
    if p_content is null or trim(p_content) = '' then
        signal sqlstate '45000' set message_text = 'noi dung khong duoc de trong';
    elseif not exists ( select 1 from users where user_id = p_user_id) then
        signal sqlstate '45000' set message_text = 'user khong ton tai';
    else
        start transaction;
        insert into posts(user_id, content)
        values (p_user_id, p_content);
        update users
        set total_posts = total_posts + 1
        where user_id = p_user_id;
        commit;
    end if;
end //


call sp_create_post(1,'đây là content');