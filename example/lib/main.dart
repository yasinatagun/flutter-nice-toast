import 'package:flutter/material.dart';
import 'package:flutter_nice_toast/flutter_nice_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Nice Toast Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ToastDemoPage(),
    );
  }
}

class ToastDemoPage extends StatefulWidget {
  const ToastDemoPage({super.key});

  @override
  State<ToastDemoPage> createState() => _ToastDemoPageState();
}

class _ToastDemoPageState extends State<ToastDemoPage> with SingleTickerProviderStateMixin {
  ToastPosition _position = ToastPosition.top;
  bool _dismissible = true;
  bool _persistent = false;
  double _margin = 50.0;
  Duration _duration = const Duration(seconds: 5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Nice Toast'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Customization controls section
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Toast Options',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),

                      // Position selector
                      const Text('Position:'),
                      SegmentedButton<ToastPosition>(
                        segments: const [
                          ButtonSegment(
                            value: ToastPosition.top,
                            label: Text('Top'),
                          ),
                          ButtonSegment(
                            value: ToastPosition.center,
                            label: Text('Center'),
                          ),
                          ButtonSegment(
                            value: ToastPosition.bottom,
                            label: Text('Bottom'),
                          ),
                        ],
                        selected: {_position},
                        onSelectionChanged: (Set<ToastPosition> selection) {
                          setState(() {
                            _position = selection.first;
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // Duration slider
                      const Text('Duration (seconds):'),
                      Slider(
                        value: _duration.inSeconds.toDouble(),
                        min: 1,
                        max: 10,
                        divisions: 9,
                        label: _duration.inSeconds.toString(),
                        onChanged: _persistent
                            ? null
                            : (value) {
                                setState(() {
                                  _duration = Duration(
                                    seconds: value.round(),
                                  );
                                });
                              },
                      ),
                      const SizedBox(height: 16),

                      // Margin slider
                      const Text('Margin from edge:'),
                      Slider(
                        value: _margin,
                        min: 0,
                        max: 100,
                        divisions: 10,
                        label: _margin.round().toString(),
                        onChanged: (value) {
                          setState(() {
                            _margin = value;
                          });
                        },
                      ),
                      const SizedBox(height: 8),

                      // Toggle options
                      Row(
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              title: const Text('Dismissible'),
                              value: _dismissible,
                              onChanged: (value) {
                                setState(() {
                                  _dismissible = value ?? true;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                            ),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                              title: const Text('Persistent'),
                              value: _persistent,
                              onChanged: (value) {
                                setState(() {
                                  _persistent = value ?? false;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Standard toast buttons
              const Text(
                'Standard Toasts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              _buildToastButton(
                title: 'Success Toast',
                color: ToastColors.successBackground,
                onPressed: () {
                  if (_persistent) {
                    NiceToast.successPersistent(
                      context: context,
                      message: 'Operation completed successfully!',
                      title: 'Success',
                      position: _position,
                      margin: _margin,
                    );
                  } else {
                    NiceToast.success(
                      context: context,
                      message: 'Operation completed successfully!',
                      title: 'Success',
                      position: _position,
                      margin: _margin,
                      duration: _duration,
                      dismissible: _dismissible,
                      onDismiss: () {
                        print('Success toast dismissed');
                      },
                      onTap: () {
                        print('Success toast tapped');
                      },
                    );
                  }
                },
              ),

              const SizedBox(height: 12),

              _buildToastButton(
                title: 'Error Toast',
                color: ToastColors.errorBackground,
                onPressed: () {
                  if (_persistent) {
                    NiceToast.errorPersistent(
                      context: context,
                      message: 'An error occurred! Please try again.',
                      title: 'Error',
                      position: _position,
                      margin: _margin,
                    );
                  } else {
                    NiceToast.error(
                      context: context,
                      message: 'An error occurred! Please try again.',
                      title: 'Error',
                      position: _position,
                      margin: _margin,
                      duration: _duration,
                      dismissible: _dismissible,
                    );
                  }
                },
              ),

              const SizedBox(height: 12),

              _buildToastButton(
                title: 'Warning Toast',
                color: ToastColors.warningBackground,
                onPressed: () {
                  if (_persistent) {
                    NiceToast.warningPersistent(
                      context: context,
                      message: 'Please proceed with caution!',
                      title: 'Warning',
                      position: _position,
                      margin: _margin,
                    );
                  } else {
                    NiceToast.warning(
                      context: context,
                      message: 'Please proceed with caution!',
                      title: 'Warning',
                      position: _position,
                      margin: _margin,
                      duration: _duration,
                      dismissible: _dismissible,
                    );
                  }
                },
              ),

              const SizedBox(height: 12),

              _buildToastButton(
                title: 'Info Toast',
                color: ToastColors.infoBackground,
                onPressed: () {
                  if (_persistent) {
                    NiceToast.infoPersistent(
                      context: context,
                      message: 'The system will be updated tomorrow at 2 PM.',
                      title: 'Information',
                      position: _position,
                      margin: _margin,
                    );
                  } else {
                    NiceToast.info(
                      context: context,
                      message: 'The system will be updated tomorrow at 2 PM.',
                      title: 'Information',
                      position: _position,
                      margin: _margin,
                      duration: _duration,
                      dismissible: _dismissible,
                    );
                  }
                },
              ),

              const SizedBox(height: 24),

              // Custom toast button
              const Text(
                'Custom Toast',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              _buildToastButton(
                title: 'Show Custom Toast',
                color: Colors.purple,
                onPressed: () {
                  // Create a custom theme
                  final customTheme = ToastTheme(
                    backgroundColor: Colors.purple,
                    borderColor: Colors.purple.shade700,
                    iconData: Icons.stars,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.purple, Colors.deepPurple],
                    ),
                    borderRadius: 12.0,
                  );

                  NiceToast.custom(
                    context: context,
                    message: 'This is a completely custom toast!',
                    title: 'Custom Toast',
                    theme: customTheme,
                    position: _position,
                    margin: _margin,
                    duration: _duration,
                    dismissible: _dismissible,
                    persistent: _persistent,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToastButton({
    required String title,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: color == ToastColors.warningBackground ? Colors.black87 : Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(title),
    );
  }
}
