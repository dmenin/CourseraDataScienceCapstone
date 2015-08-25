library(reshape2)


lambda = 0.2
n = 40
sim_number <- 1:1000
rexp_means <- replicate(1000,mean(rexp(n, lambda)))
dfmeans <- data.frame (sim_number, rexp_means)








#1.Show where the distribution is centered at and compare it to the theoretical center of the distribution.


#The mean of exponential distribution is 1/lambda, which is:
1/lambda

#and very close to where the distribution is centered (mean of "means of 40 samples from the distributions"), whihc is:
mean(dfmeans$rexp_means)



#Show how variable it is and compare it to the theoretical variance of the distribution



#according to the Central Limit Theorem, the expected variance can be calculated by (standard deviation / (square root of n)) ^ 2
#We are told that the standard deviation of exponential distribution is 1/lambda and n is 40 so the expected variance is:

stddev <- 1/lambda
denominator <- sqrt(n)

expected_variance <- (stddev / denominator) ^ 2


#And the actual variance of the distribution is
var(dfmeans$rexp_means)


#3. Show that the distribution is approximately normal.
ggplot(dfmeans, aes(x=rexp_means)) + geom_histogram(aes(fill = ..count..))


#4.Evaluate the coverage of the confidence interval for 1/lambda: 
#X ± 1.96 (S/???n )



dfmean <- mean(dfmeans$rexp_means)
standarderror <- sd(dfmeans$rexp_means) /  sqrt(40)

cintervalfrom <- (dfmean) - (1 * 1.96 * standarderror)
cintervalto <- (dfmean) + (1 * 1.96 * standarderror)



#part2
t <- ToothGrowth
t$dose <- factor(t$dose)
levels(t$supp) <- c("Orange Juice", "Ascorbic Acid")

The first conclusion we can get is that Vitamin C does affect the teeth length. 
If we ignore the delivery method for a moment and jusdt compare dosage with length, well see that Guinea Pigs that got 0.5 mg got an average of   10.61 mm increase (with a max of 21.5mm)
and Pigs that got 2 dosages increased on average 26.10mm (with a max of 33.9mm)

ddply(t, 'dose', summarise, average_growth = mean(len), max_growth  = max(len))



If we bring the delivery method into consideration, Oranje juice seems to be the best oprion when dosage is 0.5 or 1.
On smaller doses (0,5mg), the average teeth growth was 65% better on orange juice than on ascorbic acid (13.23mm against 7.98mm)
On medium doses the behaviour is the same with a 35% better performance on Orange Juice (22.7mm against 16.77)

When the dosage is higher on the other hand, on average, Ascorbic Acid seems to have a slitgly advantage over Orange juice 26.14 over 26.06

 tapply(t$len, list(t$supp, t$dose), mean)





#Use confidence intervals and hypothesis tests to compare tooth growth by supp and dose. (Use the techniques from class even if there's other approaches worth considering)

We are going to perfor 2 tests, 0.5mg dosage versus 1 mg dosage and 1mg dosage vs 2mg dosage

t1 <- subset(t, dose %in% c(0.5,1))
t.test(len ~ dose, paired=FALSE, var.equal=FALSE, data=t1)


t2 <- subset(t, dose %in% c(1,2))
t.test(len ~ dose, paired=FALSE, var.equal=FALSE, data=t2)






