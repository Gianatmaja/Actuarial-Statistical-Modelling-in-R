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

