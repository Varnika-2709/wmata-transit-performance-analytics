# WMATA Transit Performance Analytics

A relational data model and SQL analytics suite built on WMATA Metrobus Service Excellence
Report data (FY2019–FY2024), designed to measure how bus service performed through the
COVID-19 disruption and how well it recovered afterward.

## The questions

| # | Business question | Query |
|---|---|---|
| 1 | Which route riderships were hit hardest by COVID, and how far have they recovered? | [`01_post_covid_ridership_recovery.sql`](sql/01_post_covid_ridership_recovery.sql) |
| 2 | Which routes, weighted by total operating cost, still have low cost recovery? | [`02_cost_recovery_vs_operating_cost.sql`](sql/02_cost_recovery_vs_operating_cost.sql) |
| 3 | Which routes shift most in ridership and crowding between weekdays and weekends? | [`03_weekday_vs_weekend_performance.sql`](sql/03_weekday_vs_weekend_performance.sql) |
| 4 | Which lines show weak on-time performance or high crowding in lower-income areas? | [`04_service_equity_ontime_crowding.sql`](sql/04_service_equity_ontime_crowding.sql) |

## Selected findings

- **Route X3** collapsed from over 100k annual riders in 2019 to near zero in 2021, with
  negligible recovery by 2024 — a candidate for discontinuation review.
- **Route Z2**, the highest-volume route pre-pandemic (~180k), has recovered only to ~80k,
  still under 50% of its pre-pandemic level.
- The **U Street–Garfield** line carries the highest total operating cost *and* the largest
  share of unrecovered cost, making it the clearest financial drain in the system.
- **New Hampshire Avenue** and **Ballston–Farragut Square** gain the most weekend ridership
  while also showing higher Saturday crowding — capacity is under-provisioned there, while
  Takoma–Petworth runs near-empty weekend service.
- Several lines serving areas with **60–80% low-income riders** show on-time performance in
  the 62–70% range, pointing to a reliability gap where riders have the fewest alternatives.

## Data model

The design document covers business terms, entities and identifiers, cardinalities, the
relational schema with primary and foreign keys, and thirteen business rules mapped to
referential-integrity actions (cascade/restrict) on delete and update.

Core entities: `Line`, `Route`, `BusStops`, `ReportingPeriod`, `RouteSummaryStat`,
`LineSummaryStat`, `RoutePerformanceFact`, `LinePerformanceFact`.

## Repository contents

```
sql/     four analytical queries, one per business question
docs/    data_model_and_design.docx   entities, schema, business rules, integrity actions
         analysis_report.docx         findings and operational recommendations
         presentation.pptx            summary deck
```

## Data sources

- Metrobus Annual Line Performance Reports, FY2019–FY2024 (published as PDFs; extracted to
  CSV with a Python PDF scraper, with OCR used for the annual ridership figures, which were
  not machine-extractable)
- WMATA public API for current bus stops and routes

Route numbering and naming changed substantially between 2024 and 2025, so stop-level detail
is limited to the subset of routes that map cleanly across the renumbering.

The source data is not redistributed in this repository.

## Credits

This was a four-person team project by **Team MetroMind**: Jacob Lourie, Kunal Roy Chowdhury,
Varnika Bethireddy, and Vishesh Khare.

My contribution was the **SQL queries and the relational data model** — the entity design,
schema, keys, business rules and referential-integrity actions, and the four analytical
queries in `sql/`. The written report and the presentation were team deliverables.
