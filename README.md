# crypto_tracker

![logo](/app_icon.png)

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)

## Deployed by

![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)

## IDEs

![Android Studio](https://img.shields.io/badge/Android%20Studio-3DDC84.svg?style=for-the-badge&logo=android-studio&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white)
![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)

----

## Getting Started

Follow these steps to get the project up and running on your machine.

### Installing Flutter

Go to [Flutter website](https://docs.flutter.dev/get-started/install) and install the corresponding Flutter version for your OS.

#### **Android Development 📞**

Make sure you have [Android Studio](https://developer.android.com/studio) fully installed (You can also use [Jetbrains toolkit](https://www.jetbrains.com/toolbox-app/) to install Android Studio as well).

#### **iOS Development 📱**

You need to have a Mac and [XCode](https://developer.apple.com/xcode/) fully installed.

#### **Web Development 💻**

Install [Google Chrome](https://www.google.com/chrome/) and Flutter will take care of the rest 😍.

For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.

## Running the Project
```bash
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
flutter run --release
```


## Generating APK

Run the [build.apk](/scripts/build_apk.sh) script inside the scripts folder.

----

## Generate New Feature Folder Structure

First off, init [mason_cli](https://pub.dev/packages/mason_cli) then execute the following:

🎯 Activate from https://pub.dev
dart pub global activate mason_cli
🚀 Initialize mason
mason init
🧱 Use your first brick
mason make hello


Then, using [Clean Architecture folders brick](https://brickhub.dev/bricks/clean_architecture_folders/0.1.0+2) execute the following:

```bash
cd .\lib\features\
mason make clean_architecture_folders --name FEATURE_NAME
```


----

## Deployment & CI/CD Integrations

### Using Codemagic CI/CD

![logo](https://partners.katalon.com/partner_content/52/1786552/logo300x300.png?t=8da6e124fe0a8c5)

Follow the official documentation of [Codemagic](https://blog.codemagic.io/getting-started-with-codemagic/).

### Deploy to Cloudflare Pages Using Peanut Package

![Cloudflare](https://img.shields.io/badge/Cloudflare-F38020?style=for-the-badge&logo=Cloudflare&logoColor=white)

Follow [this](https://hrishikeshpathak.com/blog/flutter-web-hosting-cloudflare/) tutorial.


```bash
flutter pub global activate peanut
flutter pub global run peanut -b cloudflare-pages-production
git push --all
```


### Upload iOS App to the Store [WIP]

![apple](https://developer.apple.com/news/images/og/app-store-og.png)

1. Generate a new certificate request in certificates & profiles.
2. Download the new certificate.
3. Create a new app in App Store Connect.
