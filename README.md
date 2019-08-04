# Weazer

## How the app works

### How to setup and run the app
- Launch Xcode
- Run the app on Simulator or on your iPhone

### How to add a forecast for a specific city
- Tap on the + icon on the My Forecasts Screen
- Use the search bar to find cities
- Tap on a city to add a forecast for this city

### How to add a forecast for my position
- Tap on the + icon on the My Forecasts Screen
- Tap on Geolocation arrow icon
- Accept the permission

### How to remove a tracked forecast
- On the My Forecasts Screen, swipe to the left a forecast to delete it

### How to filter my forecasts 
- On the My Forecasts Screen, use the search bar and write the city name of the forecast you're looking for

## Contribute to the development

The current architecture of the app is MVVM (Model View ViewModel).

Every line of code written must respect the SOLID principle and be easy to unit test.

### How to add a dependency

Use the Environment protocol and the AppEnvironment class.

For instance, if you have to add an external library for tracking purpose, you must:

- Create a protocol for the tracking (ex: TrackingProtocol)
- Add a variable to Environment (ex: var tracking: TrackingProtocol)
- Create a class, struct, etc... that implements the protocol
- Initialize this class in AppEnvironment

The goals of the environment protocol are:
 
- To have only ONE singleton in the app and it must be the AppEnvironment
- To not have dependency of external libraries everywhere in the app
- To be able to use different libraries on differents modules, targets, etc...
- To facilitate a possible change in future developments
  
### How to add a navigation to a new screen

All the navigation in the app should use the Routing class that implement the Navigator protocol.

If you need to navigate to a new screen, you should: 

- Implement a class that respect the RoutingEntry protocol (see AddForecastsRoutingEntry for instance)

A routing entry object is responsible for:

- Creating the viewController
- Defining the transition method (pop, push, modal, dismiss, ...)
- Choosing if the transition is animated or not
- Handling a specific action when the transition is finished

### How to add a new API endpoint

All the API calls in the app should use the APIRequester class that implement the API protocol.

If you must create a new endpoint, you should: 

- Implement a class that respect the APIEndpoint protocol (see GetSearchRepoEndpoint for instance)

An API endpoint object is responsible for:

- Knowing the path url
- Defining the HTTP method (GET, POST, PUT, DELETE)
- Adding the parameters
- Parsing the response object
- Creating an error message according to the status code


### How to add a new model

To add a new model, you should:

- Create a subclass of the Model class
- Configure the properties of your class in the parse(data: [AnyHashable : Any]) method.

If you need to use this model offline, then you sould:

- Create another class that is a subclass of Object (Realm)
- Configure the properties

See, the Forecast class and the RealmForecast class to learn more.

The goal to have differents classes is to avoid to have any dependency of the Realm framework everywhere in the app. 


### How to use another database framework

It is really simple, all you have to do is:

- Create a class that respect the Database protocol
- Use your chosen framework in that class (see RealmDatabase for an example with Realm)
- In the AppEnvironment class, replace the database value by an instance of your new class

As always, you won't have any dependency to your framework everywhere in the app.
