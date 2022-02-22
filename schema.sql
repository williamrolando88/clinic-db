/* Database schema to keep the structure of entire database. */


CREATE TABLE patients (
  id SERIAL NOT NULL PRIMARY KEY,
  name VARCHAR(128) NOT NULL,
  date_of_birth DATE NOT NULL
);

CREATE TABLE medical_histories (
  id SERIAL NOT NULL PRIMARY KEY,
  admitted_at TIMESTAMP NOT NULL,
  patient_id INT NOT NULL,
  status VARCHAR(50) NOT NULL
);

CREATE TABLE invoices (
  id SERIAL NOT NULL PRIMARY KEY,
  total_amount DECIMAL NOT NULL,
  generated_at TIMESTAMP NOT NULL,
  payed_at TIMESTAMP NOT NULL,
  medical_history_id INT NOT NULL
);

CREATE TABLE invoice_items (
  id SERIAL NOT NULL PRIMARY KEY,
  unit_price DECIMAL NOT NULL,
  quantity INT NOT NULL,
  total_price DECIMAL NOT NULL,
  invoice_id INT NOT NULL,
  treatment_id INT NOT NULL
);

CREATE TABLE treatments (
  id SERIAL NOT NULL PRIMARY KEY,
  type VARCHAR(50) NOT NULL,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE medical_treatment (
  medical_history_id INT NOT NULL,
  treatment_id INT NOT NULL,
  PRIMARY KEY (medical_history_id, treatment_id),
  CONSTRAINT medical_history_fk
    FOREIGN KEY (medical_history_id)
    REFERENCES medical_histories(id),
  CONSTRAINT treatment_fk
    FOREIGN KEY(treatment_id)
    REFERENCES treatments(id)
);

ALTER TABLE medical_histories
  ADD CONSTRAINT patient_id_fk
  FOREIGN KEY (patient_id)
  REFERENCES patients(id);

ALTER TABLE invoices
  ADD CONSTRAINT invoices_medical_history_id_fk
  FOREIGN KEY (medical_history_id)
  REFERENCES medical_histories(id);

ALTER TABLE invoice_items
  ADD CONSTRAINT invoices_fk
  FOREIGN KEY (invoice_id)
  REFERENCES invoices(id);

ALTER TABLE
clinic_db=# ALTER TABLE invoice_items
  ADD CONSTRAINT treatments_fk
  FOREIGN KEY (treatment_id)
  REFERENCES treatments(id);