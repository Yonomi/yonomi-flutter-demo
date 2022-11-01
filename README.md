# Yonomi Flutter Demo

[![Yonomi Flutter Demo][demo-shield]][yonomi]
[![CircleCI][circle-shield]][circle-pipeline]
[![codecov](https://codecov.io/gh/Yonomi/yonomi-flutter-demo/branch/main/graph/badge.svg?token=SI9QVPCIEQ)](https://codecov.io/gh/Yonomi/yonomi-flutter-demo)

---

This demo application is built using Flutter and Yonomi's latest IoT API.

---

## For Developers

This demo app is to help you get acquainted with Yonomi's developer tools. This app also follows best practices for building a Flutter application using Yonomi platform. You can fork this application as a starting point for your own IoT mobile and web applications and use it as a head start on development.

## For Non-Technical Customers

This demo is a great place to start understanding the kind of applications you can build using Yonomi. You may use the instructions below to get an instance of this demo running on your local machine, or you can work with members of Yonomi's sales team to see this demo in action.

# Table of contents

1. [Prerequisites](#prerequisites)
1. [Getting Started](#getting_started)
2. [Brief App Overview](#app_overview)
3. [Running tests](#run_tests)
4. [License](#license)

## Prerequisites<a name="prerequisites"></a>
### 1. Install Flutter

You will need to have a machine set up with the Flutter SDK.

#### 1. Follow the official guide on how to install the Flutter SDK on your machine:

[https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)

#### 2. You will need to be set up with our platform

You will need an Auth0 application. You will need your Auth0 application's domain, client ID and will have to define an OAuth callback URL for your app.

If you need guidance on obtaining any of these, please [contact our sales team](https://www.yonomi.co/contact-us) to help you get started using our platform.

## Getting Started <a name="getting_started"></a>

### Configuring the app

#### Add your configuration
Add your Auth0 application's Domain, Client ID and your OAuth callback URL to the app:

1. Create a file `.env` in your app's `assets` folder.

2. Add the following entries in your `.env` file. 

```
DOMAIN: <REPLACE WITH YOUR DOMAIN HERE>
CLIENT_ID: <REPLACE WITH YOUR CLIENT ID HERE>
OAUTH_CALLBACK_URL: <REPLACE WITH YOUR OAUTH CALLBACK URL>
```

3. Open the `pubspec.yaml` file and look for the `assets` section:

```
flutter:
  ...
  assets:
    
```

4. Add the following line under the `assets` section:

`- assets/.env`

It should look like this:

```
flutter:
  ...
  assets:
    - assets/.env
```

#### Update the `config.yaml` file
1. Open `assets/config.yaml` and update `url` with Yonomi Platform's graphQL endpoint:

```
URL: https://platform.yonomi.cloud/graphql
```

2. Open the `pubspec.yaml` file and look for the `assets` section:

```
flutter:
  ...
  assets:
    
```

3. Add the following line under the `assets` section:

`- assets/config.yaml`

It should look like this:

```
flutter:
  ...
  assets:
    - assets/config.yaml
```

#### Configure with Firebase
We have used Firebase to collect crash logs and to easily distribute app builds.
To correctly run the app you will need firebase related config files. Each for ios and android. 
Use the following guides below to set it up on your desired platform(s):

##### For Android

[Firebase Android guide](https://firebase.google.com/docs/flutter/setup?platform=android)

Make sure you follow the steps under `Add a Firebase Configuration File` to know where to place your `google-services.json` file

##### For iOS

[Firebase iOS guide](https://firebase.google.com/docs/flutter/setup?platform=ios)

Make sure you follow the steps under `Add a Firebase Configuration File` to know where to place your `GoogleService-Info.plist` file.

Update gitignore to be able to track these files if needed by the organization.

#### Building a Request object

You will use `YoRequest.request()` to simplify making requests to the platform.

**Example**: Building a request object using user ID "1234"

```
Request request = await YoRequest.request("1234");
```

**Note:** This method builds a valid request by using the configured graphql endpoint, the user ID passed in as a parameter, the private key file named `jwtRS256.key`, and the configured tenant ID.

### Configuring a device to run the app:

You can use either iOS or Android devices to run the demo app.

#### iOS
1. Simulator
2. Real device

Visit the following link to download XCode:

[https://developer.apple.com/support/xcode/](https://developer.apple.com/support/xcode/)

#### Android
1. Emulator
2. Real device

Visit the following link to download Android Studio:

[https://developer.android.com/studio](https://developer.android.com/studio)

## Brief App overview <a name="app_overview"></a>

When you open the app, you will be prompted for a User ID.
You can input anything as your User ID or you can use one previously used to navigate to the next screen.

At the bottom you can select three tabs to navigate to the **Home**, **Devices**, or **Settings** screens.

### To add an integration
Press the '+' floating action button and select an integration from the list.

You will be taken to that integration's authentication page.

Input your credentials for that account, and if you authenticated successfully, you will be taken back to the app and see all devices under that account.

## Running tests<a name="run_tests"></a>
### Prerequisites

* Install lcov:

#### lcov (For test coverage)
`brew install lcov`

### Run tests with coverage

```
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## License <a name="license"></a>
This application is released under the [Apache license v2.0](LICENSE)

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)


[yonomi]: https://www.yonomi.co/
[demo-shield]: https://img.shields.io/badge/Yonomi-Flutter_Demo-lightgrey.svg?colorA=ffd500&colorB=5c5c5c
[circle-shield]: https://circleci.com/gh/Yonomi/yonomi-flutter-demo/tree/main.svg?style=shield&circle-token=a80bb5eb3849cd3201f9f8c612aceaa09a4ded09
[circle-pipeline]: https://app.circleci.com/pipelines/github/Yonomi/yonomi-flutter-demo
