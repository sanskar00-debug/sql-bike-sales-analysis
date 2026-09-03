# 🚴 Velocity Bikes — Relational SQL Database & Business Analytics

![MySQL](https://img.shields.io/badge/MySQL-8.0+-00758F?style=for-the-badge&logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-Desktop-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)

An end-to-end data analytics capstone analyzing operational sales data, customer demographics, and catalog pricing for **Velocity Bikes Ltd.** This repository contains relational schema definitions, progressive SQL analysis scripts across business tiers, an executive insights report, and an interactive Power BI dashboard.

---

## 📌 Project Overview

Velocity Bikes is a United States retail brand experiencing rapid growth across various regional markets. The primary goal of this project was to:
1. Normalize, structure, and import raw retail datasets into a relational **MySQL** database.
2. Execute multi-tier SQL queries ranging from foundational catalog filtering to complex 3-table relational joins, aggregations, and business logic.
3. Formulate data-driven business recommendations concerning dead inventory, loyalty incentives, and regional expansion.
4. Deliver visual reporting through an executive **Power BI** dashboard.

---

## 🏗️ Repository Architecture

```text
sql-bike-sales-analysis/
├── data/
│   ├── Customers.csv                      # Customer contact & location records (1,445 rows)
│   ├── Orders.csv                         # Transaction receipts and line items (4,722 rows)
│   └── Products.csv                       # Bike models, model years, and list prices (321 rows)
├── scripts/
│   ├── 01_schema_setup.sql                # DDL scripts: DB and table schema definitions
│   ├── 02_day1_basic_queries.sql          # Day 1: SELECT, WHERE, and numerical filtering
│   ├── 03_day2_joins_aggregations.sql     # Day 2: Multi-table JOINs, SUM(), and GROUP BY
│   └── 04_day3_capstone_analysis.sql      # Day 3: Strategic business questions & segmentation
├── dashboard/
│   ├── Bike_Sales_Analytics.pbix          # Interactive Power BI report file
│   └── dashboard_preview.png              # High-resolution dashboard screenshot
├── reports/
│   └── Velocity_Bikes_Business_Report.pdf # Final executive analysis deliverable
└── README.md


## 🗄️ Relational Database Schema

The database bike_store_db connects three relational tables:
┌────────────────────────┐         ┌────────────────────────┐
  │       customers        │         │        products        │
  ├────────────────────────┤         ├────────────────────────┤
  │ PK  customer_id        │         │ PK  product_id         │
  │     first_name         │         │     product_name       │
  │     last_name          │         │     model_year         │
  │     phone              │         │     price              │
  │     email              │         └───────────┬────────────┘
  │     street             │                     │ 1
  │     city               │                     │
  │     state              │                     │
  │     zip_code           │                     │
  └───────────┬────────────┘                     │
              │ 1                                │
              │                                  │
              │            ┌───────────┐         │
              └──────────* │  orders   │ *───────┘
                           ├───────────┤
                           │  order_id │
                           │  customer_id (FK)
                           │  product_id  (FK)
                           │  quantity │
                           │  price    │
                           │  order_date
                           └───────────┘

##**📊 Dashboard Preview**
Visual analytics implemented in Power BI Desktop featuring KPI summaries, dynamic state slicers, and revenue concentration models:

##**🚀 Setup & Execution**##
Prerequisites
- MySQL Server (8.0+) & MySQL Workbench

- Power BI Desktop (Optional, for .pbix report)

- Git CLI

##**📄 License**##
Distributed under the MIT License. See LICENSE for more information.
