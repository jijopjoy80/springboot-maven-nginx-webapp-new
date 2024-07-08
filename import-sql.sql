-- Create a database
CREATE DATABASE mydatabase;

-- Connect to the newly created database
\c mydatabase;

-- Create a table named 'users'
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

-- Insert two rows into the 'users' table
INSERT INTO users (name, email) VALUES
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com');
