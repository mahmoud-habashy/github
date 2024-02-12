# github

This is a simple app to get user data from Github API

## Getting Started

To run this app, first you have to clone it in your local machine.

### Prerequisites
> - flutter pub get => To get all dependencies.
> - dart doc . => To generate the documentations.
> - run the app


## Folder structure

- Presentation:
This folder contains all the ui widgets.

- Data:
This folder has any external network communication its contains the **services** for the http requests and the responses. **models**, **providers** the business logic and the methods for getting the data, and **repositories** the modeling layer between the **providers** and the **services**.

- Shared:
This folder has all the shared data **Strings** , **Colors** , **Theme** , **Constants** to make a guideline for the app to prevent any hard coded values.

- Util:
This folder contains the app router and the validators.

- config:
This folder contains the app configurations.


## Screens

**- Splash**: When the user opens the app this is the initial page. 

**- Home**:
The main screen, it has three states:

EmptySearchState:
User opens the app for the first time or the user does not have any recent searches stored in the device.

RecentSearchState:
The User already has recent searches stored in the device.

ErrorState:
When an error occurred.


**- Dashboard**:
The dashboard screen for rendering the user details and the public repos for the selected user.
It has a pagination logic: when a user reaches the end of the repo list the app will send a request to get more repos.

## Implementation
To implement those features i used those packages:
- flutter_riverpod: to manage the business login and manage the state.
- http: to communicate with Github server.
- intl: to use date format.
- shared_preferences: to store data in the device.
- url_launcher: to open the github links.
- lottie: for animation.
- flutter_launcher_icons: for app launch icon.

## Improvements
- Use any other state management.
- Use dio package instance of http to create interceptor and manage error handling.
- Use connectivity_plus allows to discover network connectivity.
- write unit test ,widget test and integration test.

Apk link -> [click ](https://drive.google.com/file/d/1w2cuCVeZAaRrfREPMPGCMw0eM1gQpk6O/view?usp=sharing)

mr.habashy88@gmail.com


