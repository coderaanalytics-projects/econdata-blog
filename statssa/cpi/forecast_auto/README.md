# Automating a simple model

A logical next step after automating your charts would be the automation of a model. 

Model automation is usually not a trivial thing to do as it involves a collection of tools and skills, luckily this is where EconData's functionality and its integration into R really shines through. In this blog post we will illustrate how to create a naive automated forecasting model using EconData. 

The specification of the model is handled by the R `forecast` package which employs an algorithm to choose an ARIMA model with the best fit based on the data. Therefore, similar to our previous blog post (which can be viewed here) all that is required to estimate the model and produce a forecast is to run the script. 

First lets load the required packages. If you missed out previous blog post, here is a link for the installation and EconData account creation details.

We can now load the data using the `read_econdata()` function. We specify the data set _id_, data _key_, and _releasedescription_. 

In this post I'd like to focus on the _releasedescription_ argument of the `read_econdata()` function, **this next section can be skipped without loss of continuity**.

Each data set available on the EconData has multiple releases. Each release corresponds to a snapshot of the data as it was at the time of the release, sometimes referred to as a data vintage. The usefulness of this is the ability to test the real-time performance of a model, a very important concept when when dealing with certain economic data and modelling objectives, estimating the output gap for example. In order to query the available releases we use the `read_release()` function. We must, at a minimum, specify the data set _id_ whose releases we want returned, i.e. `read_release(id = "CPI_COICOP_5")`. Each release will have a release description which we pass to `read_econdata()` in order to return the data for that release. If no _releasedescription_ argument is passed to `read_econdata()`, the latest unreleased data will be returned. We will delve deeper into the workings of EconData's system for cataloging and identification of data in the next post.

To ease manipulation of the data we will convert the input data into _xts_ format.

Next we can convert the CPI into a y-o-y headline inflation rate and plot the data to have a better idea of what we are going to model and forecast. 

We are now able to estimate the model. We are using a a simple ARIMA model using the `forecast` package. The `auto.arima()` function from the package will automatically choose the model specification that best fits the data. 

Now that we have an estimated ARIMA model we can use the model to forecast. In this example we are forecasting 12 months ahead.

The forecasts can now be analysed with associated confidence intervals in a plot or table.
