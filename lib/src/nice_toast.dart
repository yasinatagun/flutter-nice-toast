import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'toast_position.dart';
import 'toast_theme.dart';

/// Global key to access navigator and overlay states without context
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// A highly customizable toast notification widget for Flutter applications.
///
/// NiceToast provides elegant, animated toast notifications with various
/// styles (success, error, warning, info) and customization options.
/// It uses a no-context approach to show toasts from anywhere in your app.
class NiceToast {
  // Private constructor to prevent instantiation
  NiceToast._();

  // Static properties
  static OverlayEntry? _currentEntry;
  static bool _isVisible = false;
  static AnimationController? _animationController;
  static final GlobalKey _overlayKey = GlobalKey();

  /// Initialize the toast system with a global navigator key
  /// Call this in your main.dart when creating the MaterialApp
  static GlobalKey<NavigatorState> init() {
    return navigatorKey;
  }

  /// Display an error toast notification
  static void error({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 5),
    ToastPosition position = ToastPosition.top,
    double margin = 50.0,
    bool dismissible = true,
    VoidCallback? onDismiss,
    VoidCallback? onTap,
  }) {
    _show(
      message: message,
      title: title,
      theme: ToastTheme.error(),
      duration: duration,
      position: position,
      margin: margin,
      dismissible: dismissible,
      onDismiss: onDismiss,
      onTap: onTap,
    );
  }

  /// Display a warning toast notification
  static void warning({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 5),
    ToastPosition position = ToastPosition.top,
    double margin = 50.0,
    bool dismissible = true,
    VoidCallback? onDismiss,
    VoidCallback? onTap,
  }) {
    _show(
      message: message,
      title: title,
      theme: ToastTheme.warning(),
      duration: duration,
      position: position,
      margin: margin,
      dismissible: dismissible,
      onDismiss: onDismiss,
      onTap: onTap,
    );
  }

  /// Display a success toast notification
  static void success({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 5),
    ToastPosition position = ToastPosition.top,
    double margin = 50.0,
    bool dismissible = true,
    VoidCallback? onDismiss,
    VoidCallback? onTap,
  }) {
    _show(
      message: message,
      title: title,
      theme: ToastTheme.success(),
      duration: duration,
      position: position,
      margin: margin,
      dismissible: dismissible,
      onDismiss: onDismiss,
      onTap: onTap,
    );
  }

  /// Display an info toast notification
  static void info({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 5),
    ToastPosition position = ToastPosition.top,
    double margin = 50.0,
    bool dismissible = true,
    VoidCallback? onDismiss,
    VoidCallback? onTap,
  }) {
    _show(
      message: message,
      title: title,
      theme: ToastTheme.info(),
      duration: duration,
      position: position,
      margin: margin,
      dismissible: dismissible,
      onDismiss: onDismiss,
      onTap: onTap,
    );
  }

  /// Display a persistent error toast that requires manual dismissal
  static void errorPersistent({
    required String message,
    String? title,
    ToastPosition position = ToastPosition.top,
    double margin = 50.0,
    VoidCallback? onDismiss,
    VoidCallback? onTap,
  }) {
    _show(
      message: message,
      title: title,
      theme: ToastTheme.error(),
      position: position,
      margin: margin,
      dismissible: true,
      persistent: true,
      onDismiss: onDismiss,
      onTap: onTap,
    );
  }

  /// Display a persistent warning toast that requires manual dismissal
  static void warningPersistent({
    required String message,
    String? title,
    ToastPosition position = ToastPosition.top,
    double margin = 50.0,
    VoidCallback? onDismiss,
    VoidCallback? onTap,
  }) {
    _show(
      message: message,
      title: title,
      theme: ToastTheme.warning(),
      position: position,
      margin: margin,
      dismissible: true,
      persistent: true,
      onDismiss: onDismiss,
      onTap: onTap,
    );
  }

  /// Display a persistent success toast that requires manual dismissal
  static void successPersistent({
    required String message,
    String? title,
    ToastPosition position = ToastPosition.top,
    double margin = 50.0,
    VoidCallback? onDismiss,
    VoidCallback? onTap,
  }) {
    _show(
      message: message,
      title: title,
      theme: ToastTheme.success(),
      position: position,
      margin: margin,
      dismissible: true,
      persistent: true,
      onDismiss: onDismiss,
      onTap: onTap,
    );
  }

  /// Display a persistent info toast that requires manual dismissal
  static void infoPersistent({
    required String message,
    String? title,
    ToastPosition position = ToastPosition.top,
    double margin = 50.0,
    VoidCallback? onDismiss,
    VoidCallback? onTap,
  }) {
    _show(
      message: message,
      title: title,
      theme: ToastTheme.info(),
      position: position,
      margin: margin,
      dismissible: true,
      persistent: true,
      onDismiss: onDismiss,
      onTap: onTap,
    );
  }

  /// Display a custom toast notification with full customization
  static void custom({
    required String message,
    required ToastTheme theme,
    String? title,
    Duration? duration,
    ToastPosition position = ToastPosition.top,
    double margin = 50.0,
    bool dismissible = true,
    bool persistent = false,
    VoidCallback? onDismiss,
    VoidCallback? onTap,
  }) {
    _show(
      message: message,
      title: title,
      theme: theme,
      duration: duration ?? const Duration(seconds: 5),
      position: position,
      margin: margin,
      dismissible: dismissible,
      persistent: persistent,
      onDismiss: onDismiss,
      onTap: onTap,
    );
  }

  /// Private method to display a toast without requiring BuildContext
  static void _show({
    required String message,
    required ToastTheme theme,
    String? title,
    Duration duration = const Duration(seconds: 5),
    ToastPosition position = ToastPosition.top,
    double margin = 50.0,
    bool dismissible = true,
    bool persistent = false,
    VoidCallback? onDismiss,
    VoidCallback? onTap,
  }) {
    // Check if navigator is available
    final NavigatorState? navigator = navigatorKey.currentState;
    if (navigator == null) {
      debugPrint('NiceToast: Navigator not found. Make sure to call NiceToast.init() and use the returned navigatorKey in your MaterialApp.');
      return;
    }

    // Get the overlay state
    final overlayState = navigator.overlay;
    if (overlayState == null) {
      debugPrint('NiceToast: Overlay not found');
      return;
    }

    // Dismiss any existing toast
    _dismiss();

    // Create a TickerProvider for animations
    final ticker = _SingleTickerProvider();

    // Create an animation controller for animations
    _animationController = AnimationController(
      vsync: ticker,
      duration: const Duration(milliseconds: 300),
    );

    final Animation<double> opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    ));

    final Animation<Offset> offset = Tween<Offset>(
      begin: position == ToastPosition.top
          ? const Offset(0.0, -1.0)
          : position == ToastPosition.bottom
              ? const Offset(0.0, 1.0)
              : const Offset(0.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeOutBack,
    ));

    // Get screen dimensions without using BuildContext
    final screenSize = _getScreenSize();

    // Create overlay entry
    final overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _ToastOverlayWidget(
        message: message,
        title: title,
        theme: theme,
        position: position,
        margin: margin,
        showCloseButton: persistent,
        screenSize: screenSize,
        onClose: () {
          _dismiss();
          if (onDismiss != null) onDismiss();
        },
        opacity: opacity,
        offset: offset,
        onTap: onTap,
        dismissible: dismissible,
      ),
    );

    // Update the current entry and visibility flag
    _currentEntry = overlayEntry;
    _isVisible = true;

    // Show the toast and start animation
    overlayState.insert(overlayEntry);
    _animationController!.forward();

    // Hide after duration if not persistent
    if (!persistent) {
      Future.delayed(duration, () {
        _dismiss();
        if (onDismiss != null) onDismiss();
      });
    }
  }

  /// Dismiss the current toast notification
  static Future<void> dismiss() async {
    return _dismiss();
  }

  /// Private method to dismiss toast with animation
  static Future<void> _dismiss() async {
    if (_isVisible && _currentEntry != null) {
      if (_animationController != null) {
        await _animationController!.reverse();
        _animationController!.dispose();
        _animationController = null;
      }

      _currentEntry!.remove();
      _currentEntry = null;
      _isVisible = false;
    }
  }

  /// Get screen size without context
  static Size _getScreenSize() {
    final window = ui.PlatformDispatcher.instance.views.first;
    final physicalSize = window.physicalSize;
    final devicePixelRatio = window.devicePixelRatio;
    return Size(
      physicalSize.width / devicePixelRatio,
      physicalSize.height / devicePixelRatio,
    );
  }
}

/// Custom TickerProvider to create animations without BuildContext
class _SingleTickerProvider extends TickerProvider {
  late Ticker _ticker;

  @override
  Ticker createTicker(TickerCallback onTick) {
    _ticker = Ticker(onTick);
    return _ticker;
  }
}

/// Widget that renders the toast notification UI without requiring BuildContext
class _ToastOverlayWidget extends StatelessWidget {
  final String message;
  final String? title;
  final ToastTheme theme;
  final ToastPosition position;
  final double margin;
  final bool showCloseButton;
  final VoidCallback? onClose;
  final Animation<double> opacity;
  final Animation<Offset> offset;
  final VoidCallback? onTap;
  final bool dismissible;
  final Size screenSize;

  const _ToastOverlayWidget({
    required this.message,
    this.title,
    required this.theme,
    required this.position,
    required this.margin,
    required this.screenSize,
    this.showCloseButton = false,
    this.onClose,
    required this.opacity,
    required this.offset,
    this.onTap,
    this.dismissible = true,
  });

  @override
  Widget build(BuildContext context) {
    final double toastWidth = screenSize.width * 0.9;

    Widget toast = AnimatedBuilder(
      animation: opacity,
      builder: (context, child) {
        return Opacity(
          opacity: opacity.value,
          child: SlideTransition(
            position: offset,
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  width: toastWidth,
                  decoration: BoxDecoration(
                    color: theme.gradient == null ? theme.backgroundColor : null,
                    gradient: theme.gradient,
                    borderRadius: BorderRadius.circular(theme.borderRadius),
                    border: Border.all(color: theme.borderColor, width: theme.borderWidth),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: theme.padding,
                    child: Row(
                      children: [
                        Icon(theme.iconData, color: theme.iconColor, size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (title != null) ...[
                                Text(
                                  title!,
                                  style: TextStyle(
                                    color: theme.textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                              ],
                              Text(
                                message,
                                style: TextStyle(color: theme.textColor, fontSize: 14),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        if (showCloseButton) ...[
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: onClose,
                            child: Icon(Icons.close, color: theme.iconColor, size: 20),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    // If dismissible, wrap in a dismissible widget
    if (dismissible) {
      toast = GestureDetector(
        onHorizontalDragEnd: (details) {
          // Check if swipe is significant
          if (details.primaryVelocity != null && details.primaryVelocity!.abs() > 200) {
            if (onClose != null) onClose!();
          }
        },
        child: toast,
      );
    }

    // Position the toast according to the specified position
    return Positioned(
      top: position == ToastPosition.top ? margin : null,
      bottom: position == ToastPosition.bottom ? margin : null,
      left: screenSize.width * 0.05,
      right: screenSize.width * 0.05,
      // Center vertically if position is center
      child: position == ToastPosition.center ? Center(child: toast) : toast,
    );
  }
}
