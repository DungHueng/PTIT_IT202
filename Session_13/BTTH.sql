create database BTTH;
use BTTH;

create table users (
    user_id int primary key auto_increment,
    username varchar(50) not null unique,
    total_posts int default 0
);

create table posts (
    post_id int primary key auto_increment,
    user_id int,
    content text,
    created_at datetime,
    foreign key (user_id) references users(user_id) 
);

create table post_audits (
    audit_id int primary key auto_increment,
    post_id int,
    old_content text,
    new_content text,
    changed_at datetime,
    foreign key (post_id) references posts(post_id)
);

DELIMITER //
create trigger tg_checkpostcontent
before insert on posts
for each row
begin
    if trim(new.content) = '' then
        signal sqlstate '45000' set message_text = 'nội dung bài viết không được để trống!';
    end if;
end //

DELIMITER //
create trigger tg_updatepostcountafterinsert
after insert on posts
for each row
begin
    update users
    set total_posts = total_posts + 1
    where user_id = new.user_id;
end //

DELIMITER //
create trigger tg_logpostchanges
after update on posts
for each row
begin
    if old.content <> new.content then
        insert into post_audits (post_id, old_content, new_content, changed_at)
        values (old.post_id, old.content, new.content, now());
    end if;
end //

DELIMITER //
create trigger tg_updatepostcountafterdelete
after delete on posts
for each row
begin
    update users
    set total_posts = total_posts - 1
    where user_id = old.user_id;
end //

insert into users (username) values ('alice');

insert into posts (user_id, content, created_at) values (1, 'hello world', now());

select * from users;

insert into posts (user_id, content, created_at) values (1, '   ', now());

update posts set content = 'hello world updated' where post_id = 1;

select * from post_audits; 

delete from posts where post_id = 1;

select * from users; 

-- dọn dẹp: drop trigger
drop trigger if exists tg_checkpostcontent;
drop trigger if exists tg_updatepostcountafterinsert;
drop trigger if exists tg_logpostchanges;
drop trigger if exists tg_updatepostcountafterdelete;