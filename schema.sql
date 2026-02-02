-- 1. DIMENSION TABLES
-- Menu Dimension: Stores product details and costs
CREATE TABLE menu_dimension (
    menu_id INT PRIMARY KEY,
    menu_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    menu_category VARCHAR(50),
    cost_price DECIMAL(10,2)
);

-- Supplier Dimension: Stores vendor information
CREATE TABLE supplier_dimension (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    supplier_category VARCHAR(50),
    contact_person VARCHAR(100),
    phone_number VARCHAR(20),
    address VARCHAR(100)
);

-- 2. FACT TABLE
-- Stock Fact: Records daily inventory transactions
CREATE TABLE stock_fact (
    stock_id INT PRIMARY KEY,
    menu_id INT NOT NULL,
    supplier_id INT NOT NULL,
    stock_date DATE NOT NULL,
    expiration_date DATE,
    unit_of_measure VARCHAR(20),
    quantity_received DECIMAL(10,2),
    quantity_used DECIMAL(10,2),
    quantity_wasted DECIMAL(10,2), -- Critical metric for waste analysis
    quantity_remain DECIMAL(10,2),
    
    -- Foreign Key Constraints
    CONSTRAINT fk_stock_menu FOREIGN KEY (menu_id) REFERENCES menu_dimension (menu_id),
    CONSTRAINT fk_stock_supplier FOREIGN KEY (supplier_id) REFERENCES supplier_dimension (supplier_id)
);

-- 3. ETL / DATA CLEANING EXAMPLES
-- Standardizing 'Meat' category names to single format
UPDATE supplier_dimension
SET supplier_category = 'Daging Sapi'
WHERE supplier_category IN ('Dagingsapi', 'Sapi', 'Daging sapi');

-- Trimming whitespace from menu names
UPDATE menu_dimension
SET menu_name = TRIM(menu_name);
