# generate a variable, display it, and check its type
var <- 100.1
var
typeof(var)

# convert the variable to another type, display, and check it type
var <- as.integer(var)
var
typeof(var)

# remove the variable from your environment
rm(var)

# generate the vectors v1, v2, v3 with 3 elements each: (10,20,30), (40,50,60), (70,80,90)
v1 <- c(10,20,30)
v2 <- c(40,50,60)
v3 <- c(70,80,90)

# generate the vector v4 with 2 elements: (100, 10)
v4 <- c(100, 10)

# take the last element of vector v4
v4[2]
tail(v4, n=1)
v4[length(v4)]

# add v1, v2, and v3
v1 + v2 + v3
c(10,20,30) + c(40,50,60) + c(70,80,90) # same thing

# add v1 (3 elements) and v4 (2 elements): what happens? warning
v1 + v4
# check why 
v1
v4

# generate the vector v5 with 4 elements: (1, 2, 3, 4)
v5 <- c(1,2,3,4)
v5 <- 1:4

# add v4 (2 elements) + v5 (4 elements): what happens? 
v4 + v5
# check why
v4
v5

# why? vector recycling https://rpubs.com/vipero7/vector-recycling-in-r
# takehome: be careful with vector operations on vectors of different length

# sum the elements of v1
sum(v1)

# check if v1 has missing data
is.na(v1)
anyNA(v1)

# combine the vectors v1, v2, v3 to create the matrix m1
all_v <- c(v1, v2, v3)
m1 <- matrix(all_v, nrow=3, ncol=3, byrow=TRUE)
m1

# take the entire second row of m1, it should give back v2
m1[2,]

# take the first two elements in the first row of m1
m1[1, 1:2]  



  
######################
# EXTRA: MORE PRACTICE
######################

# generate a matrix, m3, with 4 elements (1 to 4)
m3 <- matrix(c(1,2,3,4), nrow=2, ncol=2, byrow=TRUE)
m3

# calculate the row sum and the column sum of m3
rowSums(m3) 
colSums(m3)
m3

# at the end of m3, add a new column with the sum of m3 elements
cbind(m3, rowSums(m3))

# inspect the matrices m1 and m3 
m1
m3

# add m1 (3x3) and m3 (2x2): what happens? not allowed
# matrices must be conformable to perform algebraic operations
m1 + m3

# make m3 conformable and try again (tip: add vectors of 0 to it)
m3
m3 <- cbind(m3, c(0,0,0))
m3 <- rbind(m3, c(0,0,0))
m3
m1 + m3

# calculate the dot product of v1 and v2
# sum of the products of the corresponding entries in two vectors
# (40*10) + (50*20) + (60*30) 
v1 %*% v2 
# or
sum(v1*v2)

# calculate the average of the elements of v1
mean(v1)

# calculate the average of v1, v2, v3 at once
list_vec <- list(v1, v2, v3)
for (i in list_vec)
  print(mean(i))

# take the 1st element of each vector (v1, v2, v3) and create a new vector: v_first
v_first <- c(v1[1], v2[1], v3[1])

# take the last element of each vector (v1, v2, v3) and create a new vector: v_last
v_last <- c(v1[length(v1)], v2[length(v2)], v3[length(v3)])

# label the elements of the vector v1 as "x", "y", "z"
names(v1) <- c("x", "y", "z")
names(v2) <- letters[1:4]
names(v3) <- letters[5:8]
v1
print(v2)
print(unname(v2))

# generate a new matrix, m2, with 9 elements (1 to 9)
# default is byrow=FALSE since R fills the matrix by column
m2 <- matrix(1:9, nrow=3, ncol=3, byrow=TRUE)
m2
m2_bycolumn <- matrix(1:9, nrow=3)
m2_bycolumn

# label the columns and rows of the matrix m2 as "a", "b", "c"
colnames(m2) <- letters[1:3]
rownames(m2) <- c("a", "b", "c")

# multiply m1 by m2 (element-wise)
m1 * m2

# multiply m1 by m2 (algebraic): where does the number at position 1,1 come from?
m1 %*% m2

# divide m1 by m2 (element-wise)
m1 / m2

# transpose m1, assign it to "m1T", multiply m1T by m1
m1T <- t(m1)
m1
m1T
m1T %*% m1

# same thing in one line
crossprod(m1)

# combine the vectors v1, v2, v3 to create the data frame d
d <- data.frame(v1, v2, v3)
