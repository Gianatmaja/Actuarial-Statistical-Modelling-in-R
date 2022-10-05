#Low part one
trials = 100 #Step 1
steps = 10000
q = 0.8
PfL = 0.0005
Plow = matrix(c((1-PfL)+PfL*(1-q),PfL*q,0,PfL*(1-(q^2)),1-PfL,PfL*(q^2),PfL,0,1-PfL),nrow=3,ncol=3,byrow=T)
resultsL = matrix(0,nrow=3,ncol=steps+1)

for (j in 1:trials){ #Step 2
  x = vector("numeric",steps+1)
  x[1] = 1
  resultsL[1,1] = resultsL[1,1] + 1
  for (i in 1:steps){
    y = runif(1)
    p = Plow[x[i],]
    p = cumsum(p)
    if (y<=p[1]){
      x[i+1] = 1
      resultsL[1,i+1] = resultsL[1,i+1] + 1
    }else if (y<=p[2]){
      x[i+1] = 2
      resultsL[2,i+1] = resultsL[2,i+1] + 1
    }else{
      x[i+1] = 3
      resultsL[3,i+1] = resultsL[3,i+1] + 1
    }
  }
}
finalPropL = resultsL[,steps+1]/trials #Step 3

levels1L = resultsL[1,1:steps+1]
levels2L = resultsL[2,1:steps+1]
levels3L = resultsL[3,1:steps+1]
#Step 4
plot(levels1L/trials,type="l",ylim=c(0,1),main = "Low Quality", xlab="Steps",ylab="Proportion",col="palegreen4",lwd=2)
lines(levels2L/trials,col="skyblue3",lwd=2)
lines(levels3L/trials,col="tomato",lwd=2)
legend("topright",legend = c("State 0","State 1","State 2"),col=c("palegreen4","skyblue3","tomato"),lwd=c(2,2,2))
#Step 5
c1L = finalPropL[1]*PfL*(1-q) + finalPropL[2]*Plow[2,1] + finalPropL[3]*Plow[3,1]
c2L = finalPropL[1]*Plow[1,2]
c3L = finalPropL[2]*Plow[2,3]

CostL = c(410,q*200,q*400)

CostsL = (c(c1L*CostL[1],c2L*CostL[2],c3L*CostL[3]))
SumL = sum(CostsL)
cat("\n","Stationary distribution: ",finalPropL,"\n","Proportion of phone replaced & repaired: ",c1L,c2L,c3L,"\n","Expected daily cost: ",SumL,"per user","\n")

#Low Part 2
qRange = array(c(0+0.01*(0:100)))
Sim = length(qRange)
rangeResultsL = vector("numeric",Sim)
for (a in 1:Sim){
  trials = 100
  steps = 10000
  q = qRange[a]
  PfL = 0.0005
  Plow = matrix(c((1-PfL)+PfL*(1-q),PfL*q,0,PfL*(1-(q^2)),1-PfL,PfL*(q^2),PfL,0,1-PfL),nrow=3,ncol=3,byrow=T)
  resultsL = matrix(0,nrow=3,ncol=steps+1)
  
  for (j in 1:trials){
    x = vector("numeric",steps+1)
    x[1] = 1
    resultsL[1,1] = resultsL[1,1] + 1
    for (i in 1:steps){
      y = runif(1)
      p = Plow[x[i],]
      p = cumsum(p)
      if (y<=p[1]){
        x[i+1] = 1
        resultsL[1,i+1] = resultsL[1,i+1] + 1
      }else if (y<=p[2]){
        x[i+1] = 2
        resultsL[2,i+1] = resultsL[2,i+1] + 1
      }else{
        x[i+1] = 3
        resultsL[3,i+1] = resultsL[3,i+1] + 1
      }
    }
  }
  finalPropL = resultsL[,steps+1]/trials
  
  c1L = finalPropL[1]*PfL*(1-q) + finalPropL[2]*Plow[2,1] + finalPropL[3]*Plow[3,1]
  c2L = finalPropL[1]*Plow[1,2]
  c3L = finalPropL[2]*Plow[2,3]
  
  CostL = c(410,q*200,q*400)
  
  CostsL = (c(c1L*CostL[1],c2L*CostL[2],c3L*CostL[3]))
  SumL = sum(CostsL)
  rangeResultsL[a] = SumL
}
MinRL = min(rangeResultsL)
indexL = which(rangeResultsL == MinRL)
cat("\n","Best q for low class is: ",qRange[indexL],"\n","The best q results in an expected daily cost of: ",rangeResultsL[indexL],"per user","\n")
plot(rangeResultsL,type="l",ylab="Expected Daily Cost",xlab="q (in %)",main="Low Quality")

#Medium part one
trials = 100
steps = 10000
q = 0.8
PfM = 0.0002
Pmid = matrix(c(((1-PfM)+(PfM*(1-q))),PfM*q,0,0,PfM*(1-(q^2)),1-PfM,PfM*(q^2),0,PfM*(1-(q^3)),0,1-PfM,PfM*(q^3),PfM,0,0,1-PfM),nrow=4,ncol=4,byrow=T)
resultsM = matrix(0,nrow=4,ncol=steps+1)

for (j in 1:trials){
  x = vector("numeric",steps+1)
  x[1] = 1
  resultsM[1,1] = resultsM[1,1] + 1
  for (i in 1:steps){
    y = runif(1)
    p = Pmid[x[i],]
    p = cumsum(p)
    if (y<=p[1]){
      x[i+1] = 1
      resultsM[1,i+1] = resultsM[1,i+1] + 1
    }else if (y<=p[2]){
      x[i+1] = 2
      resultsM[2,i+1] = resultsM[2,i+1] + 1
    }else if (y<=p[3]){
      x[i+1] = 3
      resultsM[3,i+1] = resultsM[3,i+1] + 1
    }else{
      x[i+1] = 4
      resultsM[4,i+1] = resultsM[4,i+1] + 1
    }
  }
}
finalPropM = resultsM[,steps+1]/trials

c1M = finalPropM[1]*PfM*(1-q) + finalPropM[2]*Pmid[2,1] + finalPropM[3]*Pmid[3,1] + finalPropM[4]*Pmid[4,1]
c2M = finalPropM[1]*Pmid[1,2]
c3M = finalPropM[2]*Pmid[2,3]
c4M = finalPropM[3]*Pmid[3,4]

levels1M = resultsM[1,1:steps+1]
levels2M = resultsM[2,1:steps+1]
levels3M = resultsM[3,1:steps+1]
levels4M = resultsM[4,1:steps+1]
plot(levels1M/trials,type="l",ylim=c(0,1),xlab="Steps",ylab="Proportion",col="palegreen4",lwd=2,main="Medium Quality")
lines(levels2M/trials,col="skyblue3",lwd=2)
lines(levels3M/trials,col="tomato",lwd=2)
lines(levels4M/trials,col="navajowhite3",lwd=2)
legend("topright",legend = c("State 0","State 1","State 2","State 3"),col=c("palegreen4","skyblue3","tomato","navajowhite3"),lwd=c(2,2,2,2))

CostM = c(850,q*200,q*400,q*800)

CostsM = (c(c1M*CostM[1],c2M*CostM[2],c3M*CostM[3],c4M*CostM[4]))
SumM = sum(CostsM)
cat("\n","Stationary distribution: ",finalPropM,"\n","Proportion of phone replaced & repaired: ",c1M,c2M,c3M,c4M,"\n","Expected daily cost: ",SumM,"per user","\n")

#Medium part two
qRange = array(c(0+0.01*(0:100)))
Sim = length(qRange)
rangeResultsM = vector("numeric",Sim)
for (b in 1:Sim){
  trials = 100
  steps = 10000
  q = qRange[b]
  PfM = 0.0002
  Pmid = matrix(c(((1-PfM)+(PfM*(1-q))),PfM*q,0,0,PfM*(1-(q^2)),1-PfM,PfM*(q^2),0,PfM*(1-(q^3)),0,1-PfM,PfM*(q^3),PfM,0,0,1-PfM),nrow=4,ncol=4,byrow=T)
  resultsM = matrix(0,nrow=4,ncol=steps+1)
  
  for (j in 1:trials){
    x = vector("numeric",steps+1)
    x[1] = 1
    resultsM[1,1] = resultsM[1,1] + 1
    for (i in 1:steps){
      y = runif(1)
      p = Pmid[x[i],]
      p = cumsum(p)
      if (y<=p[1]){
        x[i+1] = 1
        resultsM[1,i+1] = resultsM[1,i+1] + 1
      }else if (y<=p[2]){
        x[i+1] = 2
        resultsM[2,i+1] = resultsM[2,i+1] + 1
      }else if (y<=p[3]){
        x[i+1] = 3
        resultsM[3,i+1] = resultsM[3,i+1] + 1
      }else{
        x[i+1] = 4
        resultsM[4,i+1] = resultsM[4,i+1] + 1
      }
    }
  }
  finalPropM = resultsM[,steps+1]/trials
  
  c1M = finalPropM[1]*PfM*(1-q) + finalPropM[2]*Pmid[2,1] + finalPropM[3]*Pmid[3,1] + finalPropM[4]*Pmid[4,1]
  c2M = finalPropM[1]*Pmid[1,2]
  c3M = finalPropM[2]*Pmid[2,3]
  c4M = finalPropM[3]*Pmid[3,4]
  
  CostM = c(850,q*200,q*400,q*800)
  
  CostsM = (c(c1M*CostM[1],c2M*CostM[2],c3M*CostM[3],c4M*CostM[4]))
  SumM = sum(CostsM)
  rangeResultsM[b] = SumM
}
MinRM = min(rangeResultsM)
indexM = which(rangeResultsM == MinRM)
cat("\n","Best q for medium class is: ",qRange[indexM],"\n","Best q results in an expected daily cost of: ",rangeResultsM[indexM],"per user","\n")
plot(rangeResultsM,type="l",ylab = "Expected Daily Cost",xlab="q (in %)",main="Medium Quality")

#High part one
trials = 100
steps = 10000
q = 0.8
PfH = 0.0001
Phigh = matrix(c(((1-PfH)+(PfH*(1-q))),PfH*q,0,0,PfH*(1-(q^2)),1-PfH,PfH*(q^2),0,PfH*(1-(q^3)),0,1-PfH,PfH*(q^3),PfH,0,0,1-PfH),nrow=4,ncol=4,byrow=T)
resultsH = matrix(0,nrow=4,ncol=steps+1)
for (j in 1:trials){
  x = vector("numeric",steps+1)
  x[1] = 1
  resultsH[1,1] = resultsH[1,1] + 1
  for (i in 1:steps){
    y = runif(1)
    p = Phigh[x[i],]
    p = cumsum(p)
    if (y<=p[1]){
      x[i+1] = 1
      resultsH[1,i+1] = resultsH[1,i+1] + 1
    }else if (y<=p[2]){
      x[i+1] = 2
      resultsH[2,i+1] = resultsH[2,i+1] + 1
    }else if (y<=p[3]){
      x[i+1] = 3
      resultsH[3,i+1] = resultsH[3,i+1] + 1
    }else{
      x[i+1] = 4
      resultsH[4,i+1] = resultsH[4,i+1] + 1
    }
  }
}
resultsH[,steps+1]
finalPropH = resultsH[,steps+1]/trials

levels1H = resultsH[1,1:steps+1]
levels2H = resultsH[2,1:steps+1]
levels3H = resultsH[3,1:steps+1]
levels4H = resultsH[4,1:steps+1]
plot(levels1H/trials,type="l",ylim=c(0,1),xlab="Steps",ylab="Proportion",col="palegreen4",lwd=2,main="High Quality")
lines(levels2H/trials,col="skyblue3",lwd=2)
lines(levels3H/trials,col="tomato",lwd=2)
lines(levels4H/trials,col="navajowhite3",lwd=2)
legend("topright",legend = c("State 0","State 1","State 2","State 3"),col=c("palegreen4","skyblue3","tomato","navajowhite3"),lwd=c(2,2,2,2))

CostH = c(950,q*200,q*400,q*800)

c1H = finalPropH[1]*PfH*(1-q) + finalPropH[2]*Phigh[2,1] + finalPropH[3]*Phigh[3,1] + finalPropH[4]*Phigh[4,1]
c2H = finalPropH[1]*Phigh[1,2]
c3H = finalPropH[2]*Phigh[2,3]
c4H = finalPropH[3]*Phigh[3,4]

CostsH = (c(c1H*CostH[1],c2H*CostH[2],c3H*CostH[3],c4H*CostH[4]))
SumH = sum(CostsH)
cat("\n","Stationary distribution: ",finalPropH,"\n","Proportion of phone replaced & repaired: ",c1H,c2H,c3H,c4H,"\n","Expected daily cost: ",SumH,"per user","\n")

#High part two
qRange = array(c(0+0.01*(0:100)))
Sim = length(qRange)
rangeResultsH = vector("numeric",Sim)
for (c in 1:Sim){
  trials = 100
  steps = 10000
  q = qRange[c]
  PfH = 0.0001
  Phigh = matrix(c(((1-PfH)+(PfH*(1-q))),PfH*q,0,0,PfH*(1-(q^2)),1-PfH,PfH*(q^2),0,PfH*(1-(q^3)),0,1-PfH,PfH*(q^3),PfH,0,0,1-PfH),nrow=4,ncol=4,byrow=T)
  resultsH = matrix(0,nrow=4,ncol=steps+1)
  for (j in 1:trials){
    x = vector("numeric",steps+1)
    x[1] = 1
    resultsH[1,1] = resultsH[1,1] + 1
    for (i in 1:steps){
      y = runif(1)
      p = Phigh[x[i],]
      p = cumsum(p)
      if (y<=p[1]){
        x[i+1] = 1
        resultsH[1,i+1] = resultsH[1,i+1] + 1
      }else if (y<=p[2]){
        x[i+1] = 2
        resultsH[2,i+1] = resultsH[2,i+1] + 1
      }else if (y<=p[3]){
        x[i+1] = 3
        resultsH[3,i+1] = resultsH[3,i+1] + 1
      }else{
        x[i+1] = 4
        resultsH[4,i+1] = resultsH[4,i+1] + 1
      }
    }
  }
  resultsH[,steps+1]
  finalPropH = resultsH[,steps+1]/trials
  
  CostH = c(950,q*200,q*400,q*800)
  
  c1H = finalPropH[1]*PfH*(1-q) + finalPropH[2]*Phigh[2,1] + finalPropH[3]*Phigh[3,1] + finalPropH[4]*Phigh[4,1]
  c2H = finalPropH[1]*Phigh[1,2]
  c3H = finalPropH[2]*Phigh[2,3]
  c4H = finalPropH[3]*Phigh[3,4]
  
  CostsH = (c(c1H*CostH[1],c2H*CostH[2],c3H*CostH[3],c4H*CostH[4]))
  SumH = sum(CostsH)
  rangeResultsH[c] = SumH
}
MinRH = min(rangeResultsH)
indexH = which(rangeResultsH == MinRH)
cat("\n","Best q for high class is: ",qRange[indexH],"\n","Best q would return an expected daily cost of: ",rangeResultsH[indexH],"per user","\n")
plot(rangeResultsH,type="l",xlab="q (in %)",ylab="Expected Daily Cost",main="High Quality")

#Part three
qRange = array(c(0+0.01*(0:100)))
Sim = length(qRange)
TotalResults = vector("numeric",Sim)
TotalResults = 0.25*rangeResultsL + 0.52*rangeResultsM + 0.23*rangeResultsH
MinTR = min(TotalResults)
indexTR = which(TotalResults == MinTR)
cat("\n","Best q for all 3 classes is: ",qRange[indexTR],"\n","It would give an expected daily cost of: ",TotalResults[indexTR],"per user","\n")
plot(TotalResults,type="l",xlab="q (in %)",ylab="Expected Daily Cost",main="Uniform q for 3 classes")

#Conclusion
totalA = rangeResultsL[indexL]*0.25 + rangeResultsM[indexM]*0.52 + rangeResultsH[indexH]*0.23
totalB = TotalResults[indexTR]
cat("\n","If Apricot can apply different q values across 3 class, then:","\n","Best q for low class: ",qRange[indexL],"\n","Best q for medium class: ",qRange[indexM],"\n","Best q for high class: ",qRange[indexH],"\n","This strategy would have an expected daily cost of: ",totalA,"per user","\n")
cat("\n","If Apricot wants a uniform q for all class, then: ","\n","Best q: ",qRange[indexTR],"\n","This strategy will have an expected daily cost of: ",totalB,"per user","\n")
