-- create database named clinic.
CREATE DATABASE clinic;

-- create a table named patients.
CREATE TABLE patients (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(70),
  date_of_birth DATE
);

-- create a table named medical_histories.
CREATE TABLE medical_histories(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    admitted_at timestamp,
    patient_id INT,
    status VARCHAR(100),
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON UPDATE CASCADE
);
--add foreign key to the medical histories's table.
ALTER TABLE medical_histories
ADD FOREIGN KEY (patient_id) REFERENCES patients(name);

-- create a table named treatments.
CREATE TABLE treatments(
    id INT PRIMARY KEY,
    type VARCHAR(50),
    name VARCHAR(100),
    FOREIGN KEY (id) REFERENCES medical_histories(id) ON UPDATE CASCADE
);

-- create a table named invoices.
CREATE TABLE invoices(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    total_amount decimal,
    generated_at timestamp,
    payed_at timestamp,
    medical_history_id INT,
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id) ON UPDATE CASCADE
);

-- create a table named invoice_items.
CREATE TABLE invoice_items(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    unit_price decimal,
    quantity INT,
    total_price decimal,
    invoice_id INT,
    treatment_id INT,
    FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON UPDATE CASCADE,
    FOREIGN KEY (treatment_id) REFERENCES treatments(id) ON UPDATE CASCADE
);

-- add index to the patients table
CREATE INDEX patient_name_asc ON patients(name ASC);