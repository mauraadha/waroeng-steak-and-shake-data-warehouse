# Waroeng Steak and Shake Data Warehouse
### Optimizing Inventory & Supply Chain with Dimensional Modeling

![Status](https://img.shields.io/badge/Status-Completed-success)
![Role](https://img.shields.io/badge/Role-Data%20Engineer%20%26%20Analyst-blue)
![Tech](https://img.shields.io/badge/Stack-PostgreSQL%20%7C%20Kimball-orange)

## 📖 Executive Summary
This project aims to modernize the inventory management system for **Waroeng Steak & Shake (Ciputat Branch)**.

Previously, the branch relied on manual logbooks and weekly Excel recaps, leading to **data inaccuracy** and difficulty in tracking **food waste**.
I designed a centralized **Data Warehouse** using **PostgreSQL** to automate data consolidation. This system enables management to track daily stock movements, analyze menu profitability, and significantly reduce food spoilage.

📄 **[Read the Full Documentation PDF here](%5BSteaknShake%5D%20Document.pdf)**

---

## Architecture Design
I utilized the **Kimball Bottom-Up** methodology to design a scalable Data Warehouse architecture that supports cross-functional analysis.

### 1. Conceptual Architecture (The Big Picture)
To provide a holistic view of the business, I designed a **Galaxy Schema** that integrates both **Sales** and **Inventory** processes. This ensures that the management can analyze the correlation between menu popularity (Sales) and material usage (Stock).

![Full Architecture](%5BSteaknShake%5D%20Stock%20%2B%20Sales%20Star%20Schema.png)
*(Figure: Integrated Data Warehouse Design for Sales & Inventory)*

### 2. Implementation Focus: Inventory Module
For this specific repository, I focused on implementing the **Stock Management** module to address the critical issue of food waste. Below is the detailed schema deployed in PostgreSQL.

![Stock Schema](%5BSteaknShake%5D%20Stock%20Schema.png)
*(Figure: Detailed Star Schema for Stock Fact Table & Dimensions)*

* **Fact Table:** `Stock_Fact` (Daily transaction of received, used, and wasted items).
* **Dimensions:** `Dim_Menu` and `Dim_Supplier`.

---

## Technical Implementation

### A. Database Schema (DDL)
The warehouse structure is built using **PostgreSQL**. The core logic ensures referential integrity between the Fact Table and Dimensions.
*(Full code available in [`schema.sql`](schema.sql))*

```sql
-- Creating the Fact Table
CREATE TABLE stock_fact (
    stock_id INT PRIMARY KEY,
    menu_id INT NOT NULL,
    supplier_id INT NOT NULL,
    stock_date DATE NOT NULL,
    quantity_received DECIMAL(10,2),
    quantity_wasted DECIMAL(10,2),
    quantity_remain DECIMAL(10,2),
    CONSTRAINT fk_stock_menu FOREIGN KEY (menu_id) REFERENCES menu_dimension (menu_id)
);
```
### B. ETL Process (Data Cleaning)
Raw data from manual inputs often contained inconsistent naming (e.g., "Sapi", "Daging Sapi"). I implemented SQL scripts to **clean and normalize** this data before loading.

```sql
-- Standardizing inconsistent category names
UPDATE supplier_dimension
SET supplier_category = 'Daging Sapi'
WHERE supplier_category IN ('Dagingsapi', 'Sapi', 'Daging sapi');
```
## Business Impact
Waste Reduction: Management can now pinpoint exactly which menu items contribute the most to daily waste (quantity_wasted).

- Automated Reporting: Replaced 1 hour of manual daily recap work with automated query views.
- Supply Chain Visibility: Clearer insights into supplier performance and stock longevity.
