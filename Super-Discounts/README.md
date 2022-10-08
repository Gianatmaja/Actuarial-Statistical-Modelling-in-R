# Bayesian Analysis of Super Discounts

### Problem Statement
A retailer, wishes to estimate the effects of super discounts, which occur on around 40% of the time, on their earnings. Given a sample of 100 data points, showing the daily sales (assumed to be normally distributed) for 100 days (with and without super discount), we will perform a Baysesian analysis to find out if super discounts increase sales.

### EDA of Data
We observe that there seems to be 2 separate normal distributions here, with the first being when
$y \leq 11$, and the second when $y > 11$. We first assume that the latter is when super discounts are present (since logically, super
discounts should increase earnings, otherwise it wouldn't be
implemented). Further, this also complies with the given information.
First, cases when$\ y > 11$ accounts for 45% of all observations in our
data, which is close to the departmental store's belief at 40%. Second,
both cases seem to follow a normal distribution.
