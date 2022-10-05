# Optimising a Phone Manufacturer's Warranty Scheme Using Simulations & Markov Chains

### Problem Statement
A phone manufacturer, Apricot, has 3 class of products, low, medium, and high class phones, and is planning to offer lifetime warranties for its customers. 
For each class of phone, a replacement will be issued when a phone experiences a fault and can't be repaired on the same day. Further, a replacement will 
also be given if a phone reaches a certain number of faults (2 for low class, and 3 for middle & high class). Given the probabilities and costs associated 
to faults, same-day repairs, and replacements, how can the phone company optimise its warranty scheme to minimise costs?

### Assumptions

1. The probability of having a fault in any day is denoted by p. There is no chance of having more than 1 fault in a day.
2. A phone brought into a store will first be checked. Assuming that phone has had its i<sup>th</sup> fault (i = 0,1,2..., n-1), the probability
    of it being repaired in the same day is q<sup>i+1</sup>. Otherwise, it will be immediately replaced with a replacement of the same quality and
    warranty as a new phone.
3. If a phone has its n<sup>th</sup> fault, then it is directly replaced.
4. The replacement cost is denoted £ R, while cost of repair for the i<sup>th</sup> fault is equal to £ (2<sup>i</sup>·q·100).
5. For each class,
- Low (25% of products): n = 3, R = 410, p = 0.0005
- Medium (52% of products): n = 4, R = 850, p = 0.0002
- High (23% of products): n = 4, R = 910, p = 0.0001

**Model Explanation:**

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

π = (π<sub>0</sub>, π<inf>1</inf>, π<inf>2</inf>)

represents the daily proportion of phones in each state over the long
run. (π~0~ + π~1~ + π~2~ = 1)

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

Next, the model multiplies the 2^nd^,4^th^, and 5^th^ point with π~0~,
π~1~, and π~2~, respectively. Summing these will result in the
proportion of phone that needs to be replaced. Denote this by c~1~.

Then, it multiplies the 1^st^ point with π~0~ and the 3^rd^ point with
π~1~. The former will give the proportion of phones that needs to have
its first fault repaired (denote this by c~2~), while the latter will
give the proportion of phones that needs to have its second fault
repaired (denote this by c~3~).

Hence, we can see that the expected daily cost would be:

c~1~\*R + c~2~\*(200q) + c~3~\*(400q)

which, if we substitute c1, c2, and c3, with p and q, becomes:

\[p(1-q)π~0~ + p(1-q^2^)π~1~ + pπ~2~\]\*R + pqπ~0~\*(200q) +
pq^2^π~1~\*(400q)

Using the same logic, the expected daily cost for medium and
high-quality phones would be given by:

\[p(1-q)π~0~ + p(1-q^2^)π~1~ + p(1-q^3^)π~2~ + pπ~3~\]\*R +
pqπ~0~\*(200q) + pq^2^π~1~\*(400q) + pq^3^π~2~\*(800q)

Where π = (π~0~, π~1~, π~2~, π~3~) represents the stationary
distribution.

For each class and each value of q, the model will compute the expected
daily cost. If Apricot chooses to apply different q's across different
classes, then the model picks the most cost-efficient q from each class.
On the other hand, if Apricot chooses to apply a uniform q for all 3
classes, then it will sum the expected daily cost of the 3 classes
according to their proportion and pick the q that results in the lowest
sum.

