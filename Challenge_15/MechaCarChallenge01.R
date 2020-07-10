install.packages("tidyverse")
library(tidyverse)

#---------- MPG REGRESSION -----------

#1) Read the data into our RScript
MechaCar_data <- read.csv(file='MechaCar_mpg.csv', check.names=F, stringsAsFactors = F)
head(MechaCar_data)


# 2) Generate multiple linear regression model
#the best way to paint a picture of what a linear regression model is is the following:
# Y = AX_1 + BX_2 + CX_3 + DX_4, where A,B,C,D are coefficients in the real-number system
#and X_1, X_2, X_3, X_4, X_5, represent vehicle_length, vehicle_weight, spoiler_angle, ground_clearance, and AWD respectvely
#and Y represents mpg

mult_reg_model <- lm(formula = mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data = MechaCar_data)
mult_reg_model

#NOTE: technically, we can "ignore" vehicle length and spoiler angle because they have
#little to no impact on mpg. I'll just leave all variables in my equation to be as precise
#as possible.


# 3) Generate a summary of our stats
summary(mult_reg_model)

# r-squared value of this multiple linear regression model is 0.7149 or r-squared = 0.71
#about 71% of all mpg predictions are going to be correct when using this model

# p-value = 5.35e-11. Since p-value <<<< 0.05, it is safe to say that there is 
#enough evidence to reject the null hypothesis (H_0)


#--------SUSPENSION COIL SUMMARY---------
# Read the Suspension Coil data into our script
suspension_coil_data <- read.csv(file='Suspension_Coil.csv', check.names=F, stringsAsFactors = F)

# Visualizing PSI distribution using density plot
PSI_Dist_PLT <- ggplot(suspension_coil_data,aes(x=PSI)) + geom_density()
PSI_Dist_PLT
# We have a normal distribution.

shapiro.test(suspension_coil_data$PSI)
# p-value is a lot less than 0.05 so we can state that the distribution of 
# the sample PSI set is normal.

summary(suspension_coil_data$PSI)
# The Summary gives us the following information:
# (1) mean = 1498.78 (2) median = 1500 (3) min = 1452 (4) max = 1542

#Compute the Variance
var(suspension_coil_data$PSI)
# our variance in this case is 62.29356
#let's round to 2 significant figures, so we have Var = 62.29

#compute the Standard Deviation (SD)
sd(suspension_coil_data$PSI)
# the standard deviation = 7.892627
# Again, we'll use 2 Sig Figs, i.e. SD = 7.89

#-------SUSPENSION COIL T-TEST--------
#Use the T-Test for our Suspension Coil Data
t.test(x=suspension_coil_data$PSI,mu=1500)
# t = -1.8931, df = 149, p-value = 0.06028
#alternative hypothesis: true mean is not equal to 1500
#95 percent confidence interval: 1497.507 1500.053
#sample estimates: mean of x 1498.78 


