# Required Libraries (For Plotting)
library(ggplot2)
library(forecast)

# EDA
# Data
tab = read.table("data.txt", sep = " ")
y = unlist(as.list(t(tab)))

# Histogram of y
hist(y, breaks = 15, main = "Histogram of Daily Sales (Units of $10 000)", 
     xlab = "Daily Sales (Y)", freq = F)

# Summary statistics
summary(y)
sd(y)
length(y)

# Assume 2 groups - with and without super discounts. Threshold = 11
approx_sales_no_disc = y[which(y<=11)]
approx_sales_with_disc = y[which(y>11)]

# Summary of 2 groups
summary(approx_sales_no_disc)
summary(approx_sales_with_disc)
sd(approx_sales_no_disc)
sd(approx_sales_with_disc)

# Checking assumptions
# Proportion of super discounts
length(approx_sales_with_disc)/length(y)

# Normality test
# No discounts
qqnorm(approx_sales_no_disc, pch = 16, main = "Normal QQ Plot (Y <= 11)")
qqline(approx_sales_no_disc, col = 'red', lwd = 2)
grid(5,5)
# Null hypothesis: Samples come from normal population
# Accept if p-value>0.05
shapiro.test(approx_sales_no_disc) 

# Discounts 
qqnorm(approx_sales_with_disc, pch = 16, main = "Normal QQ Plot (Y > 11)")
qqline(approx_sales_with_disc, col = 'red', lwd = 2)
grid(5,5)
# Null hypothesis: Samples come from normal population
# Accept if p-value>0.05
shapiro.test(approx_sales_with_disc)

# What if discounts decrease earnings?
# New threshold
quantile(y, 0.4)
# New group division
approx_sales_no_disc2 = y[which(y > 10.4)]
approx_sales_with_disc2 = y[which(y <= 10.4)]
# Normality test
# Null hypothesis: Samples come from normal population
# Accept if p-value>0.05
shapiro.test(approx_sales_no_disc2)
shapiro.test(approx_sales_with_disc2)
# Samples not normal - defy given info
qqnorm(approx_sales_no_disc2, pch = 16)
qqline(approx_sales_no_disc2, col = 'red')
qqnorm(approx_sales_with_disc2, pch = 16)
qqline(approx_sales_with_disc2, col = 'red')
# Now onwards, consider only that super discounts increase earnings

# Histogram of each groups. Threshold = 11
# No discounts
hist(approx_sales_no_disc)
mean(approx_sales_no_disc)
sd(approx_sales_no_disc)
# Discounts
hist(approx_sales_with_disc)
mean(approx_sales_with_disc) - mean(approx_sales_no_disc)
sd(approx_sales_with_disc)

# 95% CI for each population's variance - Contribute to tarting value for precision
LB1 = ((length(approx_sales_no_disc)-1)*var(approx_sales_no_disc))/
  qchisq(0.975, df=(length(approx_sales_no_disc)-1))
UB1 = ((length(approx_sales_no_disc)-1)*var(approx_sales_no_disc))/
  qchisq(0.025, df=(length(approx_sales_no_disc)-1))
LB2 = ((length(approx_sales_with_disc)-1)*var(approx_sales_with_disc))/
  qchisq(0.975, df=(length(approx_sales_with_disc)-1))
UB2 = ((length(approx_sales_with_disc)-1)*var(approx_sales_with_disc))/
  qchisq(0.025, df=(length(approx_sales_with_disc)-1))
# 95% CI for var without super discounts
c(sqrt(LB1), sqrt(UB1))
# 95% CI for var with super discounts
c(sqrt(LB2), sqrt(UB2))


# MCMC Simulation
# Algorithm specifications
N = 20000
Burn_in = 5000
m = 20
n = length(y)

# Parameter vectors
p_vec = vector("numeric", N)
psi_vec = vector("numeric", N)
alpha_vec = vector("numeric", N)
gamma_vec = vector("numeric", N)

# Prior parameters - Discussed in Q3
mu_alpha = 0
var_alpha = 100
mu_gamma = 0
var_gamma = 100
alpha_p = 0.4
beta_p = 0.6
alpha_psi = 0.01
beta_psi = 0.01

# Initial values - Discussed in Q5
d = 1*(y > 11) + 0*(y <= 11)
p_vec[1] = 0.4
psi_vec[1] = 1/(0.45^2)
alpha_vec[1] = 10
gamma_vec[1] = 2
# 2nd Trial - Change initial values to below.
# All initial values set to 0.1 to see if algorithm really works
# Discussed in Q5
#p_vec[1] = 0.1
#psi_vec[1] = 0.1
#alpha_vec[1] = 0.1
#gamma_vec[1] = 0.1

# Delta parameters for MH Steps
delta_alpha = 0.25
delta_gamma = 0.25

# Algorithm - Details explained in Q4
for(i in 1:(N-1)){
  # For counting n1(d) and n0(d)
  ind_d1 = which(d == 1)
  ind_d0 = which(d == 0)
  
  # Gibbs steps
  # P posterior
  alpha_p_post = length(ind_d1) + 0.4
  beta_p_post = length(ind_d0) + 0.6
  # Draw a new p
  p_vec[i+1] = rbeta(1, alpha_p_post, beta_p_post)
  
  # Psi posterior
  alpha_psi_post = (n/2) + 0.01
  beta_psi_post = 0.5*sum((y[ind_d1] - alpha_vec[i] - gamma_vec[i])^2) +
    0.5*sum((y[ind_d0] - alpha_vec[i])^2) + 0.01
  # Draw a new psi
  psi_vec[i+1] = rgamma(1, alpha_psi_post, beta_psi_post)
  
  # MH steps
  # Alpha posterior
  # Propose new value for alpha
  alpha_prop = runif(1, (alpha_vec[i] - delta_alpha), (alpha_vec[i] + delta_alpha))
  prob_prop_alpha = exp((-psi_vec[i+1]/2)*sum((y[ind_d1] - alpha_prop - gamma_vec[i])^2) -
                          (psi_vec[i+1]/2)*sum((y[ind_d0] - alpha_prop)^2) - 
                          (alpha_prop^2)/200)
  prob_curr_alpha = exp((-psi_vec[i+1]/2)*sum((y[ind_d1] - alpha_vec[i] - gamma_vec[i])^2) -
                          (psi_vec[i+1]/2)*sum((y[ind_d0] - alpha_vec[i])^2) - 
                          (alpha_vec[i]^2)/200)
  # P acc
  p_acc_alpha = min(1, (prob_prop_alpha/prob_curr_alpha))
  # Random U(0,1) value
  u1 = runif(1, 0, 1)
  # Accept new alpha if u1 <= P acc
  if(u1 <= p_acc_alpha){
    alpha_vec[i+1] = alpha_prop
  }else{
    alpha_vec[i+1] = alpha_vec[i]
  }
  
  # Gamma posterior
  # Propose new value for gamma
  gamma_prop = runif(1, (gamma_vec[i] - delta_gamma), (gamma_vec[i] + delta_gamma))
  prob_prop_gamma = exp((-psi_vec[i+1]/2)*sum((y[ind_d1] - alpha_vec[i+1] - gamma_prop)^2) -
                          (gamma_prop^2)/200)
  prob_curr_gamma = exp((-psi_vec[i+1]/2)*sum((y[ind_d1] - alpha_vec[i+1] - gamma_vec[i])^2) -
                          (gamma_vec[i]^2)/200)
  # P acc 
  p_acc_gamma = min(1, (prob_prop_gamma/prob_curr_gamma))
  # Random U(0,1) value
  u2 = runif(1, 0, 1)
  # Accept new gamma if u2 <= P acc
  if(u2 <= p_acc_gamma){
    gamma_vec[i+1] = gamma_prop
  }else{
    gamma_vec[i+1] = gamma_vec[i]
  }
  
  # Update d vector
  probs1 = p_vec[i+1]*dnorm(y, (alpha_vec[i+1] + gamma_vec[i+1]), sqrt(1/psi_vec[i+1]))
  probs2 = (1-p_vec[i+1])*dnorm(y, alpha_vec[i+1], sqrt(1/psi_vec[i+1]))
  # Probability di = 1
  probs = probs1/(probs1 + probs2)
  # n random U(0,1) values
  u = runif(n, 0, 1)
  # Accept if ui<=pi for i = 1,2,...,100
  d = 1*(u <= probs) + 0*(u > probs)
}

# Plot trace plots
Inds = seq(Burn_in+1, N, m)
plot(seq(1,N,1), p_vec, type = 'l', 
     xlab = 'Iterations', ylab = 'p', main = 'Trace of p')
plot(seq(1,N,1), psi_vec, type = 'l', 
     xlab = 'Iterations', ylab = 'psi', main = 'Trace of psi')
plot(seq(1,N,1), alpha_vec, type = 'l', 
     xlab = 'Iterations', ylab = 'alpha', main = 'Trace of alpha')
plot(seq(1,N,1), gamma_vec, type = 'l', 
     xlab = 'Iterations', ylab = 'gamma', main = 'Trace of gamma')

# Histograms of each parameter
hist(p_vec[Inds], main = 'Histogram of p', xlab = 'p', freq = F)
hist(psi_vec[Inds], main = 'Histogram of psi', xlab = 'psi', freq = F)
hist(alpha_vec[Inds], main = 'Histogram of alpha', xlab = 'alpha', freq = F)
hist(gamma_vec[Inds], main = 'Histogram of gamma', xlab = 'gamma', freq = F)

# Autocorrelation for each parameter's samples
ggAcf(p_vec[Inds], lag.max = 50) + ylim(c(-0.15,0.15)) + 
  ggtitle('P Autocorrelation (From Lag 1)')
ggAcf(psi_vec[Inds], lag.max = 50) + ylim(c(-0.15,0.15)) + 
  ggtitle('Psi Autocorrelation (From Lag 1)')
ggAcf(alpha_vec[Inds], lag.max = 50) + ylim(c(-0.15,0.15)) + 
  ggtitle('Alpha Autocorrelation (From Lag 1)')
ggAcf(gamma_vec[Inds], lag.max = 50) + ylim(c(-0.15,0.15)) + 
  ggtitle('Gamma Autocorrelation (From Lag 1)')

# Mean, sd and 95% CI
# P
mean(p_vec[Inds])
sd(p_vec[Inds])
quantile(p_vec[Inds], c(0.025, 0.975))

# Psi
mean(psi_vec[Inds])
sd(psi_vec[Inds])
quantile(psi_vec[Inds], c(0.025, 0.975))

# Alpha
mean(alpha_vec[Inds])
sd(alpha_vec[Inds])
quantile(alpha_vec[Inds], c(0.025, 0.975))

# Gamma
mean(gamma_vec[Inds])
sd(gamma_vec[Inds])
quantile(gamma_vec[Inds], c(0.025, 0.975))

# Final histograms
hist(y[which(d == 1)], breaks = 10, main = "Earnings with Super Discounts", 
     xlab = "Amount (Units of $10 000)", freq = F)
hist(y[which(d == 0)], breaks = 10, main = "Earnings without Super Discounts", 
     xlab = "Amount (Units of $10 000)", freq = F)
# Mean of earnings with and without super discounts
round(mean(y[which(d == 1)])*10000,0)
round(mean(y[which(d == 0)])*10000,0)
# Difference in earnings
round(mean(y[which(d == 1)])*10000,0) - round(mean(y[which(d == 0)])*10000,0)
# Estimated standard deviation
sqrt(1/mean(psi_vec[Inds]))*10000
