# Supply Chain & Inventory Optimization Analytics

An end-to-end data analytics project translating 180,000+ supply chain
transactions into actionable inventory and operations insights.

---

## Tools & technologies

| Tool | Purpose |
|------|---------|
| Python (pandas, Prophet, seaborn) | Data cleaning, EDA, demand forecasting |
| SQL (SQLite) | Analytical queries, ABC classification |
| Power BI | Interactive 3-page executive dashboard |
| Excel | Dynamic reorder calculator, scenario analysis |

---

## Project structure

```
notebooks/          # Jupyter notebooks
sql/                # SQL query scripts
outputs/            # Charts and visualizations
reorder_calculator.xlsx     # Excel inventory tool
supply_chain_dashboard.pbix # Power BI dashboard
```

---

## Dataset

**DataCo Smart Supply Chain**
180,519 orders · 55 columns · January 2015 – January 2018
Source: [Kaggle — DataCo Smart Supply Chain for Big Data Analysis](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis)

> The dataset is not included in this repository due to file size.
> Download from Kaggle and place the CSV in a `/data` folder before running notebooks.

---

## Key findings

- **First Class shipping has a 95.3% late delivery rate** which is the worst of
  all modes despite being the premium tier. Standard Class (38.1%) is
  the most reliable.

- **Men's Footwear is in active stockout risk** with only 88 units on hand against
  a reorder point of 138, with only 4 days of supply remaining.

- **4 of 10 categories are overstocked** - Cleats holds 521 units against
  a ROP of 153 (3.4× threshold), tying up working capital unnecessarily.

- **Demand forecast MAPE: 7.3%** - Prophet model trained on 32 months of
  daily data produces reliable 90-day forward projections.

- **Fishing leads revenue at $6.9M** - 57% ahead of second-place Cleats
  ($4.4M), confirming outdoor/sports as the core business vertical.

---

## Notebooks

| Notebook | Section | Description |
|----------|---------|-------------|
| `01_data_exploration.ipynb` | 2 | Data cleaning, feature engineering, EDA visualisations |
| `02_sql_analysis.ipynb` | 3 | 5 analytical SQL queries including ABC classification |
| `03_forecasting.ipynb` | 4 | Prophet demand forecasting with cross-validation (MAPE 7.3%) |
| `04_inventory_optimization.ipynb` | 5 | Safety stock, ROP, EOQ calculations for top 10 categories |

---

## Dashboard pages

| Page | Content |
|------|---------|
| Executive Overview | KPI cards, late delivery by mode, inventory status donut, revenue trend |
| Product Analysis | Top 10 categories by revenue, category scorecard matrix, inventory thresholds |
| Operations & Forecasting | Shipping performance, 90-day demand forecast, inventory vs. ROP chart |

---

## Excel workbook (reorder_calculator.xlsx)

| Sheet | Description |
|-------|-------------|
| Reorder Calculator | Dynamic calculator - input demand, lead time, service level → outputs safety stock, ROP, EOQ |
| Scenario Analysis | Heat map showing ROP across 25 combinations of demand and lead time |
| Inventory Snapshot | Formatted table of all 10 categories with conditional formatting by health status |

---

## Inventory formulas used

```
Safety Stock  = Z × √(L × σ_d² + d̄² × σ_L²)
Reorder Point = (d̄ × L) + Safety Stock
EOQ           = √(2 × D × S / H)
```

Where: `d̄` = avg daily demand, `L` = avg lead time, `σ` = standard deviation,
`Z` = 1.645 (95% service level), `S` = $50 order cost, `H` = 20% holding rate

---

## How to run

**1. Clone the repository**
```bash
git clone https://github.com/iamahmadyasin/supply-chain-analytics.git
cd supply-chain-analytics
```

**2. Create a virtual environment**
```bash
python -m venv venv
venv\Scripts\activate        # Windows
source venv/bin/activate     # Mac/Linux
```

**3. Install dependencies**
```bash
pip install -r requirements.txt
```

**4. Download the dataset**

Download `DataCoSupplyChainDataset.csv` from Kaggle and place it in a `/data` folder.

**5. Run notebooks in order**
```
01_data_exploration.ipynb
02_sql_analysis.ipynb
03_forecasting.ipynb
04_inventory_optimization.ipynb
```

---

## Requirements

```
pandas
numpy
matplotlib
seaborn
plotly
prophet
scikit-learn
sqlalchemy
openpyxl
jupyter
```

---

## Project sections

| Section | Tool | Output |
|---------|------|--------|
| 1 | Python | Environment setup, dataset loaded |
| 2 | Python | Cleaned dataset, 3 EDA charts |
| 3 | SQL | 5 analytical queries, supply_chain.db |
| 4 | Python (Prophet) | 90-day forecast, MAPE 7.3% |
| 5 | Python | Safety stock, ROP, EOQ per category |
| 6 | Power BI | 3-page interactive dashboard |
| 7 | Excel | Reorder calculator, scenario analysis |
| 8 | GitHub | Documentation, portfolio packaging |

---

*Built as a portfolio project demonstrating end-to-end data analytics
across Python, SQL, Power BI, and Excel in a corporate supply chain context.*
