AgriTrack – Smart Farming & Crop Marketplace
A MySQL database project designed to organize farming and crop-marketplace information. AgriTrack stores records related to farmers, farms, crops, harvests, buyers, produce orders, pesticide purchases, and equipment rentals.
Project scope: This repository contains a relational database implementation and SQL query exercises. It is a database project, not a deployed web application or a live marketplace.

Objectives
- Maintain farmer and farm information in a structured database.
- Store crop details and track harvest quantities and dates.
- Maintain buyer and produce-order records.
- Record pesticide purchases and equipment rentals associated with farms.
- Practise SQL queries to retrieve, summarize, and analyze the stored information.
Technologies Used
- Database: MySQL
- Query Language: SQL
- Database Tool: MySQL Workbench
Database Tables
Table	Description
farmers	Stores farmer details such as name, phone number, and village.
farms	Stores farm details, location, area, and the farmer who manages each farm.
crops	Stores crop names, growing seasons, and market prices.
harvests	Records crops harvested, harvest dates, and quantities.
buyers	Stores buyer details and buyer type.
produce_orders	Stores buyer orders, order dates, and order statuses.
order_details	Stores the crops, quantities, and prices included in each order.
pesticides	Records pesticide purchases associated with farms.
equipment_rentals	Tracks farm equipment rentals, dates, costs, and rental status.


Database Relationships
The database uses primary keys and foreign keys to connect related records. For example:
- One farmer can manage multiple farms.
- A farm can have multiple harvest records.
- A crop can appear in multiple harvest records.
- One buyer can place multiple produce orders.
- An order can contain multiple order-detail records.
- Farms can have multiple pesticide and equipment-rental records.
SQL Concepts Practised
- DDL: CREATE DATABASE, CREATE TABLE, ALTER TABLE
- DML: INSERT, UPDATE, DELETE, SELECT
- Constraints: PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE, DEFAULT, CHECK
- Filtering and sorting: WHERE, ORDER BY, DISTINCT, BETWEEN, IN, LIKE, IS NULL
- Aggregate functions: COUNT, SUM, AVG, MIN, MAX
- Grouping: GROUP BY, HAVING
- Joins and subqueries
- Conditional expressions and built-in SQL functions
- Window functions: RANK(), LAG(), LEAD()
- Views and indexes
- Stored procedures and stored functions
- Transactions: START TRANSACTION, COMMIT, ROLLBACK, SAVEPOINT
Repository Structure
AgriTrack-Smart-Farming-Database/
├── README.md
├── sql/
│   └── Agri_Track_Project.sql
└── docs/
    └── IMPLEMENTATION.md
How to Run the Project
1. Install MySQL Server and MySQL Workbench.
2. Open MySQL Workbench and connect to your local MySQL Server.
3. Open the file sql/Agri_Track_Project.sql in the SQL Editor.
4. Review the script and execute it in a development environment.
5. Refresh the Schemas panel and select the agritrack database.
6. Explore the tables and execute the example queries in the script.
Note: The script creates the agritrack database. It is intended for initial setup; running the entire script repeatedly may cause existing-object or duplicate-record errors. Use a test database and review any data-changing statements before execution.
Author
Pathi Vijay Kumar
GitHub: VijayKumarPathi
LinkedIn: Pathi Vijay Kumar
