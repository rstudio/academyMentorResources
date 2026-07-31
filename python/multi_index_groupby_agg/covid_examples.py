import pandas as pd

covid = pd.read_csv('data/covid.csv')

# the following just shows different outputs but is not altering the covid dataframe, otherwise we would need covid = covid.groupby()...
covid.groupby('state').agg({'cases': 'sum', 'deaths': 'sum'})
covid.groupby('state').agg({'cases': 'sum', 'deaths': 'sum'}).reset_index()
covid.groupby('state').agg({'cases': 'sum', 'deaths': 'sum'}).reset_index().nlargest(10, columns='cases')

# https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.agg.html

covid[['cases', 'deaths', 'tests']].agg(['sum', 'mean'])

# named aggregations
covid.groupby('state').agg(cases_mean=('cases', 'mean'), cases_median=('cases', 'median')).round(1)

# with dict
covid.groupby('state').agg({'cases': 'mean', 'tests': 'mean'}).round(1)

# the following produces multi index for column names
covid.groupby('state').agg({'cases': ['mean', 'median'], 'tests': 'mean'}).round(1)
covid.groupby('state').agg({'cases': ['mean', 'median'], 'tests': 'mean'}).round(1).columns

covid['date'] = pd.to_datetime(covid['date'])
covid['year'] = covid['date'].dt.year

# the following line creates a df with multi index for row index and columns
multi_agg = covid.groupby(['year', 'state']).agg({'cases': ['mean', 'median'], 'tests': 'mean'}).round(1)
multi_agg.index
# you can also pull multi index, for rows, into the dataframe as columns
multi_agg.reset_index()

# lets treat the multiindex for columns first
multi_agg.columns
multi_agg.columns.values
multi_agg.columns.values[0]
'_'.join(multi_agg.columns.values[0])
multi_agg.columns = [f"{col}_{func}" for col, func in multi_agg.columns]
# alternative but only works if all values in the index tuple are strings
# multi_agg.columns = ['_'.join(col) for year in multi_agg.columns.values]

multi_agg.index
multi_agg.index.values
multi_agg.index.values[0]
multi_agg.index = ['_'.join(ind) for ind in multi_agg.index.values]
multi_agg.index = [f"{year}_{state}" for year, state in multi_agg.index]
