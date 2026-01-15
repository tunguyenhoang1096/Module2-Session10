USE session10;
-- Ex4:
-- Tạo bảng employees và thêm dữ liệu
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10,2),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15)
);
INSERT INTO employees(first_name, last_name, salary, email, phone_number)
VALUES ('An', 'Nguyen', 800.00, 'an.nguyen@gmail.com', '0900000001'),
       ('Binh', 'Tran', 900.00, 'binh.tran@gmail.com', '0900000002'),
       ('Cuong', 'Le', 1000.00, 'cuong.le@gmail.com', '0900000003'),
       ('Dung', 'Pham', 1100.00, 'dung.pham@gmail.com', '0900000004'),
       ('Hoa', 'Vo', 1200.00, 'hoa.vo@gmail.com', '0900000005'),
       ('Hung', 'Do', 1300.00, 'hung.do@gmail.com', '0900000006'),
       ('Khanh', 'Bui', 1400.00, 'khanh.bui@gmail.com', '0900000007'),
       ('Lan', 'Hoang', 1500.00, 'lan.hoang@gmail.com', '0900000008'),
       ('Minh', 'Dang', 1600.00, 'minh.dang@gmail.com', '0900000009'),
       ('Nam', 'Ly', 1700.00, 'nam.ly@gmail.com', '0900000010');
-- Tạo bảng salary_log để lưu thay đổi lương
CREATE TABLE salary_log(
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    change_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);
-- Tạo trigger tự động cập nhật lương sau khi update bảng employees
DELIMITER $$
    CREATE TRIGGER trg_after_update_salary
        AFTER UPDATE ON employees
        FOR EACH ROW
        BEGIN
            IF OLD.salary <> NEW.salary THEN
              INSERT INTO salary_log(employee_id, old_salary, new_salary,change_date)
                VALUES (OLD.id,OLD.salary,NEW.salary,NOW());
            END IF;
        END $$
DELIMITER ;
SELECT * FROM employees;
-- update lương và kiểm tra thay đổi
UPDATE employees
SET salary = 100000
WHERE id = 1;
SELECT * FROM salary_log;