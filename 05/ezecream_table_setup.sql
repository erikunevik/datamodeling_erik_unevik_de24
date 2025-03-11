CREATE SCHEMA IF NOT EXISTS ezecream_05;

SET search_path to ezecream_05; -- Sätter schema

CREATE TABLE
    IF NOT EXISTS Customer (
        customer_id SERIAL PRIMARY KEY, -- Serial skapar en sequnce som auto incrementerar
        first_name VARCHAR(50) NOT NULL,
        last_name VARCHAR(50) NOT NULL,
        personal_number CHAR(12),
        email VARCHAR(255) NOT NULL,
        address VARCHAR(100) NOT NULL
    );

        CREATE TABLE
    IF NOT EXISTS Orders (
        order_id SERIAL PRIMARY KEY, 
        customer_id INTEGER NOT NULL,
        FOREIGN KEY (customer_id) REFERENCES Customer (customer_id),
        order_date DATE DEFAULT CURRENT_DATE
        

    );

        CREATE TABLE
    IF NOT EXISTS Product (
        product_id SERIAL PRIMARY KEY, 
        name VARCHAR(50) NOT NULL,
        price INTEGER NOT NULL
       );



CREATE TABLE 
    IF NOT EXISTS Orderline (
        orderline_id SERIAL PRIMARY KEY,
        order_id INTEGER NOT NULL,
        product_id INTEGER NOT NULL,
        quantity INTEGER NOT NULL,
        FOREIGN KEY (order_id) REFERENCES Orders (order_id),
        FOREIGN KEY (product_id) REFERENCES Product (product_id)
    );






