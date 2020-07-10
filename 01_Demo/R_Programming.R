#Assigning a value to a variable
x <- 3

numlist <- c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)

#,check.names=F,stringsAsFactors = F)
demo_table <- read.csv(file='demo.csv',check.names=F,stringsAsFactors = F)

library(jsonlite)

demo_table2 <- fromJSON(txt='demo.json')


#use bracket notation to select data from two-dimensional
#data structures, such as matrices, data frames, and tibbles
demo_table[3,"Year"]

#Because R keeps track of both the row indices as well as 
#the column indices as integers under the hood, we can also
#select the same data using just number indices:
demo_table[3,3]

#third way to select data from an R data frame that
#behaves very similarly to Pandas.
#using the $ operator, we can select columns from any
#two-dimensional R data structure as a single vector, similar
#to selecting a series from a Pandas DataFrame

# if we want to select the vector of vehicle classes from
#demo_table, we would use the following statement:
demo_table$"Vehicle_Class"
#what if I just want to know the second class?
demo_table$"Vehicle_Class"[2]

#---------Select Data with Logic--------
#multiple ways to subset and filter data from our larger data frames
#if we want to filter our used car data demo_table2 
#so that we only have rows where the vehicle price is greater
#than $10,000, we would use the following statement:
filter_table <- demo_table2[demo_table2$price > 10000,]
#This filter statement generates a view-only data frame tab
#listing vehicles priced greater than $10,000

filter_table2 <- subset(demo_table2, price > 10000 & drive == "4wd" & "clean" %in% title_status) #filter by price and drivetrain

#----Sample Data in R----
sample(c("cow", "deer", "pig", "chicken", "duck", "sheep", "dog"), 4)

#Step 1: Create a numerical vector that is the same length as the number
#of rows in the data frame using the colon (:) operator.
#Step 2: Use the sample() function to sample a list of indices from
#our first vector.
#Step 3: Use bracket notation to retrieve data frame rows from sample list.
demo_table[sample(1:nrow(demo_table), 3),]

#----15.2.5-----
#--------Transform---------
#use the mutate(0 function)
#if we want to use our coworker vehicle data from the demo_table and ADD A COLUMN
#for the mileage per year, as well as label all vehicles as active, we would use
#the following statement:
demo_table <- demo_table %>% mutate(Mileage_per_Year=Total_Miles/(2020-Year),IsActive=TRUE) #add columns to original data frame
#THE ABOVE CAN BE APPLIED AT ANY TIME USING DYPLR PIPE
#--------Group Data---------
#grouping across a factor allows us to quickly summarize
#and characterize our dataset around a FACTOR OF INTEREST
#(AKA character vector in R or a list of strings in Python).
#use the GROUP_BY() FUNCTION
#using value or vector instead of a list
#after this use the SUMMARIZE() FUNCTION to create columns in our
#summary DF

#if we want to group our used car data by the condition of the
#vehicle and determine the average mileage per condition, we
#would use the following dplyr statement:
summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer)) #create summary table
#we can use mean(), median(), sd(), min(), max(), and n()
#if in addition to our previous summary table we wanted to add
#the maximum price for each condition, as well as add the vehicles
#in each category, our statement would look as follows:
summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer),Maximum_Price=max(price),Num_Vehicles=n()) #create summary table with multiple columns

#---------Reshape Data----------
#gather() or spread()
demo_table3 <- read.csv('demo2.csv',check.names = F,stringsAsFactors = F)

#assign vehicle prices tab from vehicle_data to long_table
long_table <- gather(demo_table3,key="Metric",value="Score",buying_price:popularity)
#can also write the above as the following:
long_table <- demo_table3 %>% gather(key="Metric",value="Score",buying_price:popularity)

wide_table <- long_table %>% spread(key="Metric",value="Score")

#wide_table <- wide_table[,order("Vehicle", "buying_price", "luggage_boot_size", "maintenance_cost", "number_of_doors", "number_of_seats", "popularity", "safety_rating")]
wide_table <- wide_table %>% select("Vehicle", "buying_price", "luggage_boot_size", "maintainence_cost", "number_of_doors", "number_of_seats", "popularity", "safety_rating")

#aes() arguments to assign such as color, fill, shape, and size to customize the plots
#return value of the ggplot() function is our ggplot object, which is used as the base
#to build our visualizations. can add any number of plotting and formatting functions
#using an addition (+) operator


#mpg dataset is built into R and is used throughout R documentation due
#to its availability, diversity of variables, and overall cleanliness of data.


#Bar plots are used to visualize categorical data. They can be used to represent
#the frequency of each categorical value in a list of categorical data
#TASK: CREATE A BAR PLOT THAT REPRESENTS THE DISTRIBUTION OF VEHICLE CLASSES FROM
#THE MPG DATSET

#import dataset into ggplot2
plt <- ggplot(mpg,aes(x=class))
#plot a bar plot
plt + geom_bar()
# we’re only trying to visualize univariate (single variable) data.
#Therefore, we only need to assign our x argument within the aes() function

#Another use for bar plots: compare and contrast categorical results
#if we want to compare the number of vehicles from each manufacturer
#in the dataset, we can use dplyr’s summarize() function to summarize
#the data, and ggplot2’s geom_col() to visualize the results:

#create summary table
mpg_summary <- mpg %>% group_by(manufacturer) %>% summarize(Vehicle_Count=n())
#import dataset into ggplot2
plt <- ggplot(mpg_summary,aes(x=manufacturer,y=Vehicle_Count))
#plot a bar plot
plt + geom_col()

#change the titles of our x-axis and y-axis:
#we can use the xlab()and ylab() functions

#plot bar plot with labels #rotate the x-axis label 45 degrees
plt + geom_col() + xlab("Manufacturing Company") + ylab("Number of Vehicles in Dataset") + theme(axis.text.x=element_text(angle=45,hjust=1))


# if we want to compare the differences in average highway fuel
#economy (hwy) of Toyota vehicles as a function of the different
#cylinder sizes (cyl), our R code would look like the following:

#create summary table
mpg_summary <- subset(mpg,manufacturer=="toyota") %>% group_by(cyl) %>% summarize(Mean_Hwy=mean(hwy))


#import dataset into ggplot2
plt <- ggplot(mpg_summary,aes(x=cyl,y=Mean_Hwy)) 


plt + geom_line()

#add line plot with labels

plt + geom_line() + scale_x_discrete(limits=c(4,6,8)) + scale_y_continuous(breaks = c(15:30))

#if we want to create a scatter plot to visualize the relationship between
#the size of each car engine (disp) versus their city fuel efficiency (cty),
#we would create the following ggplot object:

#import dataset into ggplot2
plt <- ggplot(mpg,aes(x=displ,y=cty))

#add scatter plot with labels
plt + geom_point() + xlab("Engine Size (L)") + ylab("City Fuel-Efficiency (MPG)")


#----CUSTOM AESTHETICS-----
#alpha changes the transparency of each data point
#color changes the color of each data point
#shape changes the shape of each data point
#size changes the size of each data point

#use scatter plots to visualize the relationship between city
#fuel efficiency and engine size, while grouping by additional
#variables of interest:

#import dataset into ggplot2
plt <- ggplot(mpg,aes(x=displ,y=cty,color=class))

#add scatter plot with labels
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class")

#let's add another aesthetic!!!

#import dataset into ggplot2
plt <- ggplot(mpg,aes(x=displ,y=cty,color=class,shape=drv))

#add scatter plot with multiple aesthetics
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class",shape="Type of Drive")


#-------SKILL DRILL 15.3.4---------
plt2 <- ggplot(mpg,aes(x=displ,y=cty,color=class,size=trans))
plt2 + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class", size="Type of Transmission")


#---15.3.5 Create Advanced Boxplots in ggplot2
#if we want to generate a boxplot to visualize
#the highway fuel efficiency of our mpg dataset,
#our R code would look as follows:

#import dataset into ggplot2
plt <- ggplot(mpg,aes(y=hwy))
#add boxplot
plt + geom_boxplot()


#if we want to create a set of boxplots that
#compares highway fuel efficiency for each car
#manufacturer, our new R code would look as
#follows:

#import dataset into ggplot2
plt <- ggplot(mpg,aes(x=manufacturer,y=hwy, color=drv))
#add boxplot and rotate x-axis labels 45 degrees
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1)) + labs(x="Manufacturer", y="City Fuel-Efficiency (MPG)", color="Type of Drive")

#-------15.3.6-------
#if we want to visualize the average highway fuel
#efficiency across the type of vehicle class from
#1999 to 2008, our R code would look as follows:
  
#create summary table
mpg_summary2 <- mpg %>% group_by(class,year) %>% summarize(Mean_Hwy=mean(hwy))

plt3 <- ggplot(mpg_summary2, aes(x=class,y=factor(year),fill=Mean_Hwy))
#create a heatmap with labels
#USE GEOM_TILE() TO CREATE A HEATMAP
plt3 + geom_tile() + labs(x="Vehicle Class",y="Vehicle 
Year",fill="Mean Highway (MPG)")

#if we want to look at the difference in average
#highway fuel efficiency across each vehicle model
#from 1999 to 2008, our R code would look as follows:

#create summary table
mpg_summary2 <- mpg %>% group_by(model,year) %>% summarize(Mean_Hwy=mean(hwy))

#import dataset into ggplot2
plt3 <- ggplot(mpg_summary2, aes(x=model,y=factor(year),fill=Mean_Hwy))

#rotate x-axis labels 90 degrees
plt3 + geom_tile() + labs(x="Model",y="Vehicle Year",fill="Mean Highway (MPG)") + theme(axis.text.x = element_text(angle=90,hjust=1,vjust=.5))

#to recreate our previous boxplot example
#comparing the highway fuel efficiency
#across manufacturers, add our data points
#using the geom_point() function:
#let's name this plot "plt03"

#import dataset into ggplot2
plt03 <- ggplot(mpg,aes(x=manufacturer,y=hwy))

#add boxplot  #rotate x-axis labels 45 degrees
#overlay scatter plot on top
plt03 + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1)) + geom_point()


#what if we want to compare average engine size for
#each vehicle class?

#create summary table
mpg_summary2 <- mpg %>% group_by(class) %>% summarize(Mean_Engine=mean(displ))

#import dataset into ggplot2
plt03 <- ggplot(mpg_summary2,aes(x=class,y=Mean_Engine))

#add scatter plot
plt03 + geom_point(size=4) + labs(x="Vehicle Class",y="Mean Engine Size")


#If we compute the standard deviations in our dplyr summarize()
#function, we can layer the upper and lower standard deviation
#boundaries to our visualization using the geom_errorbar()
#function:
#import dataset into ggplot2
mpg_summary2 <- mpg %>% group_by(class) %>% summarize(Mean_Engine=mean(displ),SD_Engine=sd(displ))

#add scatter plot with labels
plt03 <- ggplot(mpg_summary2,aes(x=class,y=Mean_Engine)) 

#overlay with error bars
plt03 + geom_point(size=4) + labs(x="Vehicle Class",y="Mean Engine Size") + geom_errorbar(aes(ymin=Mean_Engine-SD_Engine,ymax=Mean_Engine+SD_Engine)) 


#suppose that we had the "long" format.

#convert to long format. Need to use gather()
mpg_long <- mpg %>% gather(key="MPG_Type",value="Rating",c(cty,hwy))

head(mpg_long)


#visualize the different vehicle fuel efficiency
#ratings by manufacturer

#import dataset into ggplot2
plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=MPG_Type))

#add boxplot with labels rotated 45 degrees
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1))

#facet the different types of fuel efficiency within the
#visualization using the facet_wrap() function.

#import dataset into ggplot2
plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=MPG_Type))

#create multiple boxplots, one for each MPG type
#rotate x-axis labels
#HERE WE ARE COMPARING TWO GRAPHS IN THE SAME GRAPH
plt + geom_boxplot() + facet_wrap(vars(MPG_Type)) + theme(axis.text.x=element_text(angle=45,hjust=1),legend.position = "none") + xlab("Manufacturer") 
#we faceted two levels/groups, but more complicated long-format
#datasets may contain measurements for multiple levels. Using
#faceting can help make data exploration of these complex
#datasets easier or can help isolate factors of interest
#for our audience.

#------SKILL DRILL 15.3.7------
#Create one or two additional plots using a different
#variable for the facet_wrap()

plt4 <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=drv))

#create multiple boxplots, one for each MPG type
#rotate x-axis labels
#HERE WE ARE COMPARING TWO GRAPHS IN THE SAME GRAPH
plt4 + geom_boxplot() + facet_wrap(vars(drv)) + theme(axis.text.x=element_text(angle=90,hjust=.5),legend.position = "none") + xlab("Manufacturer")
#we faceted two levels/groups, but more complicated long-format


#test the distribution of vehicle weights from the built-in
#mtcars dataset

#visualize distribution using density plot
ggplot(mtcars,aes(x=wt)) + geom_density()

#perform a quantitative Shapiro-Wilk test on the mtcars.
shapiro.test(mtcars$wt)

#-----15.6.1-------
#visualize the distribution of driven miles for our entire
#population dataset, we can use the geom_density() function from ggplot2

#import used car dataset
population_table <- read.csv('used_car_data.csv',check.names = F,stringsAsFactors = F)

#import dataset into ggplot2
plt <- ggplot(population_table,aes(x=log10(Miles_Driven)))

#visualize distribution using density plot
plt + geom_density()

#In this example, we want to transform our miles driven using a log10 transformation.
#This is because the distribution of raw mileage is right skewed—a few used vehicles
#have more than 100,000 miles, while the majority of used vehicles have less than
#50,000 miles. The log10 transformation makes our mileage data more normal.

#create a sample dataset using dplyr’s sample_n() function

#randomly sample 50 data points
sample_table <- population_table %>% sample_n(50)

#import dataset into ggplot2
plt <- ggplot(sample_table,aes(x=log10(Miles_Driven)))

#visualize distribution using density plot
plt + geom_density()
#By using dplyr’s sample_n() function, we can create a random sample dataset
#from our population data that contains minimal bias and (ideally) represents
#the population data.

#------15.6.2 Use the One Sample t-Test------
#if we want to test if the miles driven from our previous sample
#dataset is statistically different from the miles driven in our
#population data, we would use our t.test() function as follows:

#compare sample versus population means
t.test(log10(sample_table$Miles_Driven),mu=mean(log10(population_table$Miles_Driven))) 
#since p-value is above 0.05, we do NOT have sufficient evidence to reject null hypothesis


#let’s test whether the mean miles driven of two samples from our used
#car dataset are statistically different

#generate 50 randomly sampled data points
sample_table <- population_table %>% sample_n(50)

#generate another 50 randomly sampled data points
sample_table2 <- population_table %>% sample_n(50) 

#compare means of two samples
t.test(log10(sample_table$Miles_Driven),log10(sample_table2$Miles_Driven))

#let’s generate our two data samples using the following code:

#import dataset
mpg_data <- read.csv('mpg_modified.csv')

#select only data points where the year is 1999
mpg_1999 <- mpg_data %>% filter(year==1999)

#select only data points where the year is 2008
mpg_2008 <- mpg_data %>% filter(year==2008)

#compare the mean difference between two samples
t.test(mpg_1999$hwy,mpg_2008$hwy,paired = T)




#filter columns from mtcars dataset
mtcars_filt <- mtcars[,c("hp","cyl")]

#convert numeric column to factor
mtcars_filt$cyl <- factor(mtcars_filt$cyl)

#Now that we have our cleaned dataset, we can use our aov() function as follows:

#compare means across multiple levels
aov(hp ~ cyl,data=mtcars_filt)

summary(aov(hp ~ cyl,data=mtcars_filt))

#------15.7.1------
#we'll test whether or not horsepower (hp)
#is correlated with quarter-mile race time (qsec).

#First, let’s plot our two variables using the geom_point()
#function as follows:

#import dataset into ggplot2
plt <- ggplot(mtcars,aes(x=hp,y=qsec))

#create scatter plot
plt + geom_point()

#Next, we’ll use our cor() function to quantify the
#strength of the correlation between our two variables:

#calculate correlation coefficient
cor(mtcars$hp,mtcars$qsec)

#let’s reuse our used_cars dataset:
#read in dataset
used_cars <- read.csv('used_car_data.csv',stringsAsFactors = F)
head(used_cars)

#we'll test whether or not vehicle miles driven and
#selling price are correlated.

#import dataset into ggplot2
plt <- ggplot(used_cars,aes(x=Miles_Driven,y=Selling_Price))

#create a scatter plot
plt + geom_point()

#calculate the Pearson correlation coefficient 
cor(used_cars$Miles_Driven,used_cars$Selling_Price)

#if we want to produce a correlation matrix for our
#used_cars dataset, we would first need to select our
#numeric columns from our data frame and convert to a
#matrix. Then we can provide our numeric matrix to the
#cor() function as follows:

#convert data frame into numeric matrix
used_matrix <- as.matrix(used_cars[,c("Selling_Price","Present_Price","Miles_Driven")])
cor(used_matrix)

#create linear model
lm(qsec ~ hp,mtcars)

#summarize linear model
summary(lm(qsec~hp,mtcars))


#Once we have calculated our linear regression model,
#we can visualize the fitted line against our dataset
#using ggplot2.

#First, we need to calculate the data points to use
#for our line plot using our lm(qsec ~ hp,mtcars)
#coefficients as follows:

#create a linear model
model <- lm(qsec ~ hp,mtcars)

#determine the y-axis values from linear model
yvals <- model$coefficients['hp']*mtcars$hp + model$coefficients['(Intercept)']

#we can plot the linear model over our scatter plot
#import dataset into the ggplot
plt <- ggplot(mtcars,aes(x=hp,y=qsec))

#plot scatter and linear model
plt + geom_point() + geom_line(aes(y=yvals), color = "red")

#To better predict the quarter-mile time (qsec) dependent
#variable, we can add other variables of interest such as
#fuel efficiency (mpg), engine size (disp), rear axle
#ratio (drat), vehicle weight (wt), and horsepower (hp)
#as independent variables to our multiple linear
#regression model.

#generate multiple linear regression model
lm(qsec ~ mpg + disp + drat + wt + hp,data=mtcars)

#generate summary statistics
summary(lm(qsec ~ mpg + disp + drat + wt + hp,data=mtcars))


#if we want to test whether there is a statistical
#difference in the distributions of vehicle class
#across 1999 and 2008 from our mpg dataset, we would
#first need to build our contingency table as follows:

#generate contingency table
tbl <- table(mpg$class,mpg$year)

#compare categorical distributions
chisq.test(tbl)
