# Available Data in EconData

In this document, we give a list of the datasets that are hosted in [EconData](https://www.econdata.co.za). Dataset IDs are given in monospace font after the name. The `h2` headings are Schema (where the dataflows are largely organised into Data Providers); and the `h3` headings are categories.

## Statistics South Africa (StatsSA)

### Primary Sector

-   Mining	[`MINING`](./statssa/MINING.md)


### Secondary Sector

-   Electricity Production	[`ELECTRICITY`](./statssa/ELECTRICITY.md)
-   Manufacturing	[`MANUFACTURING`](./statssa/MANUFACTURING.md)


### Judiciary

-   Civil Cases for Debt	[`CIVIL_CASES`](./statssa/CIVIL_CASES.md)
-   Liquidations and Insolvencies	[`LIQUIDATIONS`](./statssa/LIQUIDATIONS.md)


### Price Indicies (Inflation)

-   CPI Analytical Series	[`CPI_ANL_SERIES`](./statssa/CPI_ANL_SERIES.md)
-   CPI COICOP 5-digits	[`CPI_COICOP_5`](./statssa/CPI_COICOP_5.md)<br/>
    The Classification of Individual Consumption According to Purpose (COICOP) is the international reference classification of household expenditure.
-   Producer Price Index	[`PPI`](./statssa/PPI.md)

### Travel

-   Land Transport	[`LAND_TRANSPORT`](./statssa/LAND_TRANSPORT.md)
-   Tourism and Migration	[`MIGRATION`](./statssa/MIGRATION.md)
-   Tourist Accommodation	[`TOURIST_ACCOMMODATION`](./statssa/TOURIST_ACCOMMODATION.md)


### Trade

-   Motor Trade	[`MOTOR_TRADE`](./statssa/MOTOR_TRADE.md)
-   Retail Trade	[`RETAIL`](./statssa/RETAIL.md)
-   Wholesale Trade	[`WHOLESALE`](./statssa/WHOLESALE.md)


### Human Capital

-   Regional Population Data	[`POPULATION_DATA_REG`](./statssa/POPULATION_DATA_REG.md)
-   SARB Population Data	[`POPULATION_DATA`](./sarb/POPULATION_DATA.md)
-   Quarterly Labour Force Survey	[`QLFS`](./statssa/QLFS.md)	(Subscriber-only.)



## Public Accounting

Reports on aggregate assets and government transactions. Public finance assesses government revenue and expenditure of the public authorities and adjustments that are made. It includes accounting, budgeting and debt, at various geospatial levels.

### National Treasury of South Africa

Not public.

The National Treasury is responsible for managing South Africa's national government finances.

-   Government Main Budget	`GOVTBUDGET`
-   Government Debt	`GOVTDEBT`
-   Government Contingent Liabilities	`GOVTGUARANTEES`

### Accounts from SARB

SARB reports on aggregate assets and government transactions, including government income and expenditure.

-   External Sector	[`EXTERNAL_SECTOR`](./sarb/EXTERNAL_SECTOR.md)
-   Financial Sector	[`FINANCIAL_SECTOR`](./sarb/FINANCIAL_SECTOR.md)
-   Fiscal Sector	[`FISCAL_SECTOR`](./sarb/FISCAL_SECTOR.md)
-   National Accounts	[`NATL_ACC`](./sarb/NATL_ACC.md)

### Accounts from StatsSA

Public finance assesses government revenue and expenditure of the public authorities and adjustments that are made. It includes accounting, budgeting and debt, at various geospatial levels. Public finance has an effect on: (1) The efficient allocation of available resources; (2) The distribution of income among citizens; and (3) The stability of the economy.

-   National Accounts	[`NATL_ACC`](./sarb/NATL_ACC.md) (STATSSA is also a Data Provider for `NATL_ACC`.)
-   Popular National Accounts Data	[`NATL_ACC_POP`](./statssa/NATL_ACC_POP.md)
-   Regional National Accounts	[`NATL_ACC_REG`](./statssa/NATL_ACC_REG.md)


## South African Reserve Bank (SARB)

### Banking Sector Data (Basel Regulatory Reporting)

The South African banking sector's information is based on different regulatory frameworks, namely Basel II (1 Jan 2008 - 31 Dec 2011), Basel 2.5 (1 Jan 2011 - 31 Dec 2012), and Basel III (1 Jan 2013 onwards). DI forms refer to the period prior to 1 January 2008 and the implementation of Basel II. The implementation of Basel II in 2008 involved a detailed process, including Pillar 1 (minimum regulatory capital), Pillar 2 (capital management), and Pillar 3 (market discipline). Basel III addresses systemic risks through capital quality, risk coverage, and additional buffers.

#### [BA100-series](./sarb/baforms/BA100-series.md) (financial returns)

-   Bank Balance Sheet (IFRS)	`BA100`
-   Bank Balance Sheet (IFRS) (pre-2008)	`DI100`
-   Bank Income Statement (IFRS)	`BA120`

#### [BA 200](./sarb/baforms/BA200.md) (Credit Risk)
-   Bank Credit Risk Exposure	`BA200`
-   Bank Income Statement (IFRS) (pre-2008)	`DI200`

#### [BA 300-series](./sarb/baforms/BA300-series.md) (Liquidity Risk)
-   Bank Selected Risk Exposure	`BA325`

#### [BA 700](./sarb/baforms/BA700.md) (Capital Adequacy)
-   Bank Capital Adequacy	`BA700`

#### [BA 900](./sarb/baforms/BA900.md) (balance sheets)
-   Bank Balance Sheet (institutional)	`BA900`<br/>
    [Shiny Dashboard](https://codera.co.za/coderas-banking-dashboard/)

### Indicators

-   Business Cycles	[`BUSINESS_CYCLES`](./sarb/BUSINESS_CYCLES.md)
-   Other Macroeconomic Indicators	`OTHER_INDICATORS`


### Rates

-   [CPD](https://nationalgovernment.co.za/units/view/408/corporation-for-public-deposits) Interest Rates	[`CPD_RATES`](./sarb/CPD_RATES.md)
-   Market Rates	[`MARKET_RATES`](./sarb/MARKET_RATES.md)
-   Codera Exchange Rate Forecasts	[`FX_FCAST`](./codera/FX_FCAST.md)	(Subscriber-only.)
    - EURZAR
    - GBPZAR
    - USDZAR

## Association for Savings and Investment South Africa (ASISA)

Subscriber-only.

The Association for Savings and Investment South Africa (ASISA) represents the collective interests of the country's asset managers, collective investment scheme management companies, linked investment service providers, multi-managers and life insurance companies. EconData hosts key series provided publicly by ASISA.

#### [Collective Investment Schemes (CIS)](./asisa/CIS.md)

These dataflows are forthcoming.

-   Hedge Funds	[`CIS_HEDGE`](./asisa/CIS.md#hedge-funds)
-   Local Holdings	[`LOCAL_HOLDINGS`](./asisa/CIS.md#local-holdings)
-   Local Flows	[`LOCAL_FLOWS`](./asisa/CIS.md#local-flows)
-   Foreign Funds	[`CIS_FOREIGN`](./asisa/CIS.md#foreign-funds)


