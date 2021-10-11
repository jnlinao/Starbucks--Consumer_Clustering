# Starbucks Customer Analysis
### Use Case: Utilizing consumer survey data to assess market situation of Starbucks perception by end-users. 

## Business Problem
Given a dataset of 22 survey questions ranging from "Overall, how would you rate the beverages served at Starbucks? - Taste" and "How would you rate the Starbucks staff along the following dimensions? - Providing" in addition to other quantitative metrics such as satisfaction score or recommend to a friend scale, **Starbucks would like to find out ways to improve customer perception on their business in order to increase turnover"**. Starbucks would like to receive data-driven business suggestions to aid their decision making in the following ways:
1. What are the drivers that may affect a customer’s willingness to recommend Starbucks to others?
2. How can we segment our customers in order to cater respective marketing strategies to each?
3. What aspects of the business can be improved in order to increase a customer's willingness to recommend the business to others?

## Data Challenges and Approach
1. What variables can be taken out and what should stay? 
  * Conducted backward and forward selection for variable selection, comparing R^2 for each to decide if variables have an affect on prediction ability.
2. Predicting recommend score
  * Conducted linear regression and optimized R^2 for test sample of 5000 customers
3. Segmenting customers
  * Conducted k-means clustering to segment customers into 2 optimal groups - dissatisfied and satisfied customers
 
## Project Findings
### P-value
* Used p-values to make distinctions from significant variables and unimportant ones, in regard to regression analysis
### Variable Selection
* The results of the forward selection model indicate that 3 variables were dropped, leaving 19 out of the 22 total variables remaining. The variables that were dropped are X6, X17, and X18. In comparison between the original model with 22 variables and the forward selection model with 19 variables, the R^2 only went down by 0.0004.  With this minuscule difference, we can conclude that efforts to conduct variable selection does not have much impact. These results indicate that these dropped variables does not significantly matter to the performance of the model. This can further be reinforced through the high p-values of these variables from the previous model (indicating low significance). 
### Analyzing the clusters
* In cluster 1, there are 3230 customers. In cluster 2, there are 2891 customers. Regression was ran for each cluster to find the difference of predicted recommend score for each. The average predicted value for the “Most Satisfied” segment : 7.33 while the average predicted value for the “Unsatisfactory” segment: 5.19.
### Which variables to focus on
* We found that with the incremented change of an additional point for variables X1, X2, X7, X8, and X10 in the “Unsatisfactory” segment, the new predicted average recommend score jumped to 7.05, which is 1.86 points higher than the original “Unsatisfactory” segment data. In comparison between the “Unsatisfactory” segment’s new recommend score and that of the “Most Satisfied” segment’s, the score is very close. This denotes that just a one-point increase could turn these customers into satisfied customers.  Having more satisfied customers is a desirable outcome for Starbucks, and this seems to be achieved through a one-point boost in these variables. Such a result for the cost of a measurable solution would prove worthwhile to do. 
### Impact of satisfaction score
We ran a regression to predict profits using satisfaction, income, and recommend score as predictors. After running our regression and extracting the coefficients for the intercept and satisfaction, we saw that for every 10-point increase in satisfaction, there is about a $2.38 increase in average monthly profit. This seems like a small increase in profit, but a lot of money can be lost between a customer who is not satisfied (0) and a customer who is very satisfied (100). In the case that a thousand customers would change their satisfaction levels from 0 to 100 in a given month would result in a considerable profit increase for a Starbucks establishment. With this in mind, increases in customer satisfaction should be a targetable aspect for the business.

Then we ran a separate progression and defined to dummy variables for satisfaction score, 
We ran a regression to predict profits using satisfaction, income, and recommend score as predictors. After running our regression and extracting the coefficients for the intercept and satisfaction, we saw that for every 10-point increase in satisfaction, there is about a $2.38 increase in average monthly profit. This seems like a small increase in profit, but a lot of money can be lost between a customer who is not satisfied (0) and a customer who is very satisfied (100). In the case that a thousand customers would change their satisfaction levels from 0 to 100 in a given month would result in a considerable profit increase for a Starbucks establishment. With this in mind, increases in customer satisfaction should be a targetable aspect for the business.

