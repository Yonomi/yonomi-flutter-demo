# Yonomi Flutter Demo

[![Yonomi Flutter Demo][demo-shield]][yonomi]
[![CircleCI][circle-shield]][circle-pipeline]
[![codecov](https://codecov.io/gh/Yonomi/yonomi-flutter-demo/branch/main/graph/badge.svg?token=SI9QVPCIEQ)](https://codecov.io/gh/Yonomi/yonomi-flutter-demo)

---

This demo application is built using Flutter and Yonomi's latest IoT API.

---

## For Developers

This is a demo app to help you get aquainted with Yonomi's developer tools, as well as some opinions on best practices for building a Flutter application with Yonomi. You can fork this application as a starting point for your own IoT mobile and web applications and use it as a head start on development.

## For Non-Technical Customers

This demo is a great place to start understanding the kind of applications you can build using Yonomi. You may use the instructions below to get an instance of this demo running on your local machine, or you can work with members of Yonomi's sales team to see this demo in action.

<!--# Table of contents-->
1. [Prerequisites](#prerequisites)
1. [Getting Started](#getting-started)
2. [Brief App Overview](#app-overview)
3. [Running tests](#run-tests)
4. [License](#license)

## Prerequisites<a name="prerequisites"></a>
### 1. Install Flutter

You will need to have a machine set up with the Flutter SDK.

#### 1. Follow the official guide on how to install the Flutter SDK on your machine:

[https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)

#### 2. You will need to be set up with our platform, having fulfilled the following requirements:

1. Created a Tenant
2. Generated public and private RS256 key pairs
3. Updated the Tenant with your public key
4. Have users with unique Ids

If you need guidance to complete any of these steps, visit the following guide for the complete walkthrough to onboard with the platform:

[Comprehensive Platform Request Guide](https://yonomi.atlassian.net/wiki/spaces/YP/pages/1740963897/Comprehensive+Platform+Requests+Guide)


## Getting Started <a name="getting-started"></a>

### Configuring the app

#### Add your private key to the app
1. Name your private key file `jwtRS256.key` and move it to the `assets` folder.

2. Double-check your `pubspec.yaml` file to make sure that this file is defined under the `assets` section:

```
flutter:
  ...
  assets:
    - assets/jwtRS256.key
```

#### Update the `config.yaml` file
1. Open `assets/config.yaml` and update `tenantId` with your tenant id:

```
url: https://platform.yonomi.cloud/graphql
tenantId: YOUR-TENANT-ID
```

2. Double-check your `pubspec.yaml` file to make sure that this file is defined under the `assets` section:

```
flutter:
  ...
  assets:
    - assets/config.yaml
```

#### Building a Request object

You will use `YoRequest.request()` to simplify making requests to the platform.

**Example**: Building a request object using user Id "1234"
```
Request request = await YoRequest.request("1234");
```

**Note:** This method builds a valid request by using the configured graphql endpoint, the user Id passed in as a parameter, the private key stored as `jwtRS256.key`, and the configured tenant id.

### Configuring a device to run the app:

You can use either iOS or Android device to run the demo app.

#### iOS
1. Simulator
2. Real device

#### Android
1. Emulator
2. Real device
 

## Brief App overview <a name="app-overview"></a>

When you open the app, you will be prompted for a User ID.
You can input anything as your User ID or you can use one previously used to navigate to the next screen.

At the bottom you can select three tabs to navigate to the **Home**, **Devices**, or **Settings** screens.

### To add an integration
Press the '+' floating action button and select an integration from the list.

You will be taken to that integration's authentication page. 

Input your credentials for that account, and if you authenticated successfully, you will be taken back to the app and see all devices under that account.

## Running tests<a name="run-tests"></a>
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

