# -*- coding: utf-8 -*-
"""
Created on Fri Feb 25 08:56:45 2022

@author: einst
"""
import tensorflow as tf
import numpy as np
import pandas as pd
import os
import IPython
import IPython.display
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns


charlie_df.drop(["SternumX","SternumY","Unnamed: 18","Unnamed: 19"], axis=1 ,inplace=True)
num_features=charlie_df.shape[1]

#train/val split
n=len(charlie_df)
train_df=charlie_df[0:int(n*0.75)]
val_df=charlie_df[int(n*0.75):]

#Normalizing data
def Normalizing_data(train_df,val_df):
    train_mean = train_df.mean()
    train_std = train_df.std()
    
    train_df = (train_df-train_mean)/train_std
    val_df = (val_df - train_mean) / train_std  
    return train_df,val_df 

train_df,val_df=Normalizing_data(train_df,val_df)

#Data windowing to be able to create train/val
#and good sync when inputted into RNN

class WindowGenerator():
  def __init__(self, input_width, label_width, shift,
               train_df=train_df, val_df=val_df,
               label_columns=None):
    # Store the raw data.
    self.train_df = train_df
    self.val_df = val_df

    # Work out the label column indices.
    self.label_columns = label_columns
    if label_columns is not None:
      self.label_columns_indices = {name: i for i, name in
                                    enumerate(label_columns)}
    self.column_indices = {name: i for i, name in
                           enumerate(train_df.columns)}

    # Work out the window parameters.
    self.input_width = input_width
    self.label_width = label_width
    self.shift = shift

    self.total_window_size = input_width + shift

    self.input_slice = slice(0, input_width)
    self.input_indices = np.arange(self.total_window_size)[self.input_slice]

    self.label_start = self.total_window_size - self.label_width
    self.labels_slice = slice(self.label_start, None)
    self.label_indices = np.arange(self.total_window_size)[self.labels_slice]

  def __repr__(self):
    return '\n'.join([
        f'Total window size: {self.total_window_size}',
        f'Input indices: {self.input_indices}',
        f'Label indices: {self.label_indices}',
        f'Label column name(s): {self.label_columns}'])

#Example of how window generator works
w2 = WindowGenerator(input_width=5, label_width=5, shift=5,
                     label_columns=['C1X','C1Y','C1A',
                                    'C2X','C2Y','C2A',
                                    'C3X','C3Y','C3A',
                                    'C4X','C4Y','C4A',
                                    'C5X','C5Y','C5A',
                                    'C6X','C6Y','C6A',
                                    'C7X','C7Y','C7A'])
w2

#splitting data into labels and features

def split_window(self, features):
  inputs = features[:, self.input_slice, 21:]
  labels = features[:, self.labels_slice, :21]
  if self.label_columns is not None:
    labels = tf.stack(
        [labels[:, :, self.column_indices[name]] for name in self.label_columns],
        axis=-1)

  # Slicing doesn't preserve static shape information, so set the shapes
  # manually. This way the `tf.data.Datasets` are easier to inspect.
  inputs.set_shape([None, self.input_width, None])
  labels.set_shape([None, self.label_width, None])

  return inputs, labels

WindowGenerator.split_window = split_window

### Not sure yet
# this is just an example on how it stacks
#Stack three slices, the length of the total window.
example_window = tf.stack([np.array(train_df[:w2.total_window_size]),
                           np.array(train_df[10:10+w2.total_window_size]),
                           np.array(train_df[20:20+w2.total_window_size])])

example_inputs, example_labels = w2.split_window(example_window)

print('All shapes are: (batch, time, features)')
print(f'Window shape: {example_window.shape}')
print(f'Inputs shape: {example_inputs.shape}')
print(f'Labels shape: {example_labels.shape}')

w2.example = example_inputs, example_labels


#Plots
def plot(self, model=None, plot_col=None , max_subplots=3):
  inputs, labels = self.example
  plt.figure(figsize=(12, 8))
  plot_col_index = self.column_indices[plot_col]
  max_n = min(max_subplots, len(inputs))
  for n in range(max_n):
    plt.subplot(max_n, 1, n+1)
    plt.ylabel(f'{plot_col} [normed]')
    plt.plot(self.input_indices, inputs[n, :, plot_col_index],
             label='Inputs', marker='.', zorder=-10)

    if self.label_columns:
      label_col_index = self.label_columns_indices.get(plot_col, None)
    else:
      label_col_index = plot_col_index

    if label_col_index is None:
      continue

    plt.scatter(self.label_indices, labels[n, :, label_col_index],
                edgecolors='k', label='Labels', c='#2ca02c', s=64)
    if model is not None:
      predictions = model(inputs)
      plt.scatter(self.label_indices, predictions[n, :, label_col_index],
                  marker='X', edgecolors='k', label='Predictions',
                  c='#ff7f0e', s=64)

    if n == 0:
      plt.legend()

  plt.xlabel('Different positions (Neu,...)')

WindowGenerator.plot = plot
w2.plot(plot_col='C1X')


#Finally, this make_dataset method will take a time series DataFrame and convert it to a 
#tf.data.Dataset of (input_window, label_window) pairs using 
#the tf.keras.utils.timeseries_dataset_from_array function:


def make_dataset(self, data):
  data = np.array(data, dtype=np.float32)
  ds = tf.keras.utils.timeseries_dataset_from_array(
      data=data,
      targets=None,
      sequence_length=self.total_window_size,
      sequence_stride=1,
      shuffle=True,
      batch_size=32,)

  ds = ds.map(self.split_window)

  return ds

WindowGenerator.make_dataset = make_dataset

######
@property
def train(self):
  return self.make_dataset(self.train_df)

@property
def val(self):
  return self.make_dataset(self.val_df)

@property
def example(self):
  """Get and cache an example batch of `inputs, labels` for plotting."""
  result = getattr(self, '_example', None)
  if result is None:
    # No example batch was found, so get one from the `.train` dataset
    result = next(iter(self.train))
    # And cache it for next time
    self._example = result
  return result

WindowGenerator.train = train
WindowGenerator.val = val
WindowGenerator.example = example

w2.train.element_spec
#Example of how the data will be inputed into the model
for example_inputs, example_labels in w2.train.take(1):
  print(f'Inputs shape (batch, time, features): {example_inputs.shape}')
  print(f'Labels shape (batch, time, features): {example_labels.shape}')
  
#train procedure, defining our train function and our error 
MAX_EPOCHS = 50
learning_rate = 1e-3

def compile_and_fit(model, window, patience=5):
  early_stopping = tf.keras.callbacks.EarlyStopping(monitor='val_loss',
                                                     patience=patience,
                                                     mode='min')

  model.compile(loss=tf.losses.MeanSquaredError(),
                optimizer=tf.optimizers.Adam(learning_rate),
                metrics=[tf.metrics.MeanAbsoluteError()])

  history = model.fit(window.train, epochs=MAX_EPOCHS,
                      validation_data=window.val,
                      callbacks=[early_stopping]
                      )
  return history,predictions

#defining our model (LSTM)
lstm_model = tf.keras.models.Sequential([
    # Shape [batch, time, features] => [batch, time, lstm_units]
    tf.keras.layers.LSTM(32, return_sequences=True,recurrent_initializer='glorot_uniform',recurrent_activation='relu'),
    tf.keras.layers.LSTM(32, return_sequences=True,recurrent_initializer='glorot_uniform',recurrent_activation='relu'),

    # Shape => [batch, time, features]
    tf.keras.layers.Dense(units=21)
])
#next 2 codes are still working on the examples we mentioned above
print('Input shape:', w2.example[0].shape)
print('Output shape:', lstm_model(w2.example[0]).shape)
#Initialization
val_performance = {}
########====== probably most important line here. this defines which windows we will be using. i am using the predefined window(w2) we mentioned earlier

history= compile_and_fit(lstm_model, w2)

IPython.display.clear_output()
val_performance['LSTM'] = lstm_model.evaluate(w2.val)
### Unnormalizing the data
#def Unnormalizing(preds):
    
preds=lstm_model.predict(w2.val)
preds=preds.reshape(29*5,21)
w2.plot(lstm_model,plot_col='C2X')
