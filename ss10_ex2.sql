USE session10;
-- Ex2:
-- Tạo Trigger BeforeProductDelete để kiểm tra số lượng sản phẩm trước khi xóa
-- Tạo Trigger để ngăn không cho xóa sản phẩm nếu số lượng của sản phẩm đó lớn hơn 10.
DELIMITER $$
    CREATE TRIGGER BeforeProductDelete
        BEFORE DELETE ON products
        FOR EACH ROW
        BEGIN
            IF OLD.quantity > 10 THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Không thể xóa sản phẩm có số lượng lớn hơn 10';
            END IF;
        END $$
DELIMITER ;
SELECT * FROM products;
DELETE  FROM products WHERE product_id = 1;
DELETE  FROM products WHERE product_id = 2;