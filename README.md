# Flutter Nice Toast

A beautiful and highly customizable toast notification package for Flutter with animations and various predefined styles. Shows toasts without requiring BuildContext.

## 📱 Screenshots

<p align="center">
  <img src="https://github.com/yasinatagun/flutter-nice-toast/raw/main/screenshots/app.png" alt="Flutter Nice Toast Demo" width="250"/>
</p>

<table>
  <tr>
    <td><img src="https://github.com/yasinatagun/flutter-nice-toast/raw/main/screenshots/top.png" alt="Top Position Toast" width="200"></td>
    <td><img src="https://github.com/yasinatagun/flutter-nice-toast/raw/main/screenshots/center.png" alt="Center Position Toast" width="200"></td>
    <td><img src="https://github.com/yasinatagun/flutter-nice-toast/raw/main/screenshots/bottom.png" alt="Bottom Position Toast" width="200"></td>
  </tr>
  <tr>
    <td align="center"><b>Top Position</b></td>
    <td align="center"><b>Center Position</b></td>
    <td align="center"><b>Bottom Position</b></td>
  </tr>
</table>

## Features

- 🎨 **Elegant Design**: Stylish and clean toast notifications with smooth animations
- 🔔 **Multiple Styles**: Pre-built themes for success, error, warning and info toasts
- 🔧 **Highly Customizable**: Create your own toast themes with custom colors, icons, and gradients
- 📱 **Flexible Positioning**: Display toasts at the top, center, or bottom of the screen
- 🖱️ **Interactive**: Support for dismissal by swipe, tap callbacks, and persistent toasts
- ⚡ **Simple API**: Clean, intuitive API for easy implementation
- 🧩 **No Context Required**: Display toasts from anywhere in your app without BuildContext

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_nice_toast: ^0.1.0
```

Then run:

```shell
flutter pub get
```

## Usage

Import the package:

```dart
import 'package:flutter_nice_toast/flutter_nice_toast.dart';
```

### Setup

First, initialize the toast system in your app's entry point and add the navigator key to your MaterialApp:

```dart
void main() {
  // Initialize NiceToast and get the navigator key
  final navigatorKey = NiceToast.init();
  
  runApp(MyApp(navigatorKey: navigatorKey));
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  
  const MyApp({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Set the navigator key to enable context-free toast display
      navigatorKey: navigatorKey,
      home: HomePage(),
      // Other app configurations...
    );
  }
}
```

### Basic Usage

Show predefined toast notifications from anywhere in your app without BuildContext:

```dart
// Show an error toast
NiceToast.error(
  message: "An error occurred!",
  title: "Error", // Optional
);

// Show a success toast
NiceToast.success(
  message: "Operation completed successfully!",
  title: "Success", // Optional
);

// Show a warning toast
NiceToast.warning(
  message: "Please proceed with caution!",
  title: "Warning", // Optional
);

// Show an info toast
NiceToast.info(
  message: "System will be updated tomorrow.",
  title: "Information", // Optional
);
```

### Customization Options

All toast types support these customization options:

```dart
NiceToast.success(
  message: "Operation completed successfully!",
  title: "Success",
  position: ToastPosition.top, // top (default), center, or bottom
  duration: const Duration(seconds: 5), // Duration before auto-dismiss
  margin: 50.0, // Margin from the screen edge
  dismissible: true, // Allow swipe to dismiss
  onDismiss: () {
    // Handle toast dismissal
  },
  onTap: () {
    // Handle toast tap
  },
);
```

### Persistent Toasts

Display toasts that don't auto-dismiss and require user action to close:

```dart
NiceToast.errorPersistent(
  message: "This error requires your attention!",
  title: "Critical Error",
);
```

Persistent versions are available for all toast types: `successPersistent`, `warningPersistent`, `infoPersistent`.

### Custom Toasts

Create your own toast themes:

```dart
final customTheme = ToastTheme(
  backgroundColor: Colors.purple,
  borderColor: Colors.deepPurple,
  iconData: Icons.stars,
  textColor: Colors.white,
  iconColor: Colors.white,
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.purple, Colors.deepPurple],
  ),
  borderRadius: 12.0,
  borderWidth: 1.5,
  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
);

NiceToast.custom(
  message: "This is a completely custom toast!",
  title: "Custom Toast",
  theme: customTheme,
  position: ToastPosition.center,
);
```

### Manually Dismissing Toasts

You can programmatically dismiss the current toast:

```dart
NiceToast.dismiss();
```

## Example

See the `/example` directory for a complete demo app.

## License

This package is available under the MIT License. 