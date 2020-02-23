# Fiserv-Financial-Project

#Inspiration

Financial institutions lose money every year from default customers. Default prediction is required to predict customer's ability to pay his/her bills before actually issue the credit card/credit amount.

#What it does

The project used multiple machine learning algorithms to predict customer default status based on personal information (age, gender, marriage), credit amount, and history credit card activities using logistic regression. The predicted result can either be whether the customer will default or not or the probability that a customer will be default so that banking users can have some flexibility in decision making.

#How we built it

We use R to see which of these programming languages could predict the default type better. We first divided our datasets into two parts, 20% for testing data, 80% for training data. We built models for our training data and employed the models to the testing datasets. We will calculate the error rate on testing datasets. We will build multiple models including random forest, naive-Bayes, logistic regression, and regression and classification tree to see which model and pick the one return the most accuracy. Parameter pruning will be performed to select the best parameter set for the final model. Second, we also built a website for financial specialists to input/search customer information and get default prediction in real-time!

#Challenges we ran into

Parameter pruning takes time! Trade-off between accuracy and information contains should be made. Model simplification is very important to make the model easy to implement while also efficient.

#Accomplishments that we're proud of

We are doing both R and Python, and comparing their results. Among this project, we use over five prediction models to have a great predict of the financial default type. Our group works together and we make friends. We love this competition so much!!!

#What we learned

The beauty of simplicity. Technologies together make work easier. We learned many machine learning techniques through this project. It is a nice chance for us to approach real-world data.

#What's next for Default Risk Management

The next step for default risk management will be to connect the algorithm, user interface, and customer information database to make the prediction real-time and intelligence!
