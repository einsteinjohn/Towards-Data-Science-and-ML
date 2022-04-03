#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Mar 21 14:18:37 2022

@author: johneinstein
"""
import pandas as pd
import numpy as np

# read in all our data
sf_permits = pd.read_csv("Building_Permits.csv")

# set seed for reproducibility
np.random.seed(0)

sf_permits.head()

#percentage of missing data
missing_values_count = sf_permits.isnull().sum()
total_cells = np.product(sf_permits.shape)
total_missing = missing_values_count.sum()

percent_missing = (total_missing/total_cells) *100
print("percent missing = " + str(percent_missing) +"%")

#these are the columns with missing data. taking a look at them to figure out why they have missing values
#street number missing most likely coz it does not exit whilst zipcode missing coz it wasn't recorded
sf_permits.loc[:,['Street Number Suffix','Zipcode']]

#Method 1: Dropping all columns with missing values

sf_permits_with_na_dropped = sf_permits.dropna(axis=1)
#number of columns left in df
dropped_columns = sf_permits.shape[1]-sf_permits_with_na_dropped.shape[1]

#Method 2: Imputation by replacing nan with the one that comes directly after it and then replacing any remaining NaN's with 0
# replace all NA's the value that comes directly after it in the same column, 
# then replace all the remaining na's with 0
sf_permits_with_na_imputed=sf_permits.fillna(method='bfill', axis=0).fillna(0)

