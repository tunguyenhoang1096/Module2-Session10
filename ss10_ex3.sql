USE session10;
-- Ex3:
-- Tạo Trigger BeforeInsertProduct để kiểm tra xem số lượng sản phẩm thêm mới vào có < 0 hay không . Nếu quantity < 0 thì tạo ra một lỗi và ngăn cản việc chèn sản phẩm
DELIMITER $$
    CREATE TRIGGER BeforeInsertProduct
    BEFORE INSERT ON products
    FOR EACH ROW
        BEGIN
            IF NEW.quantity < 0 THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Số lượng sản phẩm không hợp lệ';
            end if;
        end $$
DELIMITER ;
INSERT INTO products(product_name, quantity)
VALUES ('Phone',-2);
INSERT INTO products(product_name, quantity)
VALUES ('Phone',20);
SELECT * FROM products;