# intro to basic R notes

# whatever is typed after the # sign is a comment
# to execute code: ctrl + enter OR highlight it and press "Run"

# DATA TYPES
# Double        1.2, 3.5, 0, -1 (default datatype for numbers)
# Integer       1, 2, 3, 4      
# Logical       TRUE or FALSE   (boolean)
# Character     "hello!", "1.2" (strings)
# Complex       1 + 2i          (numbers with an imaginary component)
# Raw           "hi", 1 2.5     (mix of types)

# DATA STRUCTURES
# Vectors       1d, same data type
# Matrices      2d, same data type
# Lists         1d, different data types
# Data Frames   2d, different data types
# Arrays
# Factors
# Functions


##################################################
# DATA TYPES: DOUBLE, INTEGER, LOGICAL, CHARACTER
##################################################

# create a variable of each type
my_double <- 99.9
my_int <- 1L
my_char <- "what a beautiful day"
my_logical <- FALSE

# another way to create the same variables
my_double <- as.numeric(99.9)
my_int <- as.integer(1)
my_char <- as.character("what a beautiful day")
my_logical <- as.logical(FALSE)

# display the variable and check its type
my_int
typeof(my_int)

# using variables: ex. 1
result <- my_int + 2
print(result)
result*2

# using variables: ex. 2
hi <- "Hello"
name <- "Sabrina"
message <- paste(hi, name)
message

# convert integer to numeric/double data type, save as new variable "a"
a <- as.numeric(my_int)    
typeof(a)
typeof(my_int) 
 
# convert numeric to logical
b <- as.logical(my_double)
typeof(b)
typeof(my_double)

# if you cannot convert among data type: error
# character to numeric/double - cannot do it
my_char
c <- as.numeric(my_char)

# numeric/double to character - can do it
my_double
d <- as.character(my_double)

# on variable names: https://r4ds.had.co.nz/workflow-basics.html?q=name#whats-in-a-name


#################################
# CHECK AND CLEAR THE ENVIRONMENT
#################################

# check all objects in memory so far
ls()

# remove the numeric variable "my_double" from memory
rm(my_double)

# remove selected variables from memory
rm(my_int, my_char)

# remove all variables beside one
rm(list=setdiff(ls(), "my_logical"))

# remove all variables (use with caution!)
rm(list = ls())

# get help
help.search("remove objects")
?rm
help(rm)


###########
# OPERATORS
###########

# ASSIGNMENT OPERATORS
x <- 5    # store value 5 into variable x
X<-5      # spacing does not matter
x = 5     # can also use = but for R it's better practice to use <-
x         # evaluate the expression and print results
print(x)  # same

# RELATIONAL OPERATORS
1 == 1    # equality (TRUE or FALSE)
1 != 1    # inequality (TRUE or FALSE)
x < y     # less than
x <= y    # less than or equal to (see also  "<", ">", and ">=")

# LOGICAL OPERATORS
x | y     # x OR y
x & y     # y AND y
!x        # is not 


# ARITHMETIC OPERATORS 
x <- 10
y <- 2
x + y     # + addition
x - y     # - subtraction
x * y     # * multiplication
x / y     # / division
x^y       # ^ exponentiation can also use **
x %% y    # modulo
m %*% n   # matrix multiplication


######################################################################
# DATA STRUCTURES: VECTORS (1d seq. of elements of the same basic type)
######################################################################

# create a numeric vector of size 4, using the c() function
num_vec <- c(4, 10, 70, 500)   
num_vec

# check vector type
is.numeric(num_vec) # includes both integer and double
is.integer(num_vec) # default is double
is.double(num_vec)  

# create a character vector and a logical/boolean vector, both of size 3
char_vec <- c("a", "b", "c") 
log_vec <- c(TRUE, FALSE, TRUE)

# what happens if you mix data types inside a vector?
mixed_vec <- c(9, "a", TRUE)
typeof(mixed_vec)  # all elements coerced into the least restrictive type (string)

# count of elements
length(num_vec) 

# accessing elements of a vector, use [] brackets
num_vec
num_vec[1]         # take 1st element 
num_vec[1:2]       # take a slice with the first 2 elements
num_vec[c(1,3)]    # take 1st and 3rd elements
num_vec[-1]        # take all but the 1st element
num_vec[c(-1,-3)]  # take all but the 1st and 3rd element
num_vec[-c(1,3)]   # same thing
num_vec[c(-1,3)]   # error! do not mix negative and positive subscripts
num_vec[!is.na(num_vec)]    # take all non null elements of "num_vec"
num_vec[num_vec %% 2 == 0]  # take all even values of "num_vec"

# modifying elements of a vector 
num_vec[2] <- 20              # modify 2nd element to the value of 20
num_vec[num_vec <= 4] <- 0    # modify elements equal or lower than 4 to 0


#########################################################################################
# DATA STRUCTURES: LISTS (like vectors but can hold a mix of data types at the same time)
#########################################################################################

# create a list with list()
l <- list(3, "ciao", FALSE, 3.3)
typeof(l)

# notice that a list can hold many different things
l2 <- list( c(1,2,4,5,6), 
            "ciao", 
            FALSE, 
            matrix(c(9,8,1,2), nrow=2) )
l2

# elements of a list can have names
named_list <- list(a=(c(1,2,3)), b="ciao", c=3.3)
typeof(named_list)

# use [] to access lists in list
named_list[1]

# use [[]] to access the elements stored in a list
named_list[[1]]   # 1st element
named_list[["a"]] # 1st element by name

# combine [[]] and [] to access specific elements values
named_list[[1]][1]
named_list[["a"]][1]


######################################################################################
# DATA STRUCTURES: MATRICES (2d generalization of vectors, hold data of the same type)
######################################################################################

# create a matrix with 9 elements, matrix are filled column-wise
m <- matrix(c(1,2,3,4,5,6,7,8,9), nrow=3, ncol=3)
m

# unless you specify filling by row with byrow=TRUE
m <- matrix(c(1:9), nrow=3, ncol=3, byrow=TRUE)
m

# accessing elements of a matrix
m[1,2]    # 1st row, 2nd col
m[2,1]    # 2nd row, 1st col
m[1,]     # select entire 1st row
m[,1]     # select entire 1st col
m[1:2,2]  # first two rows, second col
m[1,1:2]  # first row, first two elements
m[c(1,2),c(2,3)] # 1st and 2nd row, 2nd and 3rd column

# modifying elements of a matrix
m[m <= 3] <- 1  # change to 1 all values lower or equal than 3
m


##################################################
# EXTRA: OTHER WAYS TO CREATE VECTORS AND MATRICES
##################################################

# create a numeric vector of size 4, using the assign() function
assign("v", c(2, 11.5, 100, 200))

# create a vector of consecutive numbers 
v <- 1:5    # same as c(1,2,3,4,5)

# repeat 1,2,3 twice
v <- rep(1:3, times=2)

# create a sequence of numbers between 1 and 10 in jumps of 2
v <- seq(from=1, to=10, 2)

# create an empty vector (many ways)
empty_vec <- c()
empty_vec <- NULL
empty_vec <- numeric() 

# fill the empty vector with values
values <- c(1, 10.5, 49)
for (i in 1:length(values))
  empty_vec[i] <- values[i]

# take a vector, v, and turn it into a 2 x 5 matrix
v <- 1:10
dim(v) <- c(2,5)
v

# create a matrix by combining columns or rows
x <- 1:3
y <- 10:12
cbind(x, y)
rbind(x, y)


#################################################################
# DATA STRUCTURES: DATA FRAMES (list of vectors of equal length)
# behave a lot like matrices but can store data of multiple types
#################################################################

# create a dataframe from our previous vectors (same data type: all numeric)
v1 <- c(1,2,3)
v2 <- c(4,5,6)
v3 <- c(7,8,9)
d <- data.frame(v1, v2, v3)
d

# create a data frame with different data type
d <- data.frame(c(1:4), 
                c(20,25,30,32), 
                c("M", "NB", "F", "F"))
d

# label the three columns: id, age, gender
d <- data.frame(id = c(1:4), 
                age = c(20,25,30,32), 
                gender = c("M", "NB", "F", "F"))
d
(d[,"gender"])

# check the class of "d" and of each column
class(d)
sapply(d,class)

# some useful data frame functions
str(d)    # structure of the dataframe (name, type, preview data)
dim(d)    # dimensions of the dataframe
head(d)   # shows first 6 rows
tail(d)   # shows last 6 rows
nrow(d)   # number of rows
ncol(d)   # number of columns
colnames(d) # column names
rownames(d) # row names

# accessing elements of a data frame, like accessing matrices elements
d
d[1,3]    # element in the 1st row, 3rd col
d[3,]     # get the entire 3rd row
d[,3]     # get the entire 3rd column
d[,"gender"]    # get the entire 3rd column using its name
d[1:2, "age"]   # first two values of column "age"

# accessing elements of a data frame, like you access lists elements
d
d[[3]]          # get the entire 3rd column using its position 
d[["gender"]]   # get the entire 3rd column using its name

# data frames provide additional options for accessing elements: $ 
d$id       # get the column "id"
d$id[3]    # get the third element of column "id"

# accessing elements using subset()
subset(d, subset = gender == "F")


###########
# RESOURCES
###########

# see our website under today's topic for more resources for further practice

