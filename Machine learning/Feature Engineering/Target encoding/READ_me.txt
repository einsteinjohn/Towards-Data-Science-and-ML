When choosing a value for m, consider how noisy you expect the categories to be. 
Does the price of a vehicle vary a great deal within each make? Would you need a lot of data to get good estimates? 
If so, it could be better to choose a larger value for m; if the average price for each make were relatively stable, a smaller value could be okay.

Use Cases for Target Encoding
Target encoding is great for:
High-cardinality features: A feature with a large number of categories can be troublesome to encode: 
a one-hot encoding would generate too many features and alternatives, like a label encoding, might not be appropriate for that feature. 
A target encoding derives numbers for the categories using the feature's most important property: its relationship with the target.

Domain-motivated features: From prior experience, you might suspect that a categorical feature should be important even if it scored poorly with a feature metric. 
A target encoding can help reveal a feature's true informativeness.

Question: Based on understanding of how mean-encoding works, can we explain how XGBoost was able to get an almost a perfect fit after mean-encoding the count feature?

Answer: Since Count never has any duplicate values, the mean-encoded Count is essentially an exact copy of the target. In other words, mean-encoding turned a completely meaningless feature into a perfect feature.
Now, the only reason this worked is because we trained XGBoost on the same set we used to train the encoder. If we had used a hold-out set instead, none of this "fake" encoding would have transferred to the training data.
The lesson is that when using a target encoder it's very important to use separate data sets for training the encoder and training the model. Otherwise the results can be very disappointing!