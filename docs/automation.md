 ## ⚙ Automation
To ensure my COVID-19 dataset stays up-to-date, we can implemented an automated refresh process.

- **Tool**: Power Automate
- **Trigger**: Daily at 6 AM
- **Process**:
  1. Download latest dataset from official source.
  2. Save file to cloud storage.
  3. Trigger Power BI dataset refresh.
- **Benefit**: Eliminates manual data updates, ensures stakeholders always see the latest data.



**Flow Steps**:
1. **HTTP Request** – Downloads the latest COVID-19 data from the public dataset API.
2. **OneDrive Save** – Stores the CSV file in the project’s cloud storage for version tracking.
3. **Power BI Refresh** – Triggers an automatic refresh of the published dashboard.



## 🐍 Approach 2 – Python API Script

We can also implement a working automation using Python.

### Script Example (`automation/data_refresh.py`):

```python
import requests
import pandas as pd

# Download the latest dataset from Our World in Data
url = "https://covid.ourworldindata.org/data/latest/owid-covid-latest.csv"
response = requests.get(url)

# Save dataset locally
with open("data/owid-covid-latest.csv", "wb") as f:
    f.write(response.content)

# Load into pandas for quick validation
df = pd.read_csv("data/owid-covid-latest.csv")
print("Dataset downloaded successfully with", len(df), "rows")
print(df.head())

Scheduling

This script can be scheduled with Windows Task Scheduler (daily at 6 AM) to simulate an automated refresh.

Once saved, the updated CSV can be reloaded into Power BI for analysis.