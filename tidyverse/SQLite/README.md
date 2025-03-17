## SQL to Pandas dataframe
To demonstrate how easy it is to integrate with a database system, you can simply use SQLite lib, drop a SQLite db file into a local directory and run SQL commands to it. Use pandas directly or convert the result to a pandas dataframe. Many data scientists use SQL daily and they want to see how to access a db with Python or R.

The example db is taken from [https://github.com/dtaivpp/car_company_database/tree/master](https://github.com/dtaivpp/car_company_database/tree/master). You find the ER diagram in the repo link above.
There is an equivalent example for Python SQLite in the python folder.

To install RSQLite: 
`install.packages("RSQLite")`
If there is a conflict in istalling the latest version in the campsite, then try an older verion:
`install.packages("https://cran.r-project.org/src/contrib/Archive/RSQLite/RSQLite_2.3.4.tar.gz", repos=NULL, type="source")`
