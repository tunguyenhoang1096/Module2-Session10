USE session10;
-- Ex5:
-- Tạo bảng orders
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    total_amount DECIMAL(10,2),
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50)
);
-- Tạo bảng order_log
CREATE TABLE order_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    old_status VARCHAR(50),
    new_status VARCHAR(50),
    log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);
-- Tạo trigger after_order_status_update
DELIMITER $$
    CREATE TRIGGER after_order_status_update
    AFTER UPDATE ON orders
    FOR EACH ROW
        BEGIN
            IF OLD.status <> NEW.status THEN
                INSERT INTO order_logs(order_id, old_status, new_status, log_date)
                VALUES(OLD.id,OLD.status,NEW.status,NOW());
            END IF;
        END $$
DELIMITER ;
SELECT * FROM orders;
-- Thêm một đơn hàng mới với trạng thái 'Pending'.
INSERT INTO orders(customer_name, total_amount, status)
VALUES ('Nguyễn Văn A',100000,'Pending');
-- Viết câu lệnh UPDATE đổi trạng thái đơn hàng đó sang 'Shipping'.
UPDATE orders
SET status = 'Shipping'
WHERE id = 1;
-- Viết câu lệnh UPDATE sửa tên khách hàng (nhưng giữ nguyên trạng thái 'Shipping').
UPDATE orders
SET customer_name = 'Nguyễn Văn B'
WHERE id = 1;
--
UPDATE orders
SET status = 'abc'
WHERE id = 1;
-- kiểm tra bản ghi thay đổi trong order_log
SELECT * FROM order_logs;
