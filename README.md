# NYC Taxi Analytics Platform  
**Production-Ready Lakehouse → Warehouse → BI Pipeline**

---

## 📌 Project Overview

This project implements an **end-to-end, production-grade data engineering pipeline** for analyzing **NYC Yellow Taxi trip data** using a modern **Lakehouse architecture**.

### Key Capabilities
- ✅ Incremental, date-driven ingestion  
- ✅ Scalable Spark transformations  
- ✅ Analytics-ready **Gold** layer  
- ✅ Automated Snowflake ingestion using **Snowpipe**, **Streams** & **Tasks**  
- ✅ Business-ready dashboards built in **Power BI**

The architecture and design patterns closely mirror real-world enterprise data platforms.

---

## 🏗️ High-Level Architecture

```text
Public NYC Taxi Data
        ↓
Databricks (Spark)
  ├─ Bronze (Raw / Daily Extracts)
  ├─ Silver (Cleaned, Deduplicated)
  ├─ Gold (Business Metrics)
  └─ Outbound (Daily Snapshots)
        ↓
Snowflake
  ├─ Stage Tables
  ├─ Streams
  ├─ Tasks + Stored Procedures
  └─ Analytics Tables
        ↓
Power BI Dashboards
```

---

## 🧰 Tech Stack

| Layer | Technology |
|-------|------------|
| **Ingestion & Processing** | Databricks, Apache Spark (PySpark) |
| **Storage** | Amazon S3 |
| **Lakehouse Format** | Delta Lake |
| **Orchestration** | Databricks Jobs |
| **Data Warehouse** | Snowflake |
| **Streaming Ingestion** | Snowpipe |
| **Change Data Capture** | Snowflake Streams |
| **Transformation** | Snowflake Tasks & Stored Procedures |
| **BI & Visualization** | Power BI |
| **Languages** | Python, SQL |

---

## 🗂️ S3 Bucket Structure

```
s3://nyc-lakehouse/
├── bronze/
│   ├── stage/              # Monthly raw parquet files from source
│   ├── daily_extract/      # One-day extracts (for backfills)
│   └── processed/          # Ingested & tracked bronze data
│
├── silver/                 # Cleaned, validated, enriched Delta tables
│
├── gold/                   # Analytics-ready business metrics
│   ├── daily_stats/
│   ├── hourly_stats/
│   ├── location_analytics/
│   ├── payment_analysis/
│   └── business_summary/
│
└── outbound/               # Daily snapshots → contracted interface for Snowflake
    ├── daily_stats/
    ├── hourly_stats/
    ├── location_analytics/
    ├── payment_analysis/
    └── business_summary/
```

---

## 📓 Databricks Notebooks

| Order | Notebook Name | Schedule | Purpose & Key Features |
|-------|--------------|----------|------------------------|
| **1** | `Extract_to_bronze` | Manual | Downloads monthly raw parquet files from NYC Taxi source → `bronze/stage` |
| **2** | `Bronze_daily_ingestion` | Daily | Idempotent daily ingestion: checks monthly file, extracts one day, writes to Bronze |
| **3** | `Load_silver` | Daily (chained) | Deduplication, validation, quarantine, derived columns (duration, speed, tip %, etc.) |
| **4** | `Load_gold` | Daily (chained) | Builds 5 analytics models → optimized Delta tables in Gold layer |
| **5** | `Load_outbound` | Daily (chained) | Exports daily snapshots from Gold → Parquet files in `outbound/` |

### Key Characteristics
- ✅ Idempotent pipelines
- ✅ Date-driven & backfill-friendly
- ✅ Uses `MERGE` for safe upserts
- ✅ Designed for both initial load and daily incremental processing

---

## ⏱️ Orchestration (Databricks Jobs)

Single daily Databricks Job with this execution sequence:

```
Bronze_daily_ingestion
          ↓
     Load_silver
          ↓
      Load_gold
          ↓
   Load_outbound
```

**Benefits:**
- ✅ Fully managed within Databricks (no external scheduler needed)
- ✅ Compatible with Databricks Free Edition / Community Edition

---

## ❄️ Snowflake Architecture

### Ingestion Flow

1. **Snowpipe** auto-ingests Parquet files from `s3://.../outbound/`
2. Loads into **Stage Tables**
3. **Streams** track changes (new data)
4. **Tasks** trigger automatically on stream data
5. **Stored Procedures** perform `MERGE` into final **Analytics tables**

### Layered Flow

```
STAGE → STREAM → TASK + PROCEDURE → ANALYTICS TABLES
```

**Features:**
- ✅ Incremental loads only
- ✅ Exactly-once processing
- ✅ No duplicate records

---

## 📊 Power BI Dashboards

Power BI connects directly to Snowflake Analytics Views.

### Report Pages

#### 📌 Executive Overview
**Total Trips** • **Total Revenue** • **Avg Revenue per Trip** • **Time Trends**

#### 🚕 Demand & Usage Patterns
**Trips by hour/day** • **Peak hours** • **Busiest days**

#### 🏙️ Location Intelligence
**Top pickup/dropoff zones** • **Borough-level insights** • **Revenue by location**

#### 💳 Payment & Tipping Behavior
**Payment type breakdown** • **Average tip %** • **Tipping trends (weekday vs weekend)**

#### 📈 Operational Insights
**Trip distance vs revenue** • **Short vs long trip analysis** • **Efficiency metrics**

---

**Dashboard Design Philosophy:**
> Business logic pushed upstream → minimal DAX required in Power BI

---

## 🧠 Key Design Decisions

1. **Medallion architecture** (Bronze → Silver → Gold)
2. **Idempotent and date-partitioned ingestion**
3. **Outbound snapshot pattern** to cleanly decouple Databricks & Snowflake
4. **Snowflake Streams + Tasks** for lightweight, incremental warehouse updates
5. **Analytics-ready Gold layer** to minimize transformation logic in BI tools

---

## 📌 Future Enhancements

- [ ] Data quality validation with **Great Expectations**
- [ ] CI/CD pipeline for notebooks and code (Databricks Repos + GitHub Actions)
- [ ] Pipeline failure alerting (Databricks alerts / email / Slack)

---

## 👤 Author

**Aakash Deepak Bartakke**  
MS in Computer Science at Binghamton University, New York | Data Engineering  
📍 United States

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!  
Feel free to check the [issues page](../../issues).

---

## ⭐ Show Your Support

Give a ⭐️ if this project helped you!

---

## 📧 Contact

For questions or collaborations, feel free to reach out:
- LinkedIn: https://www.linkedin.com/in/aakash-bartakke/
- Email: aakashbartakke21@gmail.com
