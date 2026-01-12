#1) Sử dụng lại database social_network_pro  để tiến hành thao tác
use social_network_pro;
#2) Tính tổng like của bài viết
-- Viết stored procedure CalculatePostLikes nhận vào:
-- IN p_post_id: mã bài viết
-- OUT total_likes: tổng số lượt like nhận được trên tất cả bài viết của người dùng đó
#Gợi ý:
-- IN: p_post_id 
-- OUT: total_likes
-- Logic: truyền vào post_id để đếm số likes post đó
DELIMITER //
create procedure CalculatePostLikes (
in p_post_id int,
out total_likes int
)
begin 
select count(*)
into tota_likes
from likes
where post_id = p_post_id;
END //
#3) Thực hiện gọi stored procedure CalculatePostLikes với một post cụ thể và truy vấn giá trị của tham số OUT total_likes sau khi thủ tục thực thi.
-- Khai báo biến nhận OUT
set @total_likes = 0;
-- Gọi thủ tục
call CalculatePostLikes(101, @total_likes);
-- Truy vấn kết quả
select @total_likes as total_likes;

#4) Xóa thủ tục vừa mới tạo trên
drop procedure CalculatePostLikes;