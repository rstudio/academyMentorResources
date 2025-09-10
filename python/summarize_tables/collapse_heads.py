#mentor led instruction for week 5 - groups 


# showcase how to use lambda in the agg functions again to get list vars (part of the tutorials, but tricky)
(dat_geo
  .groupby("Rock_Type")
  .agg({
    "Paste_pH" : (lambda x: np.percentile(x, 95)),
    "S_S_II" : (lambda x: statistics.quantiles(x)),
   # "S_S_VI" :  (lambda col: nlargest(col, 1)),
    "TIC_CaCO3_Equiv" : ["median"],
    "Organic_C" : ["median"]
    })
    .reset_index()
)




x = (dat_geo
  .groupby("Rock_Type")
  .agg({
    "Paste_pH" : ["median", "mean"],
    "S_S_II" : ["median"],
    "S_S_VI" : ["median"],
    "TIC_CaCO3_Equiv" : ["sum"],
    "Organic_C" : ["median"]
    })
    .reset_index()
)

#show that with [], columns create a multi index that isn't easily handled by `reset_index()`
x.columns

# a bit of a quick lesson in python list basics, a bit of a 'trust me this works'
"_".join(['Paste_pH', 'median'])

#show how this can be used along with map (another "trust me" moment) to clean up column names
x.columns = x.columns.map("_".join)
x.columns
