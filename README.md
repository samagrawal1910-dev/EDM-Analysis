**Overview**
This project analyses Event Duration Monitoring (EDM) spill data from 2020 to 2024 to understand trends in spill duration across selected EDM sites and to assess performance under varying environmental conditions.
To maintain analytical clarity and focus, the study is based on 20 representative EDM sites, selected according to total spill duration. These sites account for a significant proportion of overall spill activity and provide a meaningful subset for comparative analysis.

The analysis combines:
SQL for data preparation and aggregation
Power BI for data modelling, visualisation, and insights
UK annual rainfall data to provide environmental context
The objective is to evaluate whether EDM performance remained stable even during years of higher rainfall.

**Data & Scope**
Years analysed: 2020–2024
Sites analysed: 20 (selected by total spill duration)
Metrics: Total spill duration (hrs), YoY change, YoY %
Rainfall data: Annual UK rainfall totals used for contextual comparison across the same time period.

**Tools & Methods**

**MySQL**
- Data filtering, aggregation, and year-wise analysis
- Queries for YoY change, top sites, zero-duration sites

**Power BI**
- Data modelling (Fact & Dimension tables)
- DAX measures for KPIs and YoY calculations
- Interactive dashboards with slicers and drill-downs

**Key Visualisation**
**Executive Summary Dashboard**
- Total Spill Duration (hrs)
- Year-over-Year (YoY) Change and YoY %
- Top 20 EDM Sites by Total Duration
- Line & Clustered Column Chart:
       - Columns: UK Rainfall (mm)
       - Line: Total Spill Duration (hrs)

**Site Performance Dashboard**
- Site-wise duration trends (2020–2024)
- Site ranking within the selected 20 sites
- YoY change and YoY % with conditional formatting
- Identification of consistently high-duration and improving sites

**Key Insights**
- Rainfall levels varied across the analysis period, with higher rainfall observed in 2020 and 2024.
- Despite increased rainfall in certain years, total spill duration across the selected 20 EDM sites did not increase proportionally.
- This suggests stable EDM performance under varying environmental conditions.
- Concentration of spill duration among a subset of sites highlights areas for targeted operational improvement.

**Conclusion**
By focusing on 20 high-impact EDM sites, this analysis provides a clear and manageable view of spill performance trends from 2020 to 2024. The results indicate that, even during years with higher rainfall, overall spill duration remained controlled, supporting the conclusion that EDM monitoring systems demonstrated resilience under environmental pressure.
