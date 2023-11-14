# Quarterly Labour Force Survey (QLFS)

ID: `QLFS`

Codera Analytics engineers the **aggregate** Excel file, loading our structured data into [EconData](https://www.econdata.co.za/) within half an hour of the data being made publicly available by StatsSA. See our blog posts here: https://codera.co.za/?s=qlfs

## Overall dataset concepts

| Feature | Value |
| :--- | :--- |
| Country | South Africa |
| Source | StatsSA |
| Dataset | QLFS |
| Publication code | P0211 |
| Frequency | Quarterly |
| Unit Multiplier | Thousands |

The series starts at the beginning of 2008, unless otherwise stated.

## Excel file URL

```r
paste0( "https://www.statssa.gov.za/publications/P0211/QLFS%20Trends%202008-",
        year,
        "Q",
        quarter,
        ".xlsx"     )
```

where `year` and `quarter` should be the latest available quarter.

## Data Key

The data key contains four dimensions. The order of the `data_key` is:

LABSTAT.CATEGORY.AREA.SEX

The number of characters in the codes (as outlined below) used in the dimensions are 4, 5, 2 and 1 respectively, with full-stops between the codes in the data key.

When the dimensions are put together, 1143 concepts are available.

## 1. LABSTAT

"LABSTAT" stands for labour statistic, but this dimension could be referred to as the "variables". In most cases the concept is the estimated number of people in South Africa's population falling into the definition, based on survey weights. Some concepts are percentages (where `R` for 'rate' is used for the third character).

-	Population count	`POPC`
-	Labour Force (narrow)	`LFON`
-	Labour Force (broad)	`LFOB`
-	Employed	`EMPL`
-	Unemployed (narrow)	`UNEN`
-	Unemployed (broad)	`UNEB`
-	Not economically active (narrow)	`NEAN`
-	Not economically active (broad)	`NEAB`
-	Discouraged work seekers	`DWSE`
-	Other not economically active	`NEAO`
-	NEA: Student	`NEAS`
-	NEA: Home-maker	`NEAH`
-	NEA: Illness/disability	`NEAI`
-	NEA: Too old/young to work	`NEAA`
-	NEA: Other (excluding the above)	`NEAE`
-	Unemployment rate (narrow)	`UNRN`
-	Unemployment rate (broad)	`UNRB`
-	Absorption rate (employed/population)	`ABRP`
-	Labour force participation rate (narrow)	`LPRN`
-	Labour force participation rate (broad)	`LPRB`
-	Contributing towards pension/retirement funds: Yes	`CPFY`
-	Contributing towards pension/retirement funds: No	`CPFN`
-	Contributing towards pension/retirement funds: Don't know	`CPFD`
-	Entitled to any paid leave: Yes	`EPLY`
-	Entitled to any paid leave: No	`EPLN`
-	Entitled to any paid leave: Don't know	`EPLD`
-	Entitled to paid sick leave: Yes	`ESLY`
-	Entitled to paid sick leave: No	`ESLN`
-	Entitled to paid sick leave: Don't know	`ESLD`
-	Entitled to maternity/paternity leave: Yes	`EMLY`
-	Entitled to maternity/paternity leave: No	`EMLN`
-	Entitled to maternity/paternity leave: Don't know	`EMLD`
-	Contributing towards the UIF: Yes	`CUFY`
-	Contributing towards the UIF: No	`CUFN`
-	Contributing towards the UIF: Don't know	`CUFD`
-	Medical aid fringe benefits: Yes	`EMFY`
-	Medical aid fringe benefits: No	`EMFN`
-	Medical aid fringe benefits: Don't know	`EMFD`
-	Income tax (PAYE/SITE) deduction: Yes	`DITY`
-	Income tax (PAYE/SITE) deduction: No	`DITN`
-	Income tax (PAYE/SITE) deduction: Don't know	`DITD`
-	Condition of employment: Written contract	`ECWC`
-	Condition of employment: Verbal agreement	`ECVA`
-	Nature of contract/agreement: Limited duration	`ECLD`
-	Nature of contract/agreement: Permanent nature	`ECPN`
-	Nature of contract/agreement: Unspecified duration	`ECUD`
-	Trade union membership: Yes	`ETUY`
-	Trade union membership: No	`ETUN`
-	Trade union membership: Don't know	`ETUD`
-	How annual salary increment is negotiated: Individual and employer	`ESNI`
-	How annual salary increment is negotiated: Union and employer	`ESNU`
-	How annual salary increment is negotiated: Bargaining council	`ESNB`
-	How annual salary increment is negotiated: Employer only	`ESNE`
-	How annual salary increment is negotiated: No regular increment	`ESNN`
-	How annual salary increment is negotiated: Other	`ESNO`
-	Underemployed: Count	`UDEC`
-	Underemployed: Percentage of the labour force	`UDRL`
-	Underemployed: Percentage of total employment	`UDRE`
-	Unemployed: Job losers	`UNES`
-	Unemployed: Job leavers	`UNEA`
-	Unemployed: New entrants	`UNEW`
-	Unemployed: Re-entrants	`UNER`
-	Unemployed: Other	`UNEO`
-	Unemployment: Long-term unemployment (one year and more)	`UNEY`
-	Unemployment: Short-term unemployment (less than one year)	`UNEX`
-	Long-term unemployment: Proportion of the labour force	`UNYL`
-	Long-term unemployment: Proportion of the unemployed	`UNYU`
-	Unemployed, but worked in the past five years	`UN5T`
-	Unemployed, but worked in the past five years: Previous occupation	`UN5O`
-	Unemployed, but worked in the past five years: Previous industry	`UN5I`
-	Inactivity rate (per cent)	`INRA`
-	Not in education nor employment	`NEET`
-	Involvement in non-market activities: Subsistence farming	`NMSF`
-	Involvement in non-market activities: Fetching water or collecting wood/dung	`NMWW`
-	Involvement in non-market activities: Produce other goods for household use	`NMGH`
-	Involvement in non-market activities: Construction or major repairs to own or household	`NMCR`
-	Involvement in non-market activities: Hunting or fishing for household use	`NMHF`
-	Involvement in non-market activities: Involvement in at least one activity	`NM1A`
-	Involvement in non-market activities: Involvement in at least one activity, and employed	`NM1E`
-	Involvement in non-market activities: Involvement in at least one activity, and unemployed	`NM1U`
-	Involvement in non-market activities: Involvement in at least one activity, and NEA	`NM1N`

## 2. CATEGORY

In this dataflow, the most common category is the total, as shown at the top of the list below, noting that the entire Excel file is restricted to the working age population, 15–64 years old. The first letter of the codes in the data key groups the categories into 'super-categories'.

-	Age group: 15-64 years (Total)	`TOTAL`
-	Age group: 15-24 years	`A1524`
-	Age group: 25-34 years	`A2534`
-	Age group: 35-44 years	`A3544`
-	Age group: 45-54 years	`A4554`
-	Age group: 55-64 years	`A5564`
-	Age group: 25-54 years	`A2554`
-	Population group: Black/African	`RBLCK`
-	Population group: Coloured	`RCOLR`
-	Population group: Indian/Asian	`RASAN`
-	Population group: White	`RWHTE`
-	Industry: Agriculture	`IAGRA`
-	Industry: Mining	`IMINA`
-	Industry: Manufacturing	`IMANA`
-	Industry: Utilities	`IUTLA`
-	Industry: Construction	`ICONA`
-	Industry: Trade	`ITRDA`
-	Industry: Transport	`ITRNA`
-	Industry: Finance	`IFINA`
-	Industry: Community and social services	`ISERA`
-	Industry: Private households	`IHOSA`
-	Industry: Other	`IOTHA`
-	Industry: Mining: Formal sector	`IMINF`
-	Industry: Manufacturing: Formal sector	`IMANF`
-	Industry: Utilities: Formal sector	`IUTLF`
-	Industry: Construction: Formal sector	`ICONF`
-	Industry: Trade: Formal sector	`ITRDF`
-	Industry: Transport: Formal sector	`ITRNF`
-	Industry: Finance: Formal sector	`IFINF`
-	Industry: Community and social services: Formal sector	`ISERF`
-	Industry: Private households: Formal sector	`IHOSF`
-	Industry: Other: Formal sector	`IOTHF`
-	Industry: Mining: Informal sector	`IMINI`
-	Industry: Manufacturing: Informal sector	`IMANI`
-	Industry: Utilities: Informal sector	`IUTLI`
-	Industry: Construction: Informal sector	`ICONI`
-	Industry: Trade: Informal sector	`ITRDI`
-	Industry: Transport: Informal sector	`ITRNI`
-	Industry: Finance: Informal sector	`IFINI`
-	Industry: Community and social services: Informal sector	`ISERI`
-	Industry: Private households: Informal sector	`IHOSI`
-	Industry: Other: Informal sector	`IOTHI`
-	Sector: Formal and informal (non-agricultural)	`SFRIN`
-	Sector: Formal (non-agricultural)	`SFORM`
-	Sector: Informal (non-agricultural)	`SINFM`
-	Sector: Agriculture	`SAGRI`
-	Sector: Private households	`SHOUS`
-	Occupation: Manager	`OMNGR`
-	Occupation: Professional	`OPROF`
-	Occupation: Technician	`OTECH`
-	Occupation: Clerk	`OCLRK`
-	Occupation: Sales and services	`OSALE`
-	Occupation: Skilled agriculture	`OAGRI`
-	Occupation: Crafts and related trades	`OCRFT`
-	Occupation: Plant and machinery operators	`OMACH`
-	Occupation: Elementary occupations (probably excluding domestic workers)	`OELEM`
-	Occupation: Domestic workers	`ODWRK`
-	Occupation: Other	`OOTHR`
-	Status in employment: Employee	`TELEE`
-	Status in employment: Employer	`TEYER`
-	Status in employment: Own-account worker	`TOWNA`
-	Status in employment: Unpaid household member	`TUNPD`
-	Usual hours of work per week: <15	`WLT15`
-	Usual hours of work per week: 15-29	`W1529`
-	Usual hours of work per week: 30-39	`W3039`
-	Usual hours of work per week: 40-45	`W4045`
-	Usual hours of work per week: >45	`WGT45`
-	Education: No schooling	`ENONE`
-	Education: Less than primary completed	`ELTPS`
-	Education: Primary completed	`EPRIM`
-	Education: Secondary not completed	`ESNOT`
-	Education: Secondary completed	`ESECD`
-	Education: Tertiary	`ETERT`
-	Education: Other	`EOTHR`
-	Educational attendance: Attending educational institution	`GATTD`
-	Educational attendance: Not attending educational institution	`GANOT`
-	Marital status: Married	`MMARR`
-	Marital status: Living together like husband and wife	`MLIVE`
-	Marital status: Widow(er)	`MWIDW`
-	Marital status: Divorced or separated	`MSEPT`
-	Marital status: Never married	`MNEVR`

## AREA (Province/Metro)

The province codes end with "P".

-	South Africa	`SA`
-	Western Cape	`WP`
-	Western Cape: Non metro	`WN`
-	Western Cape: City of Cape Town	`WC`
-	Eastern Cape	`EP`
-	Eastern Cape: Non metro	`EN`
-	Eastern Cape: Buffalo City	`EB`
-	Eastern Cape: Nelson Mandela Bay	`EG`
-	Northern Cape	`NP`
-	Free State	`FP`
-	Free State: Non metro	`FN`
-	Free State: Mangaung	`FM`
-	KwaZulu Natal	`KP`
-	KwaZulu Natal: Non metro	`KN`
-	KwaZulu Natal: eThekwini	`KD`
-	North West	`TP`<br/>
    <font size="2">"T" for "Tswana"</font>
-	Gauteng	`GP`
-	Gauteng: Non metro	`GN`
-	Gauteng: Ekurhuleni	`GE`
-	Gauteng: Johannesburg	`GJ`
-	Gauteng: Tshwane	`GT`
-	Mpumalanga	`MP`
-	Limpopo	`LP`

## SEX

-	Any	`A`
-	Male	`M`
-	Female	`F`

