# generate a variable, display it, and check its type


# convert the variable to another type, display, and check it type


# remove the variable from your environment


# generate the vectors v1, v2, v3 with 3 elements each: (10,20,30), (40,50,60), (70,80,90)


# generate the vector v4 with 2 elements: (100, 10)


# take the last element of vector v4


# add v1, v2, and v3


# add v1 (3 elements) and v4 (2 elements): what happens? warning


# generate the vector v5 with 4 elements: (1, 2, 3, 4)


# add v4 (2 elements) + v5 (4 elements): what happens? 


# why? vector recycling https://rpubs.com/vipero7/vector-recycling-in-r
# takehome: be careful with vector operations on vectors of different length


# sum the elements of v1


# check if v1 has missing data


# combine the vectors v1, v2, v3 to create the matrix m1


# take the entire second row of m1, it should give back v2


# take the first two elements in the first row of m1


######################
# EXTRA: MORE PRACTICE
######################

# generate a matrix, m3, with 4 elements (1 to 4)


# calculate the row sum and the column sum of m3


# at the end of m3, add a new column with the sum of m3 elements


# inspect the matrices m1 and m3 


# add m1 (3x3) and m3 (2x2): what happens? not allowed
# matrices must be conformable to perform algebraic operations


# make m3 conformable and try again (tip: add vectors of 0 to it)


# calculate the dot product of v1 and v2
# sum of the products of the corresponding entries in two vectors


# calculate the average of the elements of v1


# calculate the average of v1, v2, v3 at once


# take the 1st element of each vector (v1, v2, v3) and create a new vector: v_first


# take the last element of each vector (v1, v2, v3) and create a new vector: v_last


# label the elements of the vector v1 as "x", "y", "z"


# generate a new matrix, m2, with 9 elements (1 to 9)
# default is byrow=FALSE since R fills the matrix by column


# label the columns and rows of the matrix m2 as "a", "b", "c"


# multiply m1 by m2 (element-wise)


# multiply m1 by m2 (algebraic): where does the number at position 1,1 come from?


# divide m1 by m2 (element-wise)


# transpose m1, assign it to "m1T", multiply m1T by m1


# same thing in one line


# combine the vectors v1, v2, v3 to create the data frame d
