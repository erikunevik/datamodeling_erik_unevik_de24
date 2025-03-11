CREATE SCHEMA IF NOT EXISTS health;

SET search_path to health;

CREATE TABLE
    IF NOT EXISTS Hospital (
        hospital_id SERIAL PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        address VARCHAR(255)
    );




