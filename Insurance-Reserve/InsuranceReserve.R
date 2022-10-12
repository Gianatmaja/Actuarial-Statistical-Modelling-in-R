Alpha = 0.001 #Prior alpha
Beta = 0.001 #Prior beta
data = c(1.1,0.7,0.45,1.3) #Given data
n = length(data)
SigmaX2 = sum(data^2)
AlphaPost = n + Alpha #Posterior alpha
BetaPost = (SigmaX2/2) + Beta #Posterior beta
X = seq(0,10,0.001) #Preparation for plots of prior and posterior distribution
Y1 = dgamma(X,Alpha,Beta) #Prior
Y2 = dgamma(X,AlphaPost,BetaPost) #Posterior
plot(X,Y1,type="l",ylim=c(0,1),col="red",main="Prior v Posterior",xlab="X",ylab="Density")
lines(X,Y2,type="l",col="blue")
legend("topright",legend=c("Prior","Posterior"),col=c("red","blue"),lwd=c(2,2))
A = (AlphaPost*(BetaPost^AlphaPost)) #Refer to report for the definition of A, B, and C
B = BetaPost
C = AlphaPost + 1
N = 100000 #number of samples
Y = vector("numeric",N) #Vector for generated samples
for (i in 1:length(Y)){
  u = runif(1) #Uniform(0,1) random variables
  Y[i] = (((u*(C-1)/(-A)) + (B^(-C+1)))^(1/(-C+1))) - B #Y values generated using Inverse Transform Method
}
hist(Y,freq=F,xlim=c(0,10),ylim=c(0,1)) #Plot histogram
miuY = mean(Y) #Unbiased estimator for population mean
varY = var(Y)*((N-1)/N) #Unbiased estimator for population variance
BetaY = miuY/varY #Hypothetical beta
AlphaY = miuY*BetaY #Hypothetical alpha
Y3 = dgamma(X,AlphaY,BetaY) #These 3 lines are used to compare the histogram to the
hypothetical gamma distribution
lines(X,Y3,type="l",col="red")
legend("topright",legend="Gamma(0.5271425, 0.8809378)",col="red",lwd=2)
index = 0.95*N + 1 #index for lowest data in top 5%
simulations = 100 #Number of simulations
count = vector("numeric",simulations) #Count vector to count number of Y variables > 1,3
Y95 = vector("numeric",simulations) #Vector to store the the lowest data in the top 5%
for (k in 1:simulations){
  N = 100000 #number of sample data
  Y = vector("numeric",N) #Vector for generated Y values
  for (i in 1:length(Y)){
    u = runif(1) #Uniform(0,1) random values
    Y[i] = (((u*(C-1)/(-A)) + (B^(-C+1)))^(1/(-C+1))) - B #Generate Y values using Inverse
    Transform Method
    if(Y[i]>1.3){
      count[k] = count[k] + 1 #Count number of Y values that are higher than 1.3
    }
  }
  Ysorted = sort(Y) #sort Y values from lowest to highest
  Y95[k] = Ysorted[index] #Take the lowest data in the top 5%
  count[k] = count[k]/N #Count proportion of data higher than 1.3
}
mean(count) #Estimate for P(Y>1.3)
mean(Y95) #Estimate for required reserve