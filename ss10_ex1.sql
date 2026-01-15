CREATE DATABASE session10;
USE session10;
-- Ex1:
-- Tạo bảng products và thêm dữ liệu
CREATE TABLE products(
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL ,
    quantity INT NOT NULL
);
INSERT INTO products(product_name, quantity)
VALUES ('Laptop Dell', 10),
       ('Chuột không dây', 50),
       ('Bàn phím cơ', 30),
       ('Màn hình 24 inch', 15),
       ('Tai nghe Bluetooth', 40);
-- Tạo bảng inventorychanges
CREATE TABLE inventory_changes(
    change_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    old_quantity INT NOT NULL ,
    new_quantity INT NOT NULL ,
    change_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- Tạo Trigger để ghi lại thông tin thay đổi số lượng sản phẩm vào bảng InventoryChanges mỗi khi có cập nhật số lượng trong bảng Products
DELIMITER $$
    CREATE TRIGGER after_update_product
    AFTER UPDATE ON products
    FOR EACH ROW
        BEGIN
            -- Ghi lại thông tin thay đổi vào bảng InventoryChanges
            INSERT INTO inventory_changes(product_id, old_quantity, new_quantity)
            VALUES (NEW.product_id,OLD.quantity,NEW.quantity);
        END $$
DELIMITER ;
-- Cập nhật số lượng sản phẩm và kiểm tra thông tin thay đổi lưu trong bảng InventoryChanges
UPDATE products SET quantity = 20 WHERE product_id = '1';
UPDATE products SET quantity = 200 WHERE product_id = '2';
SELECT * FROM inventory_changes;