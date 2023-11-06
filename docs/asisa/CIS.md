# Association for Savings and Investment South Africa (ASISA): Collective Investment Schemes (CIS)

The Association for Savings and Investment South Africa (ASISA) reports on Collective Investment Schemes (CIS), at https://www.asisa.org.za/statistics/collective-investments-schemes/ . Collective Investment Schemes invest in shares, bonds and listed property and other listed and unlisted investments — known collectively as securities. We engineer the Excel files that they provide into tidy time-series data, available through EconData for automation.

## Hedge Funds

ID: `CIS_HEDGE`


## Local Holdings

ID: `LOCAL_HOLDINGS`

This data flow provides numbers on asset class holdings _within_ each investment fund and investment sector in South Africa, and aggregated asset holdings for _entire_ funds and sectors, over time. The semi-structured [holdings Excel files](https://www.asisa.org.za/statistics/collective-investments-schemes/local-fund-statistics/) stretch from the present quarter back to 2000, although we have only transformed the data back to 2006Q3 so far. There are about 5.2 million rows in our structured long data table (concepts multiplied by time).

The original Excel files have the following sections:
1.  Aggregate concepts by sector (all double-counting removed)
2.  Aggregated asset class holdings for subsectors
3.  Asset class holdings within individual funds, grouped into subsector sheets
4.  Fund-of-funds unit trust weightings

### Dimensions

1.  Asset line item<br/>
    Four-character code; details below.
2.  Fund<br/>
    Six-character code, mostly using standard ASISA fund codes, or an aggregate code of ours.
3.  Sector<br/>
    Four-character code, following ASISA convention. This describes the geographical exposure and asset class.

### Aggregate Concepts by Sector

#### Mnemonic

1.  Total Assets `TTTT`
2.  Sales `SSTT`
3.  Repurchases `RSTT`
4.  Net Inflow `ISTT` <br/>
    Note: redundant, as this equals sales minus repurchases.
5.  Number of Accounts `NSTC`
6.  Average balance per account `BSVV`
7.  Number of Funds `NSTF`
8.  Number of CIS Managers `NSTM`

#### Fund Code: `TTTTTT`

Periods 2013Q2 and earlier feature a series with double-counting (`TTTTDC`), and the main series with double-counting removed (`TTTTTT`) only goes back to 2009Q4. A CIS History (with double-counting, `TTTTDC`) is provided only for the total sector `TTTT` (listed below) from 2013Q1 back to **1966**.

#### Sectors

We use the following terminology to differentiate amongst the hierarchies:
1.  **Total** (`TTTT`)
2.  **Sector** (ending in `TTT`)
3.  **Major sub-sector** (ending in `TT`, including `DIMM` but excluding `DXTT`)
4.  **Sub-sector** (ASISA codes; no `T` in the code, including `DIMM`)

##### Sector Codes

0.  Total `TTTT`
1.  South African Funds `DTTT`
    1.  Equity `DETT`
        1.  General funds `DEGN`
        2.  Growth funds `DEGH` (2012Q4 and earlier)
        3.  Value funds `DEVL` (2012Q4 and earlier)
        4.  Large Cap funds `DELC`
        5.  Mid- & Small-Cap funds `DESM`
        6.  Unclassified funds `DEVS`
        7.  Resources funds `DERB`
        8.  Industrial funds `DEIN`
        9.  Financial funds `DEFN`
    2.  Multi Asset `DATT`
        1.  Unclassified funds `DATD`<br/><font size = "2">Named "Targeted Absolute and Real Return funds" in 2012Q4 and earlier.</font>
        2.  Low Equity funds `DAPL`
        3.  Medium Equity funds `DAPM`
        4.  Prudential High Equity  <font size = "2">Merges into `DAPV` after 2012Q4.</font>
        5.  High Equity funds `DAPV`<br/><font size = "2">Previously named "Prudential Variable Equity" in 2012Q4 and earlier.</font>
        6.  Flexible funds `DAFL`
        7.  Income funds `DAPI`
    3.  Real Estate `DRTT`
        1.  General funds `DRGN`
    4.  Interest Bearing `DITT`
        1.  Variable Term funds `DIBD`
        2.  Short Term funds `DIIN`
        3.  Varied Specialist `DIVS` (2012Q4 and earlier)
    5.  Total (excluding Money Market) `DXTT`
    6.  Money Market funds `DIMM`
2.  Worldwide Funds `WTTT`
    1.  Equity `WETT`
        1.  General funds `WEGN`
        2.  Unclassified funds `WEVS`
        3.  Technology funds `WETN` (discontinued after 2012Q4)
    2.  Multi Asset `WATT`
        1.  Flexible funds `WAFL`
        2.  Income funds `WAPI` (2013Q1 to 2016Q1)
    3.  Interest Bearing `WITT` (2012Q4 back to 2010Q2 inclusive)
        1.  Varied Specialist funds `WIVS`
3.  Regional Funds `RTTT`
    1.  Equity `RETT`
        1. General funds `REGN`
    2.  Multi Asset `RATT`
        1.  Flexible funds `RAFL`
        2.  Income funds `RAPI`
    3.  Real Estate `RRTT`
        1.  Real Estate funds `RRGN`
    4.  Interest Bearing `RITT`
        1.  Variable Term funds `RIBD`
        2.  Short Term funds `RIIN`
4.  Global Funds `FTTT`
    1.  Equity `FETT`
        1.  General funds `FEGN`
        2.  Unclassified funds `FEVS`
    2.  Multi Asset `GATT`
        1.  Flexible funds `FAFL`
        2.  Income funds `GAPI`
        3.  Low Equity funds `GAPL`
        4.  Medium Equity funds `GAPM`
        5.  High Equity funds `GAPH`
    3.  Real Estate `GRTT`
        1.  General funds `GRGN`
    4.  Interest Bearing `FITT`
        1.  Variable Term funds `FIBD`<br/><font size="2">Named "Bond funds" in 2012Q4 and earlier.</font>
        2.  Short Term funds `GIIN`
        3.  Varied Specialist `FIVS` (2012Q4 and earlier)
5.  Fund of Funds `OTTT`
6.  Retail Funds (sub total) `TTRT`
    1.  Retail Funds `TTRF`
    2.  Third Party Funds `TTR3`
7.  Institutional Funds (sub total) `TTIT`
    1.  Institutional Funds `TTIF`
    2.  Third Party Funds `TTI3`
    3.  Institutional Assets in Retail Funds `TTIR`

### Asset Class Holdings

The list of asset class categories is broadly structured for either equity funds, multi-asset funds or fund-of-funds. The second dimension should be either the total `TTTTTT` or a fund code. The third dimension is the same as the sector codes outlined above.

#### Equity

0.  Total assets `TTTT`
1.  _Domestic assets_ `TD--`
    1. Liquid assets `--LQ`
    2. Derivatives `--DR`
    3. Other assets `--OH`
2.  Foreign: other assets `TFOT`
3.  Total assets held in other CIS `CTTT`
    1.  Domestic Funds `CDTT`
    2.  Foreign Indirect Funds `CFIT`
    3.  Foreign Direct Funds `CFDT`
4.  Total domestic & foreign equities `ETTT`
    -   Domestic Equities `EDTT`
    -   Foreign Equities `EFTT`<br/>
    Total categories below should have a `TT` suffix.
    1.  Additional `EA--`
        1. Collective Investment Schemes `CI`
        2. Corporate Debt `CD`
        3. Deposit Notes `DN`
        4. Exchange Traded Funds `EF`
        5. Exchange Traded Notes `EN`
        6. Investment Products `IP`
        7. Kruger Rands `KR`
        8. Preference Shares `PS`
        9. Warrants `WR`
    2.  Basic Materials `EB--`
        1. Chemicals `CM`
        2. Forestry & Paper `FP`
        3. Industrial Metals `IM`
        4. Mining `MN`
    3.  Consumer Goods `EG--`
        1. Automobiles & Parts `AP`
        2. Beverages `BG`
        3. Food Producers `FP`
        4. Household Goods `HG`
        5. Leisure Goods `LG`
        6. Personal Goods `PG`
        7. Tobacco `TC`
    4.  Consumer Services `ES--`
        1. Food & Drug Retailers `FR`
        2. General Retailers `GR`
        3. Media `MD`
        4. Travel & Leisure `TL`
    5.  Financials `EM--` <small>(M for money)</small>
        1. Banks `BK`
        2. Equity Investment Instruments `EI`
        3. General Financial `GF`
        4. Life Insurance `LI`
        5. Nonequity Investment Instruments `NI`
        6. Nonlife Insurance `LN`
        7. Real Estate `RE`
    6.  Health Care `EH--`
        1. Health Care Equipment & Services `ES`
        2. Pharmaceuticals & Biotechnology `PB`
    7.  Industrials `EI--`
        1. Aerospace & Defense `AD`
        2. Construction & Materials `CM`
        3. Electronic & Electrical Equipment `EE`
        4. General Industrials `GI`
        5. Industrial Engineering `IE`
        6. Industrial Transportation `IT`
        7. Support Services `SS`
    8.  Oil & Gas `EP--` <small>(P for petrol)</small>
        1. Oil & Gas Producers `GP`
        2. Oil Equipment & Services `ES`
    9.  Telecommunications `EC--`
        1. Fixed Line Telecommunications `FL`
        2. Mobile Telecommunications `MB`
    10. Technology `EN--`
        1. Software & Computer Services `SC`
        2. Technology Hardware & Equipment  `HE`
    11. Utilities `EU--`
        1. Electricity `EL`
        2. Gas/Water & Multiutilities `GW`
    12. Specialist Securities `EZTT`
    13. Other Equities `EOTT`


#### Multi Assets

0.  Total assets `TTTT`
    1.  _Domestic assets_ `TD--`
        1.  Liquid assets `--LQ`
        2.  Derivatives `--DR`
        3.  Other assets `--OH`
    2.  _Foreign_ `TF--`
        1.  Cash `--CT`
        2.  Other assets `--OT`
1.  Total equities, excluding real estate  `ETTX`<br/>
    Not in interest-bearing funds.
    1.  Total domestic equities, excluding real estate `EDTX`
        1.  Additional `EATT`
        2.  Basic Materials `EBTT`
        3.  Consumer Goods `EGTT`
        4.  Consumer Services `ESTT`
        5.  Financials `EMTT`
        6.  Health Care `EHTT`
        7.  Industrials `EITT`
        8.  Oil & Gas `EPTT`
        9.  Telecommunications `ECTT`
        10. Technology `ENTT`
        11. Utilities `EUTT`
        12. Specialist Securities `EZTT`
        13. Other Equities `EOTT`
    2.  Total foreign equities `EFTT`
2.  Total Money Market instruments `MTTT`<br/>
    Not in equity or real-estate funds.
    1.  Total domestic money market `MDTT` Below: `MD--`
        1.  Cash on Call `CC`
        2.  Corporate debt - convertible `DC`
        3.  Corporate debt - non-convertible `DN`
        4.  Derivatives `DR`
        5.  Financial institutions `MI`
        6.  Government issued paper `GP`
        7.  Other listed Money Market instruments `LI`
        8.  Other unlisted Money Market instruments `UI`
        9.  Public entity issued paper `PP`
    2.  Total foreign money market `MFTT` Below: `MF--`
        1.  Foreign Bonds `IB`
        2.  Foreign Cash `IC`
        3.  Foreign Other `IO`
    3.  Capital & Money Market Maturity Spread `MCTT` Below: `MC--`
        1.  Cash `CH`
        2.  0-3 Months `3M`
        3.  3-6 Months `6M`
        4.  6-12 Months `1Y`
        5.  1-3 Years `3Y`
        6.  3-7 Years `7Y`
        7.  7-12 Years `DY`
        8.  &gt;12 Years `GY`
3.  Total Real Estate `RTTT` <br/>
    Not in interest-bearing funds.
    1.  Non-listed Real Estate `RNTT`
    2.  Listed Real Estate `RLTT`
4.  Total assets held in other CIS `CTTT`
    1.  Domestic Funds `CDTT`
    2.  Foreign Indirect Funds `CFIT`
    3.  Foreign Direct Funds `CFDT`
5.  Total other assets `OTTT`

Interest-bearing funds exclude 1. equity and 3. real estate from the categories listed above. Equity funds exclude Money Market, from the categories listed above.


#### Fund-of-Funds

##### Asset Class

0.  Total assets `TTTT`
1.  Unit Trusts (total) `UTTT`
    1.  Domestic Unit Trusts (total) `UDTT`
        1.  Unit Trust Weighting (value)<br>
            The last four characters of the fund code is the mnemonic code.
    2.  Foreign Schemes (total) `UFTT`
2.  Liquid Assets `LTTT`
3.  Derivatives `DTTT`
4.  Other Assets `OTTT`
6.  Total Foreign Assets `TFTT`
7.  Number of accounts `NSTC`
8.  Average balance per account `BSVV`

##### Fund Code

*   Total: `FUNDOF`
*   Individual FoFs: six-character fund code

##### Sector Code

Sector code of either the fund-of-funds or the underlying unit trust (the latter may be imprecise as it was fuzzy matched with an incomplete mapping history).


## Local Flows

ID: `LOCAL_FLOWS`



## Foreign Funds

ID: `CIS_FOREIGN`


