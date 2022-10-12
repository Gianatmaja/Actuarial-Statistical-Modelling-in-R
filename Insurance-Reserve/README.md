# Estimating the Required Reserve for an Insurance Company Using Bayesian Statistics

### Problem Statement
An insurance company wishes to estimate the required reserve for the upcoming year, using the total aggregated claims for the previous 4 years. To do this, 
we will perform a Bayesian analysis to predict the necessary capital the company should hold such that we are 95% certain that the claims will not exceed 
this amount of reserve. We were told that the amount of the aggregated claim follows a given Rayleigh distribution with unknown parameter θ, and that the 
previous 4 total annual claims were 1.1, 0.7, 0.45, and 1.3 million GBP.

### Part One: Choosing a prior

We decided to use the Gamma distribution as our prior distribution for
θ. The main reason is because it is a conjugate prior for the Rayleigh
distribution (we will see later when we derive the posterior
distribution). This ensures that it retains its form and also that it is
integrable (it a proper prior). These 2 reasons make it very convenient
to use Gamma as our prior.

Due to our lack of knowledge about θ, we decided to use a vague prior.
In order to do this, we set both α and β of our prior distribution Γ(α,
β) to be small. In our case, we set both values to be 0.001. We will
then have a Gamma distribution with mean 1 and variance 1000.

### Part Two: Deriving the posterior distribution

Likelihood for Rayleigh Distribution:
$\prod_{i = 1}^{n}{x_{i}\theta^{n}e^{- \frac{\theta}{2}\sum_{i = 1}^{n}x_{i}^{2}}}$

Pdf for $\theta$ \~ Γ(α, β) =
$\frac{\beta^{\alpha}}{\Gamma(\alpha)}\theta^{\alpha - 1}e^{- \beta\theta}$

π(θ\|x)
$\propto \ \theta^{\alpha - 1}e^{- \left( \beta + \frac{\sum_{i = 1}^{n}x_{i}^{2}}{2} \right)}$

Hence, (θ\|x) \~ Γ(α + n, $\beta + \frac{\sum_{i = 1}^{n}x_{i}^{2}}{2}$)

We can see that the posterior retains the form of a Gamma distribution.
Putting our α, β, and data, we have π(θ\|x)\~Γ(4.001, 1.79725),
resulting in a posterior mean of 2.226179 and a posterior variance of
1.238658. Therefore, we have a posterior distribution with a higher mean
and variance compared to our prior distribution.

![im1](https://github.com/Gianatmaja/Statistical-Modelling-in-R/blob/main/Insurance-Reserve/images/Rplot01.png)

### Part Three: Deriving the posterior predictive distribution
![f1](https://github.com/Gianatmaja/Statistical-Modelling-in-R/blob/main/Insurance-Reserve/images/Screenshot%202022-10-12%20at%205.09.16%20PM.png)

### Part Four: Generating samples of π(y\|θ)
![f2](https://github.com/Gianatmaja/Statistical-Modelling-in-R/blob/main/Insurance-Reserve/images/Screenshot%202022-10-12%20at%205.08.31%20PM.png)

We generated 100 000 samples of Y in R and
obtained a sample mean of 0.5983879 and a sample variance of 0.6792624.
Plotting the distribution in R, we saw that it is similar to a Gamma
distribution. Denoting this hypothetical Gamma distribution by Γ(α',
β'), We need to have $\frac{\alpha'}{\beta'} = 0.5983879$ and
$\frac{\alpha'}{{\beta'}^{2}} = \frac{99\ 999}{10\ 000} \times 0.6792624$.
Solving this, we have Y\~Γ(0.5271, 0.881).

![im2](https://github.com/Gianatmaja/Statistical-Modelling-in-R/blob/main/Insurance-Reserve/images/Rplot01.png)


### Part Five: Selecting a minimum reserve

To obtain the minimum required reserve, we  did 100 simulations where for each
simulation, we took the lowest value of the highest 5% of the sample
(where in our case is the 95001st data when sorted from lowest to
highest). Then, we find the mean of them from our 100 simulations of it.
In our case, we finally conclude that in order for the company to be at
least 95% certain that it can cover its aggregated claims in the next 12
months, it needs to hold a minimum of £2.001577 million in reserve.
