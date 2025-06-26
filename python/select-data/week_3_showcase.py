#this week, i want to show them a package I personally use to quickly clean up variables 
# requires a useful and timely introduction to the terminal

# ! Pip install pyjanitor 

import janitor 
dat_geo = pd.read_excel("data/srk_data_geochem.xlsx")
dat_geo.clean_names(remove_special=True, case_type = 'upper')
