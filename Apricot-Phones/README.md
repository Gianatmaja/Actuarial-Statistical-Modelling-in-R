# Optimising a Phone Manufacturer's Warranty Scheme Using Simulations & Markov Chains

### Problem Statement
A phone manufacturer, Apricot, has 3 class of products, low, medium, and high class phones, and is planning to offer lifetime warranties for its customers. 
For each class of phone, a replacement will be issued when a phone experiences a fault and can't be repaired on the same day. Further, a replacement will 
also be given if a phone reaches a certain number of faults (2 for low class, and 3 for middle & high class). Given the probabilities and costs associated 
to faults, same-day repairs, and replacements, how can the phone company optimise its warranty scheme to minimise costs? More specifically, what proportion of the faults should the company plan accomodate for same day repairs?

### Assumptions

1. The probability of having a fault in any day is denoted by p. There is no chance of having more than 1 fault in a day.
2. A phone brought into a store will first be checked. Assuming that phone has had its i<sup>th</sup> fault (i = 0,1,2..., n-1), the probability
    of it being repaired in the same day is q<sup>i+1</sup>. Otherwise, it will be immediately replaced with a replacement of the same quality and
    warranty as a new phone. Currently, q = 0.8
3. If a phone has its n<sup>th</sup> fault, then it is directly replaced.
4. The replacement cost is denoted £ R, while cost of repair for the i<sup>th</sup> fault is equal to £ (2<sup>i</sup>·q·100).
5. For each class,
    - Low (25% of products): n = 3, R = 410, p = 0.0005
    - Medium (52% of products): n = 4, R = 850, p = 0.0002
    - High (23% of products): n = 4, R = 910, p = 0.0001

### Model Explanation

The method of modelling used in this analysis utilizes Markov chain. Let
each state number represent the number of faults a phone has recorded.
Based on the stated assumptions, a phone can only be either in state 0,
1, 2..., n-1 as it is replaced as soon as it has its n<sup>th</sup> fault.

The probabilities of going from one state to another are shown by a
transition matrix. For a phone, its current state in the Markov chain
represents the number of faults it has experienced and repaired up to
the current day. For the low-quality phones, the transition matrix is:

$$\begin{pmatrix}
(1 - p) + p(1 - q) & \text{pq} & 0 \\
p\left( 1 - q^{2} \right) & 1 - p & pq^{2} \\
p & 0 & 1 - p \\
\end{pmatrix}$$

with states {0, 1, 2}.

Meanwhile, the transition matrix for medium and high-quality phone is:

$$\begin{pmatrix}
(1 - p) + p(1 - q) & \text{pq} & 0 & 0 \\
p\left( 1 - q^{2} \right) & 1 - p & pq^{2} & 0 \\
p\left( 1 - q^{3} \right) & 0 & 1 - p & pq^{3} \\
p & 0 & 0 & 1 - p \\
\end{pmatrix}$$

with states {0, 1, 2, 3}.

For each p and q values, the model will obtain the corresponding
transition matrix. Simulating this Markov chain for a large number of
times results in an estimation for the stationary distribution. A
stationary distribution of a Markov chain is the stable distribution
that is achieved after a period of time and one that remains unchanged
over time once achieved. In other words, it estimates the long-term
proportion of phones which are in state 0, 1, 2, up to n-1 in any given
day.

After obtaining the stationary distribution, the model will then extract
the required probability of a state going to another particular state
from the corresponding transition matrix. It will then compute the
expected daily cost using the obtained information.

To illustrate this,

For the low-quality phones, consider π to be the stationary
distribution. Then

π = (π<sub>0</sub>, π<sub>1</sub>, π<sub>2</sub>)

represents the daily proportion of phones in each state over the long
run. (π<sub>0</sub> + π<sub>1</sub> + π<sub>2</sub> = 1)

To add to the daily cost, a phone would have to be either repaired or
replaced. We then extract the probabilities of the following events from
the transition matrix.

-   A phone with zero initial faults gets one and needs to be repaired.

-   A phone with zero initial faults gets one and needs to be replaced.

-   A phone with one initial fault gets another one and needs to be
    repaired.

-   A phone with one initial fault gets another one and needs to be
    replaced.

-   A phone with two initial faults gets another one. This phone will
    immediately be replaced.

Next, the model multiplies the 2<sup>nd</sup>,4<sup>th</sup>, and 5<sup>th</sup> point with π<sub>0</sub>,
π<sub>1</sub>, and π<sub>2</sub>, respectively. Summing these will result in the
proportion of phone that needs to be replaced. Denote this by c<sub>1</sub>.

Then, it multiplies the 1<sup>st</sup> point with π<sub>0</sub> and the 3<sup>rd</sup> point with
π<sub>1</sub>. The former will give the proportion of phones that needs to have
its first fault repaired (denote this by c<sub>2</sub>), while the latter will
give the proportion of phones that needs to have its second fault
repaired (denote this by c<sub>3</sub>).

Hence, we can see that the expected daily cost would be:

![Eq1](https://github.com/Gianatmaja/Actuarial-Statistical-Modelling-in-R/blob/main/Apricot-Phones/Images/Screenshot%202022-10-05%20at%2011.19.33%20AM.png)

which, if we substitute c1, c2, and c3, with p and q, becomes:

![Eq2](https://github.com/Gianatmaja/Actuarial-Statistical-Modelling-in-R/blob/main/Apricot-Phones/Images/Screenshot%202022-10-05%20at%2011.19.40%20AM.png)

Using the same logic, the expected daily cost for medium and
high-quality phones would be given by:

![Eq3](https://github.com/Gianatmaja/Actuarial-Statistical-Modelling-in-R/blob/main/Apricot-Phones/Images/Screenshot%202022-10-05%20at%2011.19.51%20AM.png)

Where π = (π<sub>0</sub>, π<sub>1</sub>, π<sub>2</sub>) represents the stationary
distribution.

For each class and each value of q, the model will compute the expected
daily cost. If Apricot chooses to apply different q's across different
classes, then the model picks the most cost-efficient q from each class.
On the other hand, if Apricot chooses to apply a uniform q for all 3
classes, then it will sum the expected daily cost of the 3 classes
according to their proportion and pick the q that results in the lowest
sum.

### Results

