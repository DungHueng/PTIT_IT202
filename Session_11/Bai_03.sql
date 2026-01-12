#1) Sử dụng lại database social_network_pro  để tiến hành thao tác
use social_network_pro;
#2) Viết stored procedure tên CalculateBonusPoints nhận hai tham số:
-- p_user_id (INT, IN) – ID của user
-- p_bonus_points (INT, INOUT) – Điểm thưởng ban đầu (khi gọi procedure, bạn truyền vào một giá trị điểm khởi đầu, ví dụ 100).
-- Trong procedure:

-- Nếu số bài viết ≥ 10, cộng thêm 50 điểm vào p_bonus_points.
-- Nếu số bài viết ≥ 20, cộng thêm tổng cộng 100 điểm (thay vì chỉ 50).
-- Cuối cùng, tham số p_bonus_points sẽ được sửa đổi và trả ra giá trị mới.
#Gợi ý:
-- Sử dụng SELECT để lấy số bài viết, lưu vào biến tạm.
-- Dùng IF-ELSEIF-ELSE để kiểm tra điều kiện và cộng điểm trực tiếp vào tham số INOUT
DELIMITER //
create procedure CalculateBonusPoints (
in p_user_id int,
inout p_bonus_points int
)
begin
declare post_count int default 0;
-- Đếm số lượng bài viết (posts) của user đó.
select COUNT(*) 
into post_count
from posts
where user_id = p_user_id;

if post_count >= 20 THEN
set p_bonus_points = p_bonus_points + 100;
elseif post_count >= 10 THEN
set p_bonus_points = p_bonus_points + 50;
end if;
END //
#3) Gọi thủ tục trên với giá trị id user và p_bonus_points bất kì mà bạn muốn cập nhật
set @bonus = 100;
call CalculateBonusPoints(5, @bonus);

#4) Select ra p_bonus_points
select @bonus as bonus_points_after_calculate;

#5) Xóa thủ tục mới khởi tạo trên
drop procedure CalculateBonusPoints;