# Automated-Payments-ETL
Fully automated Python ETL pipeline with MySQL for payments data incremental loading and analytics ready SQL views.
# Automated Payments ETL Pipeline

This project is a **fully automated payments data pipeline** built with Python and MySQL, designed to simulate how real banking and fintech transaction systems generate, process, and refresh operational data.

The main focus of this project is **automation and backend data flow**, not dashboards. It demonstrates how ETL pipelines ingest, model, and prepare transactional data for analytics in real-world environments.

---

## **Project Highlights**

- **Incremental ETL with Python**  
  Generates new payment records continuously while avoiding duplicates or overwrites.

- **Structured MySQL Schema**  
  Includes `customers`, `accounts`, `payments`, and `transactions` tables designed for high-volume transactional workloads.

- **Automation with Task Scheduler**  
  The ETL pipeline runs automatically every few minutes, simulating real-time data ingestion without manual intervention.

- **Analytics-Ready SQL Views**  
  Includes views for:
  - Daily payment volumes  
  - Processing time trends  
  - Hourly transaction spikes  
  - Top customers  
  All views refresh automatically as new data is loaded.

---

## **Tech Stack**

- **Python** (for ETL and data generation)  
- **MySQL** (for storage, schema, and SQL views)  
- **Windows Task Scheduler** (for automation)  
- **Faker** library (for generating synthetic payment data)

---

## **Folder Structure**

