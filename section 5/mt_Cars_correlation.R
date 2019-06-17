data("mtcars")
?mtcars

#Which transmission type gets better miles per gallon efficiency? 
fit <- lm(mpg~am, data = mtcars)
summary(fit)

# 0 = automatic 
# 1 = manual 

mtcars$am <- as.numeric(mtcars$am)

ggplot(mtcars) +
  aes(x = am, y = mpg, group = am) +
  geom_boxplot()

# Correlation test is used to evalue the association between two or more variables
# In the correlation methods below we use pearson correlation which measures a 
# linear dependence between two variabels (x and y). 

library(corrplot)
?corrplot
correlations <- cor(mtcars)
corrplot(correlations, method = "number")
corrplot(correlations, method = "circle")



