-- Create the employee table
CREATE TABLE employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

-- Insert sample data into the employee table
INSERT INTO employee (id, name, age, department, salary) VALUES
(1, 'John Doe', 30, 'IT', 5000.00),
(2, 'Jane Smith', 35, 'HR', 6000.00),
(3, 'Michael Johnson', 28, 'Finance', 5500.00),
(4, 'Emily Davis', 32, 'Marketing', 5200.00),
(5, 'David Wilson', 40, 'Operations', 7000.00),
(6, 'Sarah Brown', 27, 'IT', 4800.00),
(7, 'Robert Taylor', 33, 'HR', 5800.00),
(8, 'Jennifer Anderson', 29, 'Finance', 5300.00),
(9, 'Christopher Martinez', 31, 'Marketing', 5100.00),
(10, 'Jessica Thompson', 36, 'Operations', 6500.00);
