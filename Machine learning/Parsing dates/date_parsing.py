#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Mar 21 16:33:41 2022

@author: johneinstein
"""
import pandas as pd
import numpy as np
import seaborn as sns
import datetime

# read in our data
earthquakes = pd.read_csv("database.csv")

# set seed for reproducibility
np.random.seed(0)

#checking problem column on inspection
earthquakes[3378:3383]

#get an idea of how widespread this issue is by checking the length of each entry in the "Date" column. there are 2 more of these
date_lengths = earthquakes.Date.str.len()
date_lengths.value_counts()

#Finding where these values are located
indices = np.where([date_lengths == 24])[1]
print('Indices with corrupted data:', indices)
earthquakes.loc[indices]

#It will be easier to just change these 3 inputs to the correct ones
earthquakes.loc[3378, "Date"] = "02/23/1975"
earthquakes.loc[7512, "Date"] = "04/28/1985"
earthquakes.loc[20650, "Date"] = "03/13/2011"
earthquakes['date_parsed'] = pd.to_datetime(earthquakes['Date'], format="%m/%d/%Y")

#cool call. calling the day of the month from that new column date_parsed
day_of_month_earthquakes = earthquakes['date_parsed'].dt.day

#another cool thing is plotting it and seeing the distribution
# remove na's
day_of_month_earthquakes = day_of_month_earthquakes.dropna()

# plot the day of the month
sns.distplot(day_of_month_earthquakes, kde=False, bins=31)




