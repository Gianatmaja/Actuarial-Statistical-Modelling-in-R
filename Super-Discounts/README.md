# Bayesian Analysis of Super Discounts

### Problem Statement
A retailer, wishes to estimate the effects of super discounts, which occur on around 40% of the time, on their earnings. Given a sample of 100 data points, showing the daily sales (assumed to be normally distributed) for 100 days (with and without super discount), we will perform a Baysesian analysis to find out if super discounts increase sales.

### EDA of Data

![EDA](https://github.com/Gianatmaja/Actuarial-Statistical-Modelling-in-R/tree/main/Super-Discounts/Image)

We observe that there seems to be 2 separate normal distributions here, with the first being when $y \leq 11$, and the second when $y > 11$. We assume 
that the latter is when super discounts are present as this complies with the given information that super discounts occur around 40% of the time. In the
sample data, cases when$\ y > 11$ accounts for 45% of all observations in our data, which is close to the departmental store's belief at 40%. Second, 
both cases seem to follow a normal distribution.
