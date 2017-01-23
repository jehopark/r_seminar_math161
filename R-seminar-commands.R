## HMC R Seminar 2017
## Owner: Jeho Park
## Created: Jan 2017 (adapted from CIS R Workshop)
## Updated: Jan 23, 2017
## Github URL: https://github.com/jehopark/r_seminar_math161.git

# Some General Stuff ----
demo() # display available demos
demo(graphics) # try graphics demo
library() # show available packages on the computer
search() # show loaded packages
?hist # search for the usage of hist function
??histogram # search for package documents containing the word "histogram"

# Workspace of R ----
a <- 5 # notice a in your Environment window
A <- "text" 
a
A
ls()
print(c(a,A))

# Look Ma, R can do Math!  ---------
1+1
2+runif(1,0,1)
2+runif(1,min=0,max=1)
3^2
3*3
sqrt(3*3) # comments
# comments are preceded by hash sign

# Even More Math! ----

integrand <- function(x) {1/((x+1)*sqrt(x))} ## define the integrated function
integrate(integrand, lower=0, upper=Inf) ## integrate the function from 0 to infinity

# Vectors -----------
# A vector is an array object of the same type data elements.
class(a)
class(A)
B <- c(a,A) # concatenation
B # see the values
class(B) # why characters?

a <- rnorm(10)
a[3:5] <- NA # NA is a missing value
a
# Matrices ----
# A matrix is a two-dimensional rectangular object of the __same type__ (homogeneous) data elements. 
mat <- matrix(rnorm(6), nrow = 3, ncol = 2) 
mat # a matrix
dim(mat) # dimension
t(mat)
summary(mat) 

# Lists -------------
# A list is an object that can store different types of vectors. 
aList <- list(name=c("Joseph"), married=T, kids=2)
aList
aList$kids <- aList$kids+1
aList$kids
aList2 <- list(numeric_data=a,character_data=A)
aList2
allList <- list(aList, aList2)
allList # a list of lists

# Data frames ----------
# A data frame is used for storing data tables. It is a list of vectors of equal length. 
n <- c(2, 3, 5) # a vector 
s <- c("aa", "bb", "cc") # a vector
b <- c(TRUE, FALSE, TRUE) # a vector
df <- data.frame(n, s, b) # a data frame
df
mtcars # a built-in (attached) data frame
mtcars$mpg

# Data fremes (Cont.)
myFrame <- data.frame(y1=rnorm(100),y2=rnorm(100), y3=rnorm(100))
head(myFrame) # display first few lines of data
names(myFrame) # display column names
summary(myFrame) # output depends on the data types
plot(myFrame)
myFrame2 <- read.table(file="http://scicomp.hmc.edu/data/R/Rtest.txt", header=T, sep=",")
myFrame2

# Factors ------------
# Factors are a special compoud object used to represent categorical data such as gender, social class, etc.
# Factors have 'levels' attribute. They may be nominal or ordered.
v <- c("a","b","c","c","b")
x <- factor(v) # turn the character vector into a factor object
z <- factor(v, ordered = TRUE) # ordered factor
x
z
table(x)

# Converting between different types ----
# Use of the as() family of functions. 
# Type as. and wait to see the list of as() functions.

integers <- 1:10
as.character(integers)
as.numeric(c('3.7', '4.8'))
indices <- c(1.7, 2.3)
integers[indices] # sometimes R is too generous
integers[0.999999999] # close to 1 but...
df <- as.data.frame(mat)
df

# Getting help online and offline ------
# See slides for more information

=======

## Working with Data -----

# Working with Raw Data -----
# Data import from a local folder
cpds <- read.csv(file.path('.', 'data', 'cpds.csv'))
head(cpds) # good to look at a few lines
class(cpds) # data.frame
# Data import from the Internet
data <- read.table(file="http://scicomp.hmc.edu/data/R/normtemp.txt", header=T)
tail(data) # show the last few lines
# Data import (advanced)
rta <- read.table("./data/RTADataSub.csv", sep = ",", head = TRUE)
dim(rta)
rta[1:5, 1:5]
class(rta)
class(rta$time) # what? let's see ?read.table more carefully
rta2 <- read.table("./data/RTADataSub.csv", sep = ",", head = TRUE, stringsAsFactors = FALSE)
class(rta2$time)

## Data Export -----
# Use write.table() to write data to a CSV file
write.csv(data, file = "temp.csv", row.names = FALSE) 
# Writing out plots
pdf('myplot.pdf', width = 7, height = 7) # call pdf() before calling plot()
x <- rnorm(10); y <- rnorm(10)
plot(x, y)
dev.off()

## Subsetting --------
# Three operators: [, [[, and $
x <- c("a", "b", "c", "c", "d", "a") # a character vector
x[1]
x[1:4]
x[x > "a"] 
u <- x > "a" # what's u here?
u
x[u] # subsetting using a boolean vector
y <- list(foo=x, bar=x[u])
y
y[[1]]
y$bar

## Data frame vs matrix ------
m = matrix(1:400000, 2, 200000) # esp. for a large number of columns!
d = as.data.frame(m)
object.size(m) # 1600200 bytes
object.size(d) # 22400568 bytes

## Module 2: Working with data (Part 2) ----
attach(mtcars) # Attach mtcars to search path
plot(wt, mpg) # notice objects are called by their names, not mtcars$wt
plot(wt, mpg, 
     main = "Regression of MPG on Weight",
     xlab = "Weight", 
     ylab = "MPG")
plot(wt, mpg, ann = FALSE) 

# Changing/adding the details afterwards
abline(h=25) # a reference line
abline(lm(mpg~wt)) # look at the argument, what's lm?
title(main = "Regression of MPG on Weight", xlab = "Weight", ylab = "MPG")

## Manipulating graphs (base package) ----
par()              # view current settings
orig_par <- par()  # save current settings
par(col.lab="red") # red x and y labels 
plot(wt, mpg)      # create a plot with these new settings 
par(orig_par)      # restore original settings
plot(wt, mpg)
plot(wt, mpg, col.lab="red") # change settings withing plot()
?par # see all the options

## Managing R Project ----
save.image("r-bootcamp.Rdata") # save workspace  
rm(list=ls()) # remove all objects
load("r-bootcamp.Rdata") # bring the workspace back
save.image() # by default it saves workspace to .Rdata 

curr_wd <- getwd() # returns absolute path to the working directory
setwd("data") # change working directory to data folder
setwd(file.path('~', 'Desktop'))

## Managing R Project (cont.) ----
require("datasets") # load/attach datasets
ls('package:datasets') 
airmiles # airmiles object in datasets package
airmiles <- 0 # Oops! overwritten?
datasets::airmiles # package namespace
rm(airmiles) # removes user defined object airmiles

## Module 4: Programming in R ----

mult_fun <- function(a = 1, b = 1) {
  return(a*b)
}

mult_fun  # show the function's code
mult_fun(2,3) # function call
mult_fun() # would this be an error?

x <- 10; y <- 20
x + y
`+`(x, y)

## Loops ----
for(i in 1:10) {
  print(i)
}

# While loops
i <- 0
while(i < 5) {
  i <- i + 1 
  print(i)
}


## Vectorization ----
########## a bad loop, with 'growing' data
set.seed(42);
m=1000; n=1000;
mymat <- replicate(m, rnorm(n)) # create matrix of normal random numbers
system.time(
  for (i in 1:m) {
    for (j in 1:n) {
      mymat[i,j] <- mymat[i,j] + 10*sin(0.75*pi)
    }
  }
)

set.seed(42);
m=1000; n=1000;
mymat1 <- replicate(m, rnorm(n))
system.time(
  mymat1 <- mymat1 + 10*sin(0.75*pi)
)


## Debugging R Code ----

## Good Coding Styles ----
average <- mean(feet / 12 + inches, na.rm = TRUE)
average<-mean(feet/12+inches,na.rm=TRUE)

if (y < 0 && debug) {
  message("Y is negative")
} else {
  message("Y is not negative")
}


