This is a demo I did for a group of learners who work with data in databases regularly and who were mostly familiar with SQL.  Their company was transitioning from Oracle to Databricks.  I signed up for a trial account with Databricks and figured out how to get a demo SQL warehouse spun up, but doing all the authentication will be *much* simpler for the learners who will be using Posit Workbench.

Notes and caveats: 
- I showed `show_query()` as a way to help learners who are very familiar with SQL as a way of translating tidyverse code to SQL.
- Pros of SQLite is no authentication/server is needed. Downside of SQLite is it doesn't open anything in the connections pane like Databricks does.
- Second part is not reproducible without getting your own Databricks credentials (`DATABRICKS_HOST` and `DATABRICKS_TOKEN` env vars) and editing the `HTTPPath` argument to `dbConnect()`
- With Databricks connection, you get a nested catalog of tables, which I was unfamiliar with.  I might not be using `Id()` correctly.
