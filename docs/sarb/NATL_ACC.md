# National Accounts

ID: `NATL_ACC`

When `compact = FALSE`, use the last two items in the version list, as the data flows from both SARB and STATSSA.

| Concept | (Constant) Value |
| --- | --- |
| Source Dataset (StatsSA) | P0441 |
| Source ID (SARB) | _varies_ |
| Base Period | 2015 |
| Unit of measure | Rand |
| Frequency | Quarterly |
| Unit multiplier | Millions |

The base period is likely to change with new versions.

## 1. Series Name

The 4th to 7th digit of the data key are shown here in monospace font after the name.

### Source: SARB

-	GDP at market prices  	`6006`
-	Final consumption expenditure by household  	`6007`
-	Final consumption expenditure by general government  	`6008`
-	Gross fixed capital formation  	`6009`
-	Residual item  	`6011`
-	Gross domestic expenditure  	`6012`
-	Exports of goods and services  	`6013`
-	Imports of goods and services  	`6014`
-	Agriculture, forestry and fishing 	`6631`
-	Mining and quarrying 	`6632`
-	Manufacturing 	`6634`
-	Electricity and water 	`6635`
-	Construction (contractors) 	`6636`
-	Wholesale and retail trade, catering and accommodation 	`6638`
-	Transport, storage and communication 	`6639`
-	Finance and insurance, real estate and business services 	`6640`
-	General Government Services 	`6643`
-	Total value added at basic prices 	`6645`
-	Personal services 	`6647`

### Source: STATSSA

-	GDP at market prices	`6006.R`
-	GDP at current prices	`6006.N`
-	Agriculture, forestry and fishing	`6631`
-	Mining and quarrying	`6632`
-	Manufacturing	`6634`
-	Electricity and water	`6635`
-	Construction (contractors)	`6636`
-	Wholesale and retail trade, catering and accommodation	`6638`
-	Transport, storage and communication	`6639`
-	Finance and insurance, real estate and business services	`6640`
-	General Government Services	`6643`
-	Total value added at basic prices	`6645`
-	Other	`6647`

## 2. Price Concept

The StatsSA data are real, except for "GDP at current prices". The SARB data contains either value.

-   Nominal	`N`
-   Real	`R`

## 3. Seasonal Adjustment

The SARB data is only "Seasonally adjusted data, not calendar adjusted" `S`.

The StatsSA data contains both:

-   Neither seasonally adjusted nor calendar adjusted data	`N`
-   Seasonally adjusted data, not calendar adjusted	`S`

for every single concept, where the labels for the seasonally adjusted data are suffixed with " (annualised)".
