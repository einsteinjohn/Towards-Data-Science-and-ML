#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Apr  1 17:57:56 2022

@author: johneinstein
"""


import numpy as np
import pandas as pd
from sklearn.model_selection import cross_val_score
import xgboost
from xgboost import XGBRegressor


def score_dataset(X, y, model=XGBRegressor()):
    # Label encoding for categoricals
    for colname in X.select_dtypes(["category", "object"]):
        X[colname], _ = X[colname].factorize()
    # Metric for Housing competition is RMSLE (Root Mean Squared Log Error)
    score = cross_val_score(
        model, X, y, cv=5, scoring="neg_mean_squared_log_error",
    )
    score = -1 * score.mean()
    score = np.sqrt(score)
    return score


# Prepare data
df = pd.read_csv("ames.csv")
X = df.copy()
y = X.pop("SalePrice")

# Create the following features:

# LivLotRatio: the ratio of GrLivArea to LotArea
# Spaciousness: the sum of FirstFlrSF and SecondFlrSF divided by TotRmsAbvGrd
# TotalOutsideSF: the sum of WoodDeckSF, OpenPorchSF, EnclosedPorch, Threeseasonporch, and ScreenPorch

X_1 = pd.DataFrame()  # dataframe to hold new features
X_1["LivLotRatio"] = X.GrLivArea/X.LotArea
X_1["Spaciousness"] = (X.FirstFlrSF + X.SecondFlrSF) / X.TotRmsAbvGrd
X_1["TotalOutsideSF"] = X.WoodDeckSF + X.OpenPorchSF + X.EnclosedPorch + X.Threeseasonporch + X.ScreenPorch
​
#We discovered an interaction between BldgType and GrLivArea in Exercise 2. Now create their interaction features.
# One-hot encode BldgType. Use `prefix="Bldg"` in `get_dummies`
X_2 = pd.get_dummies(df.BldgType, prefix="Bldg")
#Multiply
X_2 = X_2.mul(df.GrLivArea, axis=0)

#count method
# Let's try creating a feature that describes how many kinds of outdoor areas a dwelling has. Create a feature PorchTypes that counts how many of the following are greater than 0.0:

# WoodDeckSF
# OpenPorchSF
# EnclosedPorch
# Threeseasonporch
# ScreenPorch

X_3 = pd.DataFrame()
OutdoorFeatures=['WoodDeckSF','OpenPorchSF','EnclosedPorch','Threeseasonporch','ScreenPorch']
X_3["PorchTypes"] = df[OutdoorFeatures].gt(0).sum(axis=1)

#MSSubClass describes the type of a dwelling:
df.MSSubClass.unique()

#Now split so that we only have the first part in a new df.
X_4 = pd.DataFrame()
X_4['MSClass']=df.MSSubClass.str.split("_",expand=True,n=1)[0]

#  Create a feature MedNhbdArea that describes the median of GrLivArea grouped on Neighborhood.
X_5 = pd.DataFrame()

X_5["MedNhbdArea"] = df.groupby('Neighborhood')['GrLivArea'].transform('median')




