-- Create database
CREATE DATABASE mydb;

-- Use the database
USE mydb;
-- Create table
CREATE TABLE employee (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50),
  age INT,
  salary DECIMAL(10,2)
);
-- Insert sample data
INSERT INTO employee (name, age, salary) VALUES
  ('John Doe', 30, 5000),
  ('Jane Smith', 25, 4000),
  ('Mike Johnson', 35, 6000);

--select all
select * from employee;

