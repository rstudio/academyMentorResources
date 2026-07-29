import pandas as pd
df = pd.DataFrame({
    'category': ['A', 'A', 'B', 'B'],
    'val': [10, 20, 100, 300]
})

def add_percentage(group):
    group['pct_of_group'] = group['val'] / group['val'].sum() * 100
    return group

result_1 = df.groupby('category', group_keys=False).apply(add_percentage)  # group_keys=False is default

result_2 = df.groupby('category', group_keys=True).apply(add_percentage)
result_2 = result_2.rename_axis(index={'category': 'category_2'})
result_2 = result_2.reset_index()

result_3 = df.groupby('category').apply(lambda group: group['val'].sum())
result_3.index
result_3.reset_index()

result_4 = df.groupby('category').agg({'val':sum})
result_4.reset_index()

result_5 = df.copy()  # here we need .copy() because this is a standard Python operation and without .copy() it would reference the same object in memory
result_5['val_sum_per_group'] = df.groupby('category')['val'].transform('sum')
result_5['pct_of_group'] = result_5['val'] / result_5['val_sum_per_group'] * 100

result_6 = df['val'] / df.groupby('category')['val'].transform('sum') * 100

def add_percentage_transform(series):
  return series / series.sum() * 100  #series.sum() is a single value for each group, whereas series loops through each field of a group
  
result_7 = df.copy()
result_7['prect_of_group_from_transform'] = df.groupby('category')['val'].transform(add_percentage_transform)
