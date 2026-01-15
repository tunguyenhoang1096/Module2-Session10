USE session10;
-- EX6:
-- Tạo bảng cart_items
CREATE TABLE cart_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
-- Tạo trigger trước khi thêm vào giỏ hàng kiểm tra số lượng mua với tồn kho
DELIMITER $$
    CREATE TRIGGER before_cart_add
    BEFORE INSERT ON cart_items
    FOR EACH ROW
        BEGIN
            DECLARE stock INT;
            SELECT quantity INTO stock
            FROM products
            WHERE product_id = NEW.product_id;
            IF NEW.quantity > stock THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Số lượng trong kho không đủ';
            END IF;
        END $$
DELIMITER ;
# DROP TRIGGER before_cart_add;
SELECT * FROM products;
-- Tạo một sản phẩm mẫu, ví dụ: "iPhone 15" với tồn kho là 5 cái.
INSERT INTO products (product_name, quantity)
VALUES ('iPhone 15', 5);
-- Trường hợp 1: Thử thêm vào giỏ hàng số lượng 2 (Hợp lệ).
INSERT INTO cart_items (product_id, quantity)
VALUES (7, 2);
-- Trường hợp 2: Thử thêm vào giỏ hàng số lượng 10 (Không hợp lệ -> Phải báo lỗi).
INSERT INTO cart_items (product_id, quantity)
VALUES (7, 10);
SELECT * FROM cart_items;