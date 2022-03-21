# -*- coding: utf-8 -*-
"""
Created on Tue Feb  8 15:09:45 2022

@author: einst
"""

c=[18,19]
#dropping suject 18 and 19 because they aren't found in x data
for i in c:
    angles.pop(i)
    center_pos.pop(i)

#dropping Subject, Sternum X, Sternum Y, Unnamed: 18, Unnamed:19.  Sternum x and y are the oringin
def X_input(original_x,angle):
    b=[]
    c=[]
    for char in original_x:
        a=char.drop(['Subject','SternumX','SternumY','Unnamed: 18', 'Unnamed: 19'],axis=1, inplace=True)
        b.append(a)
    for char in angle:
        d=char.drop(['Head Angle','Trunk Angle'],axis=0, inplace=True)
        c.append(d)
    return b,c
X_input(x,angles)

from sklearn.preprocessing import OneHotEncoder
def OH_encoding_data(X_data):
    b=[]
    for char in X_data:
        #One_Hot Encode X postures. Trying to use posture as a marker
        # Step 1: Get list of categorical variables
        s = (char.dtypes == 'object')
        object_cols = list(s[s].index)
        # Apply one-hot encoder to each column with categorical data
        OH_encoder = OneHotEncoder(handle_unknown='ignore', sparse=False)
        OH_cols_train = pd.DataFrame(OH_encoder.fit_transform(char[object_cols]))
        
        # One-hot encoding removed index; put it back
        OH_cols_train.index = char.index
        
        # Remove categorical columns (will replace with one-hot encoding)
        num_X_train = char.drop(object_cols, axis=1)
        
        # Add one-hot encoded columns to numerical features
        OH_X_train = pd.concat([num_X_train, OH_cols_train], axis=1)
        b.append(OH_X_train)
    return b
new_x=OH_encoding_data(x)

#Split data into train and test
from sklearn.model_selection import train_test_split
def split_data(x,y,z):
    X_train=[]
    X_valid=[]
    Y_train=[]
    Y_valid=[]
    Z_train=[]
    Z_valid=[]
    for i in range(len(x)):
        x_train, x_valid = train_test_split(x[i], train_size=0.8, test_size=0.2,random_state=0)
        y_train, y_valid = train_test_split(y[i].swapaxes('index','columns'), train_size=0.8, test_size=0.2,random_state=0)
        z_train, z_valid = train_test_split(z[i], train_size=0.8, test_size=0.2,random_state=0)
        X_train.append(x_train)
        X_valid.append(x_valid)
        Y_train.append(y_train)
        Y_valid.append(y_valid)
        Z_train.append(z_train)
        Z_valid.append(z_valid)
    return X_train, X_valid,Y_train,Y_valid,Z_train,Z_valid
X_train,X_valid,angle_train,angle_valid,cenpos_train,cenpos_valid=split_data(new_x,angles,center_pos)

#Designing MARS model
from numpy import mean
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import RepeatedKFold
from pyearth import Earth
from sklearn.metrics import mean_absolute_error

model=Earth()
def predicting_model(x_train,x_valid,y_train):
    C1angle_predictions=[]
    C2angle_predictions=[]
    C3angle_predictions=[]
    C4angle_predictions=[]
    C5angle_predictions=[]
    C6angle_predictions=[]
    C7angle_predictions=[]
    for i in range(len(x_train)):
        model.fit(x_train[i],(y_train[i])['C1 Angle'])
        predsC1=model.predict(x_valid[i])
        C1angle_predictions.append(predsC1)
    return C1angle_predictions
C1angle_predictions=predicting_model(X_train,X_valid,angle_train)



































