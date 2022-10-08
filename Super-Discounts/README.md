# Bayesian Analysis of Super Discounts

### Problem Statement
A retailer, wishes to estimate the effects of super discounts, which occur on around 40% of the time, on their earnings. Given a sample of 100 data points, showing the daily sales (assumed to be normally distributed) for 100 days (with and without super discount), we will perform a Baysesian analysis to find out if super discounts increase sales.

### EDA of Data
![EDA](https://github.com/Gianatmaja/Actuarial-Statistical-Modelling-in-R/blob/main/Super-Discounts/Image/Screenshot%202022-10-08%20at%2010.24.55%20PM.png)

We observe that there seems to be 2 separate normal distributions here, with the first being when $y \leq 11$, and the second when $y > 11$. We assume 
that the latter is when super discounts are present as this complies with the given information that super discounts occur around 40% of the time. In the
sample data, cases when $\ y > 11$ accounts for 45% of all observations in our data, which is close to the departmental store's belief at 40%. Second, 
both cases seem to follow a normal distribution.

### Likelihood Function
We have
$y_{i}\sim N\left( \alpha + \gamma d_{i}\ ,\ \psi \right)\ ;\ i = 1,2,\ldots,n$
where $\psi$ denotes the precision (i.e., $\frac{1}{\sigma^{2}}$). To
derive the likelihood of our observed data, we first consider each
observation to be a random draw from the following mixture distribution:

$$g\left( y_{i};p,\alpha,\gamma,\ \psi \right) = pf_{I}(y_{i}) + (1 - p)f_{O}(y_{i})$$

where
$f_{I}(y_{i}) = \sqrt{\frac{\psi}{2\pi}}e^{- \frac{1}{2}\psi\left( y_{i} - \alpha - \gamma \right)^{2}}$
i.e., the density for earnings on super discount days, and

$f_{O}(y_{i}) = \ \sqrt{\frac{\psi}{2\pi}}e^{- \frac{1}{2}\psi\left( y_{i} - \alpha \right)^{2}}$
i.e., the density for earnings on days without super discounts. Thus, in
the absence of $$ , the likelihood of our observed data is: 
$$L = \prod_{i = 1}^{n}{g\left( y_{i};p,\alpha,\gamma,\ \psi \right)}$$

In the presence of $$ , our likelihood becomes:

$$L = \prod_{i = 1}^{n}{\left( pf_{I}\left( y_{i} \right) \right)^{I\left( d_{i} = 1 \right)}\left( (1 - p)f_{O}\left( y_{i} \right) \right)^{I\left( d_{i} = 0 \right)}}$$

$$\ \ \  = p^{n_{I}(d)}(1 - p)^{n_{O}(d)}\prod_{i = 1}^{n_{I}(d)}{f_{I}\left( y_{i} \right)}\prod_{i = 1}^{n_{O}(d)}{f_{O}\left( y_{i} \right)}$$

where $n_{I}(d)$ and $n_{O}(d)$ denote the number of observations with
and without super discounts, respectively.

Substituting the formula for $f_{I}(y_{i})$ and $f_{O}(y_{i})$ into the
equation and simplifying the equation, the complete likelihood (in the
presence of $$) becomes:

$$L(,;p,\alpha,\gamma,\ \psi)\ \  \propto \ \text{\ p}^{n_{I}(d)} \bullet (1 - p)^{n_{O}(d)} \bullet \psi^{\frac{n}{2}}{\bullet e}^{- \frac{\psi}{2}\sum_{i = 1}^{n_{I}(d)}\left( y_{i} - \alpha - \gamma \right)^{2}}{\bullet e}^{- \frac{\psi}{2}\sum_{i = 1}^{n_{O}(d)}\left( y_{i} - \alpha \right)^{2}}$$

where $n = n_{I}(d) + n_{O}(d)$.

### Priors
We now choose our priors. First, for $\alpha$ and $\gamma$, we use a
N(0, 100) distribution as our prior. We choose this prior specification
because before seeing the data, we have very little knowledge on the
location of the regression parameters. So, we choose a prior with a
large variance. The choice of the mean will not have much importance
here. Since it is a vague prior, it will have little impact on the
posterior.

Next, for p, we choose a Beta distribution with a mean of 0.4 and a
variance of 0.12 as our prior. The choice of the mean was to comply with
the given information that super discount occurs on around 40% of the
days. Furthermore, the conjugacy property of a Beta prior on a binomial
likelihood will also make the inference on p more convenient. To get the
exact distribution, we solve the following equations.

$\frac{\alpha_{1}}{\alpha_{1} + \alpha_{2}} = 0.4\ \ \ \ and\ \ \ \ \ \frac{\alpha_{1}\alpha_{2}}{\left( \alpha_{1} + \alpha_{2} \right)^{2}(\alpha_{1} + \alpha_{2} + 1)} = \frac{0.4\alpha_{2}}{(\alpha_{1} + \alpha_{2})(\alpha_{1} + \alpha_{2} + 1)} = 0.12$

The 1^st^ equation tells us that $\alpha_{1} = \frac{2}{3}\alpha_{2\ }$.
Substituting this to the 2^nd^ equation allows us to find the value of
$\alpha_{2}$, which we can use to find $\alpha_{1}$. Doing that, we find
the exact prior distribution for p to be Beta(0.4, 0.6).

Finally, for $\psi$, we will use a $\Gamma(0.01,\ 0.01)$ prior. This
prior will have a mean of 1 and a variance of 100. Similar to the case
of $\alpha$ and $\gamma$, this is a vague prior.
