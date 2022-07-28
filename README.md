## Bootfi Flutter Template

This is a template for all of our projects in Bootfi.

*It's feature-first and using riverpod*
---

## To use this template follow these steps.
## Steps

# Clone the template
- Clone this repo to your local machine:
```dart
    git clone https://github.com/Add00w/bootfi_flutter_template.git
```
- To get dependencies run this cmd in terminal inside project root directory.
```dart
    flutter pub get
```

# To changle bundleId or app name:
- # For all platforms use

```dart
    rename --bundleId com.onatcipli.yourappname
    rename --appname yourappname
```
- # For specific os use -t or --target

```dart
    rename --appname yourappname -t ios
    rename --appname yourappname -t android
    rename --bundleId com.example.android.app --target android
```

## Add app icon for ios and android inside assets/images:
 - android_app_icon.png
 - ios_app_icon.png

- ## Run the following command to generate app icons

```dart
    flutter pub run flutter_launcher_icons:main
```

## Configure firebase for your project
**Install the required command line tools**
- If you haven't already, [install the Firebase CLI](https://firebase.google.com/docs/cli#setup_update_cli).
- Log into Firebase using your Google account by running the following command:
```dart
    firebase login
```
- Install the FlutterFire CLI by running the following command from any directory:
```dart
    dart pub global activate flutterfire_cli
```
- Configure your apps to use Firebase
*Use the FlutterFire CLI to configure your Flutter apps to connect to Firebase.*
*From your Flutter project directory, run the following command to start the app configuration workflow:*
```dart
    flutterfire configure
```
## Initialize Firebase in your app
- In NotificationsRepo, import the Firebase core plugin and the configuration file you generated earlier and uncomment the init firebase code:
```dart
    ///Uncomment this code after configuring firebase
    //init firebase
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
```
## And finally
```dart
    flutter run
```
### Contribution
*Open an issue that describes what you would like to see in this template and we will discus about it.*





## Packages
- [HTTP](https://pub.dev/packages/http)
- [HTTP Interceptor](https://pub.dev/packages/http_interceptor)
- [Flutter Hooks](https://pub.dev/packages/flutter_hooks)
- [Hooks Riverpod](https://pub.dev/packages/hooks_riverpod)
- [Flutter Svg](https://pub.dev/packages/flutter_svg)
- [Freezed Annotation](https://pub.dev/packages/freezed_annotation)
- [Freezed](https://pub.dev/packages/freezed)
- [Json Serializable](https://pub.dev/packages/json_serializable)
- [Build Runner](https://pub.dev/packages/build_runner)
- [Rename](https://pub.dev/packages/rename)
- [Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons)
- [Flutter Lints](https://pub.dev/packages/flutter_lints)
- [Flutter Localizations](https://pub.dev/packages/flutter_localizations)
- [intl](https://pub.dev/packages/intl)
- [Shared Preferences](https://pub.dev/packages/shared_preferences)
- [Cached Network Image](https://pub.dev/packages/cached_network_image)
- [Sentry Flutter](https://pub.dev/packages/sentry_flutter)
- [Firebase Core](https://pub.dev/packages/firebase_core)
- [Firebase Messaging](https://pub.dev/packages/firebase_messaging)
- [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications)
- [Platform Device Id](https://pub.dev/packages/platform_device_id)
- [Package Info Plus](https://pub.dev/packages/package_info_plus)
- [Json Annotation](https://pub.dev/packages/json_annotation)