The k-means algorithm is sensitive to scale. 
This means we need to be thoughtful about how and whether we rescale our features since we might get very different results depending on our choices. 
As a rule of thumb, if the features are already directly comparable (like a test result at different times), then you would not want to rescale. 
On the other hand, features that aren't on comparable scales (like height and weight) will usually benefit from rescaling. 
Sometimes, the choice won't be clear though. 
In that case, you should try to use common sense, remembering that features with larger values will be weighted more heavily.

Example: 
1) Scaling Features
Consider the following sets of features. For each, decide whether:

they definitely should be rescaled,
they definitely should not be rescaled, or
either might be reasonable
Features:

a.Latitude and Longitude of cities in California
b.Lot Area and Living Area of houses in Ames, Iowa
c.Number of Doors and Horsepower of a 1989 model car

Answer: 
a. No, since rescaling would distort the natural distances described by Latitude and Longitude.
b. Either choice could be reasonable, but because the living area of a home tends to be more valuable per square foot, it would make sense to rescale these features so that lot area isn't weighted in the clustering out of proportion to its effect on SalePrice, if that is what you were trying to predict.
c. Yes, since these don't have comparable units. Without rescaling, the number of doors in a car (usually 2 or 4) would have negligible weight compared to its horsepower (usually in the hundreds).

