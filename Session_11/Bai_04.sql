#1) Sử dụng lại database social_network_pro  để tiến hành thao tác
use social_network_pro;
#2) Viết procedure tên CreatePostWithValidation nhận IN p_user_id (INT), IN p_content (TEXT). Nếu độ dài content < 5 ký tự thì không thêm bài viết và SET một biến thông báo lỗi (có thể dùng OUT result_message VARCHAR(255) để trả về thông báo “Nội dung quá ngắn” hoặc “Thêm bài viết thành công”).
DELIMITER //
create procedure createpostwithvalidation (
    in  p_user_id int,
    in  p_content text,
    out result_message varchar(255)
)
begin
    if char_length(p_content) < 5 then
        set result_message = 'nội dung quá ngắn';
    else
        insert into posts(user_id, content, created_at)
        values (p_user_id, p_content, now());

        set result_message = 'thêm bài viết thành công';
    end if;
END //

#3) Gọi thủ tục và thử insert các trường hợp 
set @msg = '';
call createpostwithvalidation(1, 'hi', @msg);

#4) Kiểm tra các kết quả
select @msg as result_message;

select * from posts where user_id = 1;

#5) Xóa thủ tục vừa khởi tạo trên
drop procedure createpostwithvalidation;
-- Gợi ý: Sử dụng IF để kiểm tra CHAR_LENGTH(p_content) < 5, nếu đúng thì SET result_message và không INSERT, ngược lại INSERT bình thường.