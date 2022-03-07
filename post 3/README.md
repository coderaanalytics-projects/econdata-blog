# Automating a simple model

In this blog we will be illustrating how to create a simple automated forecasting model using EconData. The specification of the model is done in an automated fashion which chooses the best fit based on the data. Therefore, similar to our previous blog (which can be viewed here) all that is required to automate the model and forecast is to press run on the script which will update the data and provide the best fitted model and forecast for this specific model. 

First lets load the required packages.

We can now load the data using the read_econdata() function. 

For ease of data manipulation we will convert the data into xts format.

Next we can convert the CPI into a y-o-y headline inflation rate and plot the data to have a better idea of what we are going to model and forecast. 

We are now able to estimate the model. We are using a a simple ARIMA model using the forecast package. The auto.arima() function from the package will automatically choose the model specification that best fits the data. 

Now that we have an estimated ARIMA model we can use the model to forecast. In this example we are forecasting 12 months ahead.

The forecasts can now be analysed with associated confidence intervals in a plot or table. 


