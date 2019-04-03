#create a vector
apple <- c('red','green', 'yellow')
print(apple)

#A list is an R-object which can contain many different 
#types of elements inside it like vectors, functions and even another list inside it

list1 <- list(1,2,3,'Brennan')
print(list1)
list1[4]

# Create a matrix.
#Matrices are two-dimensional structures addresses by rows and columns

M = matrix( c('a','a','b','c','b','a'), nrow = 2, ncol = 3, byrow = TRUE)
print(M)


# Create a vector
crayons <- c('red', 'blue', 'green', 'yellow', 
             'orange', 'violet', 'brown', 'black', 
             'red','red','yellow','brown','orange','blue')

# create a factor object
factor_crayons <- factor(crayons)

#print the factor
print(factor_crayons)
print(nlevels(factor_crayons))

# Create an array 
#While matrices are confined to two dimensions, 
#arrays can be of any number of dimensions.
array1 <- array(c('red','orange','yellow'), dim = c(3,3,2))
print(array1)

# Create the data frame 
#R’s central data structure is called the data frame. 
#A data frame is organized into rows and columns. 
#A data frame is a list of columns of different types
demographics <- data.frame(
  gender = c('M', 'F','F'),
  height = c(172, 121, 111),
  weight = c(175, 124, 111), 
  Age = c(23, 24, 25)
)


print(demographics)

