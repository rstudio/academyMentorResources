# I teach about f-strings here

name = 'Rose'
works_at = 'SRK' 
variable = 'acid potential'

print(f'{name} works at {works_at} and wants to investigate {variable}')

# showcase how you can use this in apply, making sure to point out the axis=1 argument that I _always_ forget
dat_geo['test'] = dat_geo.apply(lambda x: f"ID: {x['SRK_Sample_ID']}", axis=1)
dat_geo['test']

