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

The 1<sup>st</sup> equation tells us that $\alpha_{1} = \frac{2}{3}\alpha_{2\ }$.
Substituting this to the 2<sup>nd</sup> equation allows us to find the value of
$\alpha_{2}$, which we can use to find $\alpha_{1}$. Doing that, we find
the exact prior distribution for p to be Beta(0.4, 0.6).

Finally, for $\psi$, we will use a $\Gamma(0.01,\ 0.01)$ prior. This
prior will have a mean of 1 and a variance of 100. Similar to the case
of $\alpha$ and $\gamma$, this is a vague prior.

### Posterior Function
We first assume that $$ was observed (we will use data augmentation to
explore it later). Thus, the joint posterior can now be written as
follows:

$$\pi(p,\alpha,\gamma,\ \psi\ |\ ,) \propto \ \pi(p)\pi(\alpha)\pi(\gamma)\pi(\psi)p^{n_{I}(d)}(1 - p)^{n_{O}(d)}\psi^{\frac{n}{2}}e^{- \frac{\psi}{2}\sum_{i = 1}^{n_{I}(d)}\left( y_{i} - \alpha - \gamma \right)^{2}}e^{- \frac{\psi}{2}\sum_{i = 1}^{n_{O}(d)}\left( y_{i} - \alpha \right)^{2}}$$

where: $\pi(p) \propto p^{- 0.6}(1 - p)^{- 0.4}$

$\pi(\alpha) \propto e^{- \frac{\alpha^{2}}{200}}\ $

$\pi(\gamma) \propto \ e^{- \frac{\gamma^{2}}{200}}$

$\pi(\psi) \propto \psi^{- 0.99}e^{- 0.01\psi}$

Hence, we have:

$\pi(p,\alpha,\gamma,\ \psi\ |\ ,) \propto p^{n_{I}(d) - 0.6}(1 - p)^{n_{O}(d) - 0.4}\ \psi^{\frac{n}{2}\  - 0.99}e^{- \ \frac{\psi}{2}\sum_{i = 1}^{n_{I}(d)}\left( y_{i} - \alpha - \gamma \right)^{2}}e^{- \ \frac{\psi}{2}\sum_{i = 1}^{n_{O}(d)}\left( y_{i} - \alpha \right)^{2}}e^{- 0.01\psi}e^{- \ \frac{\alpha^{2}}{200}}\ e^{- \ \frac{\gamma^{2}}{200}}$

We can now find the conditional posterior for each parameter by
extracting only the factors that depend on each parameter.

$\pi(p|\ \alpha,\ \gamma,\ \psi\ ,) \propto \ p^{n_{I}(d) - 0.6}(1 - p)^{n_{O}(d) - 0.4}$

$\pi(\alpha|\ p,\ \gamma,\ \psi\ ,) \propto e^{- \ \frac{\psi}{2}\sum_{i = 1}^{n_{I}(d)}{\left( y_{i} - \alpha - \gamma \right)^{2}\  - \ \ \frac{\psi}{2}\sum_{i = 1}^{n_{O}(d)}{\left( y_{i} - \alpha \right)^{2}\  - \ \frac{\alpha^{2}}{200}}}}$
(i)

$\pi(\gamma|\ p,\ \alpha,\ \psi,\ ,) \propto e^{- \ \frac{\psi}{2}\sum_{i = 1}^{n_{I}(d)}{\left( y_{i} - \alpha - \gamma \right)^{2}\  - \ \ \frac{\gamma^{2}}{200}}}$
(ii)

$\pi(\psi|\ p,\ \alpha,\ \gamma,\ ,) \propto \ \psi^{\frac{n}{2}\  - \ 0.99}e^{- \psi\lbrack\ \frac{1}{2}\sum_{i = 1}^{n_{I}(d)}{\left( y_{i} - \alpha - \gamma \right)^{2}\  + \ \frac{1}{2}\sum_{i = 1}^{n_{O}(d)}{\left( y_{i} - \alpha \right)^{2}\  + \ 0.01\rbrack\ \ }}}$

Since we actually don't have the values for $$ , we treat it as an
additional parameter to explore and its conditional posterior is as
follows.

$$\pi(|\ p,\ \alpha,\ \gamma,\ \psi,) \propto \prod_{i = 1}^{n}{\left( pf_{I}\left( y_{i} \right) \right)^{I\left( d_{i} = 1 \right)}\left( (1 - p)f_{O}\left( y_{i} \right) \right)^{I\left( d_{i} = 0 \right)}} \propto \prod_{i = 1}^{n}{\pi\left( d_{i} \right|\ p,\ \alpha,\ \gamma,\ \psi,y_{i})}$$

where
$\pi\left( d_{i} \right|\ p,\ \alpha,\ \gamma,\ \psi,y_{i}) = \frac{pf_{I}\left( y_{i} \right)}{pf_{I}\left( y_{i} \right)\  + \ (1 - p)f_{O}\left( y_{i} \right)}$
when $d_{i} = 1$ and
$\text{\ π}\left( d_{i} \right|\ p,\ \alpha,\ \gamma,\ \psi,y_{i}) =$

$\frac{(1 - p)f_{O}\left( y_{i} \right)}{pf_{I}\left( y_{i} \right)\  + \ (1 - p)f_{O}\left( y_{i} \right)}$
when $d_{i} = 0$, with $f_{I}\left( y_{i} \right)$ and $f_{O}(y_{i})$
defined earlier in question 2. Next, we

observe that the conditional posteriors of $p$ and $\psi$ follow the
following distributions:

$(p|\ \alpha,\ \gamma,\ \psi\ ,)\sim Beta\left( n_{I}(d) + 0.4\ ,\ n_{O}(d) + 0.6 \right)$
(iii)

$(\psi|\ p,\ \alpha,\ \gamma,\ ,)\sim\Gamma(\frac{n}{2} + 0.01\ ,\ \frac{1}{2}\sum_{i = 1}^{n_{I}(d)}{\left( y_{i} - \alpha - \gamma \right)^{2} + \frac{1}{2}\sum_{i = 1}^{n_{O}(d)}{\left( y_{i} - \alpha \right)^{2} + 0.01)\ \ }}$
(iv)

The conditional posterior of $\alpha$ and $\gamma$ don't seem to follow
any standard distribution. So, to sample from them, we can use the
Metropolis-Hastings algorithm. The full algorithm works as follows:

![Steps](https://github.com/Gianatmaja/Actuarial-Statistical-Modelling-in-R/blob/main/Super-Discounts/Image/Screenshot%202022-10-09%20at%209.00.05%20PM.png)

### Results

We now implement the algorithm discussed in question 4. First, we choose
the starting values for the parameters. For p, we set it to 0.4 to
comply with the store's beliefs. For $\alpha$

and $\gamma$, we choose 10 and 2 (as estimated in the EDA process in
question 1). Finally, for $\psi$,

we choose the value $\frac{1}{{0.45}^{2}} = 4.938$ . We obtain this
value by first computing the confidence interval for population variance
of a Normal distribution, for both the samples where $y \leq 11$ and
$y > 11$. The 95% confidence interval is given by this formula:

$95\%\ CI\ for\ \sigma^{2} = \left( \frac{(n - 1)s^{2}}{\chi_{n - 1,\ \ 1 - \frac{\alpha}{2}}^{2}}\ ,\ \frac{(n - 1)s^{2}}{\chi_{n - 1,\frac{\alpha}{2}}^{2}} \right)$

where n denotes the sample size, $s^{2}$ the sample variance, and
$\chi_{n - 1}^{2}$ denotes a chi-square distribution with (n-1) degrees
of freedom. Doing so and taking the square root, we obtain the 95%
interval for $\sigma$ as (0.417, 0.61) for the samples where $y \leq 11$
and (0.35, 0.532) for the samples where $y > 11$. We then pick any value
that is present in both intervals, in our case, 0.45, and calculate
$\psi_{1} = \frac{1}{{0.45}^{2}}$ . For $$, we initially set $d_{i} = 1$
if $y_{i} > 11$ and $d_{i} = 0$ otherwise.

Running the algorithm for 20000 iterations with $\mathrm{\Delta}_{a}$ and $\mathrm{\Delta}_{\gamma}$ at 0.25, we
obtain the following trace plots.

![res1](https://github.com/Gianatmaja/Actuarial-Statistical-Modelling-in-R/blob/main/Super-Discounts/Image/Screenshot%202022-10-09%20at%209.10.00%20PM.png)

We observe that the chains have stabilized
not far from their respective initial values. While it does seem that
our chains have converged, we would like to confirm this further. So, we
run the algorithm for a second time, but with the initial values of
$p,\ \psi,\ \alpha,\ \gamma$ all set to 0.1. If our algorithm works
correctly, then we would see the chains converge around the same values as before.

![res2](https://github.com/Gianatmaja/Actuarial-Statistical-Modelling-in-R/blob/main/Super-Discounts/Image/Screenshot%202022-10-09%20at%209.10.11%20PM.png)

All chains converged to similar values as in the first trial. Hence, we conclude that our algorithm indeed works. We further set the burn-in period to 5000 and apply thinning with m = 20. This is to ensure that our samples have converged and are independent. With the generated samples, we observe each parameter’s histogram and autocorrelation (to ensure independence of generated samples) below.

![res3](https://github.com/Gianatmaja/Actuarial-Statistical-Modelling-in-R/blob/main/Super-Discounts/Image/Screenshot%202022-10-09%20at%209.10.28%20PM.png)

![res4](https://github.com/Gianatmaja/Actuarial-Statistical-Modelling-in-R/blob/main/Super-Discounts/Image/Screenshot%202022-10-09%20at%209.10.45%20PM.png)

### Conclusion

We conclude that super discounts occur on around 45% of all days, and on average, brings in an extra $20 263. Without super discounts, daily sales have a mean of $99 844. With super discounts, they have a mean of $120 107. We estimate the standard deviation of the earnings 
in both cases to be $4 799.



