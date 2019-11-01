# Code also available at https://github.com/sebajara/dataincubator_challenge/tree/master/section1

import pandas as pd
import numpy as np
from scipy.stats import zscore
from scipy import stats
import math

# Read csv file
df = pd.read_csv('section1/data/Arrest_Data_from_2010_to_Present.csv')

# Convert to datetime and remove 2019
df['Arrest Date'] = pd.to_datetime(df['Arrest Date'])
df = df[df['Arrest Date'] < '01-01-2019']

# Save 2018 data only
df2018 = df[df['Arrest Date'] > '01-01-2018']

# ============== Question 1:
ans1 = df2018.shape[0]
print ("A1: " + str(ans1))
# >> A1: 104040

# ============== Question 2:
ans2 = df2018.groupby(['Area ID'])['Report ID'].count()
print ("A2: " + str(ans2[1]))
# >> A2: 10929

# ============== Question 3:
df2018 = df[df['Arrest Date'] > '01-01-2018']
dfslice3 = df2018[(df2018['Charge Group Description'] == 'Vehicle Theft')
                  | (df2018['Charge Group Description'] == 'Robbery')
                  | (df2018['Charge Group Description'] == 'Burglary')
                  | (df2018['Charge Group Description'] == 'Receive Stolen Property')]
ans3 = dfslice3['Age'].quantile(0.95)
print ("A3: " + str(ans3))
# >> A3: 52.0000000000
del dfslice3

# ============== Question 4:
group4 = df2018[(df2018['Charge Group Description'] != 'Pre-Delinquency') &
                (df2018['Charge Group Description'] != 'Non-Criminal Detention') &
                (df2018['Charge Group Description'].notna())].groupby('Charge Group Code')['Age'].mean()
group4 = group4.to_frame()
group4.insert(1, 'zscore', zscore(group4.values))
ans4 = np.abs(group4['zscore'].values).max()
# ID: 18.0, Drunkeness, Mean age: 43.798780
print ("A4: " + str(ans4))
# >> A4: 2.174336627804518
del group4

# ============== Question 5:
slice5 = df[['Arrest Date']]
slice5.insert(1, 'Year', slice5['Arrest Date'].dt.year)
group_by_year = slice5.groupby(['Year'])['Year'].count()
x = group_by_year.index.values
y = group_by_year.values
slope, intercept, r_value, p_value, std_err = stats.linregress(x, y)
ans5 = np.round(slope*2019 + intercept)
print ("A5: " + str(ans5))
# >> A5: 95230
del slice5

# ============== Question 6:
df2018 = df[df['Arrest Date'] > '01-01-2018']
target = [34.050536, -118.247861]
earth_radius = 6371  # in km
# recover latitude, longitude as a float array
df2018.insert(df2018.shape[1], 'Latitude', [float(s[1:-1].split(',')[0])
                                            for s in df2018['Location'].values])
# recover longitude
df2018.insert(df2018.shape[1], 'Longitude', [float(s[1:-1].split(',')[1])
                                             for s in df2018['Location'].values])

# doesn't matter if is latitude or longitude
slice6 = df2018[df2018['Longitude'] != 0]


def my_location_dist(x1, x2, R):
    """function to calculate distance bewteen two points (x1,x2). R is the Earth radius.
    Following equation from https://en.wikipedia.org/wiki/Geographical_distance#Spherical_Earth_projected_to_a_plane"""
    dlati = math.pi*(x1[0]-x2[0])/180  # in radians
    dlong = math.pi*(x1[1]-x2[1])/180  # in radians
    mlati = math.pi*(x1[0]+x2[0])/(2*180)  # in radians
    d = R*math.sqrt(dlati**2+(math.cos(mlati)*dlong)**2)
    return d


slice6_close = slice6[slice6.apply(lambda row: my_location_dist(
    [row['Latitude'], row['Longitude']], target, earth_radius), axis=1) <= 2]
ans6 = slice6_close.shape[0]
print ("A6: " + str(ans6))
# >> A6: 11436
del slice6
del slice6_close

# ============== Question 7:
slice7 = df2018[df2018['Address'].str.contains("PICO")]
slice7.insert(slice7.shape[1], 'Absolute latitude zscore',
              zscore(slice7['Latitude'].values))
slice7.insert(slice7.shape[1], 'Absolute longitude zscore',
              zscore(slice7['Longitude'].values))
slice7_sub = slice7[(slice7['Absolute latitude zscore'] <= 2)
                    & (slice7['Absolute longitude zscore'] <= 2)]
most_east = [slice7['Latitude'].values.mean(
), slice7['Longitude'].values.max()]
most_west = [slice7['Latitude'].values.mean(
), slice7['Longitude'].values.min()]
dist = my_location_dist(most_east, most_west, earth_radius)
# 36.6 Km as distance
ans7 = slice7_sub.shape[0]/dist
print ("A7: " + str(ans7))
# >> A7: 16.650914646737895
del slice7
del slice7_sub

# ============== Question 8:
slice8 = df[df['Charge Group Code'].notna() & (
    df['Charge Group Code'] != 99)].loc[:, ['Area ID', 'Charge Group Code']]
slice8['count'] = 1

# Frequency counts ('Charge Group Code' by 'Area ID')
table8_counts = pd.pivot_table(
    slice8, index='Charge Group Code', columns='Area ID', aggfunc=sum)

# Add total from all areas
table8_counts.insert(
    table8_counts.shape[1], 'Total', table8_counts.sum(axis=1))

# Frequencies
table8_freq = table8_counts.copy()
for i in range(0, 22):
    table8_freq.iloc[:, i] = table8_counts.iloc[:, i] / \
        table8_counts.iloc[:, i].sum()

# Frequencies relative to whole city
table8_rel = table8_freq.copy()
for i in range(0, 22):
    table8_rel.iloc[:, i] = table8_freq.iloc[:, i] / \
        table8_freq.iloc[:, 21]
# Remove the last column (Total)
table8_rel = table8_rel.drop(labels='Total', axis=1)

# final calculation
all_values = np.sort(np.concatenate(table8_rel.values))
ans8 = all_values[-5:].mean()
print ("A8: " + str(ans8))
# >> A8: 3.515076379865202
del slice8
del table8_counts
del table8_freq
del table8_rel
del all_values
