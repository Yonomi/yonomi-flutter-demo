[![Yonomi Flutter Demo][demo-shield]][yonomi]
[![CircleCI][circle-shield]][circle-pipeline]
[![codecov](https://codecov.io/gh/Yonomi/yonomi-flutter-demo/branch/main/graph/badge.svg?token=SI9QVPCIEQ)](https://codecov.io/gh/Yonomi/yonomi-flutter-demo)

# Yonomi Flutter Demo

This demo application is built using Flutter and Yonomi's latest IoT API.

## For Developers

This demo can be used to get aquainted with Yonomi's developer tools, as well as some opinions on best practices for building application with Yonomi. You can fork this application as a starting point for your own IoT mobile and web applications and use it as a head start on development.

## For Non-Technical Customers

This demo is a great place to start understanding the kind of applications you can build using Yonomi. You may use the instructions below to get an instance of this demo running on your local machine, or you can work with members of Yonomi's sales team to see this demo in action.

## Getting Started

### Prerequisites
#### Flutter
#### lcov (For test coverage)
`brew install lcov`

## Running Tests

```
flutter test --coverage  
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```


[yonomi]: https://www.yonomi.co/
[demo-shield]: https://img.shields.io/badge/Yonomi-Flutter_Demo-lightgrey.svg?colorA=ffd500&colorB=5c5c5c
[circle-shield]: https://circleci.com/gh/Yonomi/yonomi-flutter-demo/tree/main.svg?style=shield&circle-token=a80bb5eb3849cd3201f9f8c612aceaa09a4ded09
[circle-pipeline]: https://app.circleci.com/pipelines/github/Yonomi/yonomi-flutter-demo

