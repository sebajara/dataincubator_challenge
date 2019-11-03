# https://github.com/sebajara/dataincubator_challenge/tree/master/project

import pandas as pd
import numpy as np
from scipy import stats
import matplotlib.pyplot as plt
import datetime as dt
import matplotlib.patches as mpatches
import matplotlib.lines as mlines

# Read and preprocess csv file
df = pd.read_csv('project/data/temp_datalab_records_linkedin_company.csv',
                 dtype={'dataset_id': 'int64', 'followers_count': 'int64',
                        'employees_on_platform': 'int64'},
                 usecols=[0, 1, 2, 3, 4, 6])
df['as_of_date'] = pd.to_datetime(df['as_of_date'])
df['industry'] = df['industry'].fillna('Unknown')

# Group data by company_name 
group = df.groupby('company_name')
company_names = np.array(list(group.groups.keys()))
industry_names = df['industry'].unique()
# Save into a new data frame with summarising values
dfcp = pd.DataFrame({'company_name': company_names})
dfcp['industry_name'] = ''
dfcp['industryID'] = 0
dfcp['first_date'] = ''
dfcp['first_employees_on_platform'] = 0
dfcp['first_followers_count'] = 0
dfcp['last_date'] = ''
dfcp['last_employees_on_platform'] = 0
dfcp['last_followers_count'] = 0
dfcp['slope1'] = 0
dfcp['r_value1'] = 0
dfcp['slope2'] = 0
dfcp['r_value2'] = 0
# Populate dfcp dataframe
for c in range(0, len(company_names)):
    slice = group.get_group(company_names[c])
    # industry name and ID
    dfcp.loc[c, 'industry_name'] = slice['industry'].iloc[0]
    if(isinstance(dfcp.loc[c, 'industry_name'], str)):
        dfcp.loc[c, 'industryID'] = np.where(industry_names == dfcp.loc[c, 'industry_name'])[0][0]
    else:
        dfcp.loc[c, 'industryID'] = dfcp.loc[c, 'industry_name']
    # first date on record
    first_idx = slice['as_of_date'].idxmin()
    dfcp.loc[c, 'first_date'] = slice['as_of_date'].loc[first_idx]
    # number of employees_on_platform in first date
    dfcp.loc[c, 'first_employees_on_platform'] = slice['employees_on_platform'].loc[first_idx]
    # number of followers_count in first date
    dfcp.loc[c, 'first_followers_count'] = slice['followers_count'].loc[first_idx]
    # last date on record
    last_idx = slice['as_of_date'].idxmax()
    dfcp.loc[c, 'last_date'] = slice['as_of_date'].loc[last_idx]
    # number of employees_on_platform in last date
    dfcp.loc[c, 'last_employees_on_platform'] = slice['employees_on_platform'].loc[last_idx]
    # number of followers_count in last date
    dfcp.loc[c, 'last_followers_count'] = slice['followers_count'].loc[last_idx]
    if(slice['as_of_date'].count()>3):
        # linear fit datetime.toordinal v/s followers_count
        tx = slice['as_of_date'].map(dt.datetime.toordinal).values/30
        fy = slice['followers_count'].values
        slope, intercept, r_value, p_value, std_err = stats.linregress(tx,fy)
        dfcp.loc[c, 'slope1'] = slope
        dfcp.loc[c, 'r_value1'] = r_value
        # linear fit of datetime.toordinal v/s relative followers_count
        fy2 = fy[fy>0]
        tx2 = tx[fy>0]
        if(len(tx2)>3):
            ry = np.divide(fy2[1:],fy2[:-1])
            slope, intercept, r_value, p_value, std_err = stats.linregress(tx2[1:],ry)
            dfcp.loc[c, 'slope2'] = slope
            dfcp.loc[c, 'r_value2'] = r_value
        else:
            dfcp.loc[c, 'slope2'] = np.nan
            dfcp.loc[c, 'r_value2'] = np.nan
    else:
        dfcp.loc[c, 'slope1'] = np.nan
        dfcp.loc[c, 'r_value1'] = np.nan
        dfcp.loc[c, 'slope2'] = np.nan
        dfcp.loc[c, 'r_value2'] = np.nan
del df

# Group dfcp data by industry
group = dfcp.groupby('industryID')
# Select the top industries by number of companies

nindustries = 141
bigIndustries = dfcp.groupby('industryID')['industryID'].count().nlargest(nindustries).index.values
labels = industry_names[bigIndustries]
labels[4] = 'IT & Services'
topdf = pd.DataFrame()
for i in range(0, len(bigIndustries)):
    data = group.get_group(bigIndustries[i]).dropna()
    if(data.shape[0]>50):
        data.insert(data.shape[1],'z-score1',stats.zscore(data['slope1'].values))
        data.insert(data.shape[1],'z-score2',stats.zscore(data['slope2'].values))
        data['industry_total'] = data.shape[0]
        topdf = topdf.append(data)
topdf.to_csv("summary.csv",sep='\t')

# Compare z-score of relative-followers-rate and followers-rate
nindustries = 13
bigIndustries = dfcp.groupby('industryID')['industryID'].count().nlargest(nindustries).index.values
labels = industry_names[bigIndustries]
labels[4] = 'IT & Services'
cut = 0.5
fig = plt.figure()
ax  = fig.add_subplot(111)
handles = list()
for i in range(0, len(bigIndustries)):
    data = group.get_group(bigIndustries[i]).loc[:,['slope1','slope2']].dropna()
    y = stats.zscore(data['slope1'].values)
    x = stats.zscore(data['slope2'].values)
    if(((x>cut)&(y>cut)).sum()>0):
        plt.scatter(x[(x>cut)&(y>cut)], y[(x>cut)&(y>cut)],
                    facecolors='none', s=60,edgecolors='black',linestyle='--')
    h = plt.scatter(x,y,alpha=0.5)
    handles.append(h)
plt.xlabel('Followers fractional change-rate z-score')
plt.xlim(-2,2)
plt.ylabel('Followers change-rate z-score')
plt.legend(handles,labels,loc = 'upper left')
plt.tight_layout()
plt.title('6 companies stand out in Linkedin by their followers-growth')
#plt.show()
plt.grid(linestyle='--', linewidth=0.5,alpha=0.5)
fig.savefig('FIG1.png',dpi=600)

good = topdf[(topdf['z-score1']>cut) & (topdf['z-score2']>cut)]
good.to_csv("FIG1_Circled.csv",sep='\t')


nindustries = 13
bigIndustries = dfcp.groupby('industryID')['industryID'].count().nlargest(nindustries).index.values
labels = industry_names[bigIndustries]
labels[4] = 'IT & Services'
cut = 0.5
fig = plt.figure()
ax  = fig.add_subplot(111)
handles = list()
for i in range(0, len(bigIndustries)):
    data = group.get_group(bigIndustries[i]).loc[:,['slope1','last_followers_count']].dropna()
    x = data['last_followers_count']
    y = data['slope1']
    h = plt.scatter(x[(x>0)&(y>0)],y[(x>0)&(y>0)],alpha=0.5)
    handles.append(h)
plt.xlabel('Most recent followers count')
plt.yscale('log')
plt.xscale('log')
plt.ylabel('Followers change-rate [counts/month]')
box = ax.get_position()
ax.set_position([box.x0, box.y0, box.width * 0.7, box.height])
plt.legend(handles,labels,loc='center left', bbox_to_anchor=(1, 0.5))
plt.grid(linestyle='--', linewidth=0.5,alpha=0.5)
plt.title('Followers change-rate is proportional to followers size pool')
#plt.show()
fig.savefig('FIG2.png',dpi=600)
