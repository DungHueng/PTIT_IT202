create database ss_14;
use ss_14;

create table accounts(
account_id int primary key auto_increment,
account_name varchar(50),
balance decimal(10, 2)
);

INSERT INTO accounts (account_name, balance) VALUES 
('Nguyễn Văn An', 1000.00),
('Trần Thị Bảy', 500.00);

#3) Viết một Stored Procedure trong MySQL để thực hiện transaction nhằm chuyển tiền từ tài khoản này sang tài khoản khác
DELIMITER //
create procedure transfer_money(
    in from_account int,
    in to_account int,
    in amount decimal(10,2)
)
begin
    declare from_balance decimal(10,2);
    
    -- xử lý lỗi chung → rollback
    declare exit handler for sqlexception
    begin
        rollback;
    end;

    start transaction;
    -- lấy số dư tài khoản gửi
    select balance into from_balance
    from accounts
    where account_id = from_account
    for update;

    -- kiểm tra đủ tiền
    if from_balance >= amount then
        -- trừ tiền tài khoản gửi
        update accounts
        set balance = balance - amount
        where account_id = from_account;

        -- cộng tiền tài khoản nhận
        update accounts
        set balance = balance + amount
        where account_id = to_account;
        commit;
    else
        rollback;
    end if;
end //