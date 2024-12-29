-- Query using the view to display employee responsible for the store
SELECT 
    v.rental_id,
    v.customer_surname,
    v.employee_surname,
    v.store_name,
    CONCAT('Manager: ', m.last_name) AS store_manager
FROM
    v_rental_details v
        JOIN
    staff m ON v.store_id = m.store_id
ORDER BY v.employee_surname;

-- Generate ALTER TABLE statement for rental table
ALTER TABLE rental
ADD CONSTRAINT fk_rental_customers
FOREIGN KEY (customer_id)
REFERENCES customer(customer_id)
ON DELETE RESTRICT;

CREATE INDEX idx_payment_date_amount_customer_id
ON payment(payment_date, amount, customer_id);

-- Query to list all indexes in Sakila schema
SELECT 
    TABLE_NAME,
    INDEX_NAME
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'sakila';

-- Query to generate index creation statements for customer table
SELECT CONCAT('ALTER TABLE sakila.customer ADD INDEX ', INDEX_NAME, ' (', GROUP_CONCAT(COLUMN_NAME ORDER BY SEQ_IN_INDEX), ');') AS index_creation_statement
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'sakila' AND TABLE_NAME = 'customer'
GROUP BY INDEX_NAME;
























