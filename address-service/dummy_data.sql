-- dummy_data.sql
-- Optional seed data for local development. NOT a Flyway migration.
--
-- Apply manually against a database whose schema has already been migrated:
--   psql "$DATABASE_URL" -f src/main/resources/db/seed/dummy_data.sql
-- or inside Compose:
--   docker compose exec -T postgres psql -U "$DB_USER" -d "$DB_NAME" \
--     < src/main/resources/db/seed/dummy_data.sql
--
-- Re-running the script replaces the addresses of the seeded users only.

BEGIN;

DELETE FROM addresses
WHERE user_id IN (
    'CUST001', 'CUST002', 'CUST003', 'CUST004', 'CUST005', 'CUST006',
    'EMP001', 'EMP002', 'EMP003'
);

-- Insert addresses for CUSTOMER users
-- Customer 1: CUST001 (Regular customer with multiple addresses)
INSERT INTO addresses (
    user_id,
    user_type,
    street,
    city,
    state,
    country,
    postal_code,
    additional_details,
    is_default,
    active,
    created_at,
    updated_at
) VALUES
-- Customer 1 - Home address (default)
(
    'CUST001', 'CUSTOMER',
    '123 Main Street', 'New York', 'NY', 'US', '10001',
    'Apt 4B', TRUE, TRUE,
    NOW() - INTERVAL '6 months',
    NOW() - INTERVAL '2 months'
),
-- Customer 1 - Work address
(
    'CUST001', 'CUSTOMER',
    '456 Business Ave', 'New York', 'NY', 'US', '10018',
    'Floor 15, Suite 1502', FALSE, TRUE,
    NOW() - INTERVAL '5 months',
    NOW() - INTERVAL '1 month'
),
-- Customer 1 - Vacation home
(
    'CUST001', 'CUSTOMER',
    '789 Beach Road', 'Miami', 'FL', 'US', '33139',
    'Unit 12B', FALSE, TRUE,
    NOW() - INTERVAL '4 months',
    NOW() - INTERVAL '3 weeks'
);

-- Customer 2: CUST002 (Customer with 3 addresses)
INSERT INTO addresses (
    user_id, user_type, street, city, state, country, postal_code, additional_details, is_default, active, created_at
) VALUES
(
    'CUST002', 'CUSTOMER',
    '321 Oak Avenue', 'Los Angeles', 'CA', 'US', '90001',
    NULL, TRUE, TRUE, NOW() - INTERVAL '3 months'
),
(
    'CUST002', 'CUSTOMER',
    '654 Pine Street', 'San Francisco', 'CA', 'US', '94105',
    'Unit 7', FALSE, TRUE, NOW() - INTERVAL '2 months'
),
(
    'CUST002', 'CUSTOMER',
    '987 Maple Drive', 'San Diego', 'CA', 'US', '92101',
    NULL, FALSE, TRUE, NOW() - INTERVAL '1 month'
);

-- Customer 3: CUST003 (Customer with 5 addresses - max limit)
INSERT INTO addresses (
    user_id, user_type, street, city, state, country, postal_code, additional_details, is_default, active, created_at
) VALUES
(
    'CUST003', 'CUSTOMER',
    '111 First Street', 'Chicago', 'IL', 'US', '60601',
    'Apt 201', TRUE, TRUE, NOW() - INTERVAL '6 months'
),
(
    'CUST003', 'CUSTOMER',
    '222 Second Avenue', 'Chicago', 'IL', 'US', '60602',
    'Suite 300', FALSE, TRUE, NOW() - INTERVAL '5 months'
),
(
    'CUST003', 'CUSTOMER',
    '333 Third Boulevard', 'Chicago', 'IL', 'US', '60603',
    NULL, FALSE, TRUE, NOW() - INTERVAL '4 months'
),
(
    'CUST003', 'CUSTOMER',
    '444 Fourth Lane', 'Evanston', 'IL', 'US', '60201',
    'Unit 5B', FALSE, TRUE, NOW() - INTERVAL '3 months'
),
(
    'CUST003', 'CUSTOMER',
    '555 Fifth Circle', 'Oak Park', 'IL', 'US', '60302',
    NULL, FALSE, TRUE, NOW() - INTERVAL '2 months'
);

-- Customer 4: CUST004 (International customer)
INSERT INTO addresses (
    user_id, user_type, street, city, state, country, postal_code, additional_details, is_default, active, created_at
) VALUES
(
    'CUST004', 'CUSTOMER',
    'Calle Gran Vía 28', 'Madrid', 'Madrid', 'ES', '28013',
    'Piso 3, Puerta 5', TRUE, TRUE, NOW() - INTERVAL '4 months'
),
(
    'CUST004', 'CUSTOMER',
    'Avenida Diagonal 123', 'Barcelona', 'Cataluña', 'ES', '08018',
    NULL, FALSE, TRUE, NOW() - INTERVAL '3 months'
),
(
    'CUST004', 'CUSTOMER',
    'Calle Sierpes 45', 'Sevilla', 'Andalucía', 'ES', '41004',
    'Bajo B', FALSE, TRUE, NOW() - INTERVAL '2 months'
);

-- Customer 5: CUST005 (Canadian customer)
INSERT INTO addresses (
    user_id, user_type, street, city, state, country, postal_code, additional_details, is_default, active, created_at
) VALUES
(
    'CUST005', 'CUSTOMER',
    '123 Queen Street', 'Toronto', 'ON', 'CA', 'M5H 2N2',
    NULL, TRUE, TRUE, NOW() - INTERVAL '5 months'
),
(
    'CUST005', 'CUSTOMER',
    '456 Granville Street', 'Vancouver', 'BC', 'CA', 'V6C 1T2',
    'Suite 800', FALSE, TRUE, NOW() - INTERVAL '4 months'
);

-- Customer 6: CUST006 (UK customer)
INSERT INTO addresses (
    user_id, user_type, street, city, state, country, postal_code, additional_details, is_default, active, created_at
) VALUES
(
    'CUST006', 'CUSTOMER',
    '221B Baker Street', 'London', 'Greater London', 'UK', 'NW1 6XE',
    NULL, TRUE, TRUE, NOW() - INTERVAL '3 months'
);

-- Insert addresses for EMPLOYEE users
-- Employee 1: EMP001 (Should only have 1 address per business rule)
INSERT INTO addresses (
    user_id, user_type, street, city, state, country, postal_code, additional_details, is_default, active, created_at
) VALUES
(
    'EMP001', 'EMPLOYEE',
    '100 Corporate Drive', 'Austin', 'TX', 'US', '78701',
    'Floor 10', TRUE, TRUE, NOW() - INTERVAL '2 months'
);

-- Employee 2: EMP002 (Should only have 1 address)
INSERT INTO addresses (
    user_id, user_type, street, city, state, country, postal_code, additional_details, is_default, active, created_at
) VALUES
(
    'EMP002', 'EMPLOYEE',
    '200 Innovation Way', 'Seattle', 'WA', 'US', '98101',
    NULL, TRUE, TRUE, NOW() - INTERVAL '1 month'
);

-- Employee 3: EMP003 (Remote employee with international address)
INSERT INTO addresses (
    user_id, user_type, street, city, state, country, postal_code, additional_details, is_default, active, created_at
) VALUES
(
    'EMP003', 'EMPLOYEE',
    'Av. Paulista 1000', 'São Paulo', 'SP', 'BR', '01310-100',
    'Conjunto 1501', TRUE, TRUE, NOW() - INTERVAL '45 days'
);

-- Inactive (soft-deleted) addresses for testing
INSERT INTO addresses (
    user_id, user_type, street, city, state, country, postal_code, additional_details, is_default, active, created_at, updated_at
) VALUES
(
    'CUST001', 'CUSTOMER',
    'Old Address 123', 'New York', 'NY', 'US', '10001',
    NULL, FALSE, FALSE,
    NOW() - INTERVAL '1 year',
    NOW() - INTERVAL '6 months'
),
(
    'CUST002', 'CUSTOMER',
    'Temporary Housing', 'Los Angeles', 'CA', 'US', '90001',
    NULL, FALSE, FALSE,
    NOW() - INTERVAL '8 months',
    NOW() - INTERVAL '4 months'
);

COMMIT;
