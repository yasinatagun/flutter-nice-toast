# Flutter Nice Toast

A beautiful and highly customizable toast notification package for Flutter with animations and various predefined styles.

## Features

- 🎨 **Elegant Design**: Stylish and clean toast notifications with smooth animations
- 🔔 **Multiple Styles**: Pre-built themes for success, error, warning and info toasts
- 🔧 **Highly Customizable**: Create your own toast themes with custom colors, icons, and gradients
- 📱 **Flexible Positioning**: Display toasts at the top, center, or bottom of the screen
- 🖱️ **Interactive**: Support for dismissal by swipe, tap callbacks, and persistent toasts
- ⚡ **Simple API**: Clean, intuitive API for easy implementation

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

### Basic Usage

Show predefined toast notifications:

```dart
// Show an error toast
NiceToast.error(
  context: context,
  message: "An error occurred!",
  title: "Error", // Optional
);

// Show a success toast
NiceToast.success(
  context: context,
  message: "Operation completed successfully!",
  title: "Success", // Optional
);

// Show a warning toast
NiceToast.warning(
  context: context,
  message: "Please proceed with caution!",
  title: "Warning", // Optional
);

// Show an info toast
NiceToast.info(
  context: context,
  message: "System will be updated tomorrow.",
  title: "Information", // Optional
);
```

### Customization Options

All toast types support these customization options:

```dart
NiceToast.success(
  context: context,
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
  context: context,
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
  context: context,
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