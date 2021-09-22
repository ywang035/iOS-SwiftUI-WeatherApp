# Welcome to ios-WeatherApp

This is a basic iOS weather app that demostrating API request, JSON decode, SQLite query, call back functions (completion handler) in API requesting and database querying.

## Screenshots

Showing in order of **Home Page, City Detail View and City Search Result**

<img src="https://github.com/ywang035/ios-WeatherApp/blob/main/images/home.png" width="200">  <img src="https://github.com/ywang035/ios-WeatherApp/blob/main/images/detail.png" width="200">  <img src="https://github.com/ywang035/ios-WeatherApp/blob/main/images/search.png" width="200">

## What is working now

- 3 default cities in Australia, including Sydney, Melbourne and Brisbane
- User can search, add and delete cities to/from the list (city data is converted from openweather to SQLite database)
- User can switch between fahrenheit and celsius
- Basic animation
- Support Dark/Light Modes
- Basic support for iPad (both landscape and portrait)

## Future Work

- optimize SQLite query for city search
- optimize call back function with result enum
- add weather forecasting data
- save added cities to local database storage
