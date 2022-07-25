## Bootfi Flutter Template

This is a template for all of our projects in Bootfi.

## Run the following command inside your flutter project root.
# Get packages
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

## Add app icon for ios and android inside images:
 - android_app_icon.png
 - ios_app_icon.png

- ## Run the following command to generate app icons

```dart
    flutter pub run flutter_launcher_icons:main
```


