Just like clustering is a partitioning of the dataset based on proximity, you could think of PCA as a partitioning of the variation in the data. 
PCA is a great tool to help you discover important relationships in the data and can also be used to create more informative features.

Technical note: PCA is typically applied to standardized data.
With standardized data "variation" means "correlation".
With unstandardized data "variation" means "covariance". All data in this course will be standardized before applying PCA.

The new features PCA constructs are actually just linear combinations (weighted sums) of the original features:

Example:
df["Size"] = 0.707 * X["Height"] + 0.707 * X["Diameter"]
df["Shape"] = 0.707 * X["Height"] - 0.707 * X["Diameter"]

Interpretation of answer 

The first component, PC1, seems to be a kind of "size" component, similar to what we saw in the tutorial: all of the features have the same sign (positive),
indicating that this component is describing a contrast between houses having large values and houses having small values for these features.

The interpretation of the third component PC3 is a little trickier. The features GarageArea and YearRemodAdd both have near-zero loadings, 
so let's ignore those. This component is mostly about TotalBsmtSF and GrLivArea. 
It describes a contrast between houses with a lot of living area but small (or non-existant) basements, and the opposite: small houses with large basements.


After running the last section, you will realise that there are some patterns within these outliers. Reasons are:

Notice that there are several dwellings listed as Partial sales in the Edwards neighborhood that stand out. 
A partial sale is what occurs when there are multiple owners of a property and one or more of them sell their "partial" ownership of the property.

These kinds of sales are often happen during the settlement of a family estate or the dissolution of a business and aren't advertised publicly. 
If you were trying to predict the value of a house on the open market, you would probably be justified in removing sales like these from your dataset -- they are truly outliers.




