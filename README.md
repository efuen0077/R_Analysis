# R_Analysis

## Challenge
Files are in "Challenge_15" folder.
[MechaCarWriteUp.txt](https://github.com/efuen0077/R_Analysis/files/4901492/MechaCarWriteUp.txt)

### MPG Regression

1) The variables/coefficient that provided a non-random amount of variance to the mpg value in the dataset
are: "Vehicle Length" (Pr(>|t|) = 2.60e-12) and "Ground Clearance" (Pr(>|t|) = 6.551 5.21e-08) Both of these variables hardly have any effect on the mpg levels.

2) The slope of the linear model is NOT zero because the mpg is not the same at all times when taking all variables into account.

3) This linear model predicts mpg of MechaCar prototypes effectively because r-squared value of this multiple linear regression model is 0.7149 or r-squared = 0.71. About 71% of all mpg predictions are going to be correct.

### Suspension Coil Summary

[Rplot_density_vs_PSI.pdf](https://github.com/efuen0077/R_Analysis/files/4901464/Rplot_density_vs_PSI.pdf)

1) Summary stats table for the suspension coil's pounds per inch continuous variable.
-------Mean: 1498.78
-------Median: 1500
-------Variance: 62.29
-------Standard Deviation: 7.89
2) The design specifications for the MechaCar suspension coils dictate that the variance of the suspension coils must not exceed 100 pounds per inch.The current manufacturing data met this design specification because our variance is 62.29 and, thus, does NOT exceed 100 Lb/in.

### Suspension Coil T-Test

1) The population mean is 1500 Lb/in. For H_0, there is not statistical difference between the sample and population mean. Now, for H_a, there IS a statistical difference.

2) The t-test yielded the following results:
---p-value = 0.06028
---t = -1.8931
---mean of x = 1498.78
