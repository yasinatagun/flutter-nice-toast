import 'package:flutter/material.dart';
import 'package:flutter_nice_toast/flutter_nice_toast.dart';

void main() {
  // Initialize NiceToast globally at app startup
  final navigatorKey = NiceToast.init();
  runApp(MyApp(navigatorKey: navigatorKey));
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Nice Toast Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'SF Pro Display',
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

class _ToastDemoPageState extends State<ToastDemoPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Flutter Nice Toast',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          BasicToastsPage(),
          PositionDemoPage(),
          CustomToastsPage(),
          AdvancedDemoPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Colors.blue[600],
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.white,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Basic',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: 'Positions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.palette),
            label: 'Custom',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Advanced',
          ),
        ],
      ),
    );
  }
}

/// Basic toasts page - perfect for main screenshots
class BasicToastsPage extends StatelessWidget {
  const BasicToastsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue[50]!, Colors.blue[100]!],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.notifications_active,
                  size: 48,
                  color: Colors.blue[600],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Beautiful Toast Notifications',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap any button below to see the magic ✨',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Toast buttons grid
          const Text(
            'Toast Types',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          // Success Toast
          _buildToastCard(
            title: 'Success',
            subtitle: 'Operation completed successfully!',
            icon: Icons.check_circle,
            color: Colors.green,
            onTap: () => NiceToast.success(
              message: 'Your profile has been updated successfully!',
              title: 'Success',
              position: ToastPosition.top,
            ),
          ),

          const SizedBox(height: 16),

          // Error Toast
          _buildToastCard(
            title: 'Error',
            subtitle: 'Something went wrong',
            icon: Icons.error,
            color: Colors.red,
            onTap: () => NiceToast.error(
              message: 'Failed to connect to server. Please check your internet connection.',
              title: 'Connection Error',
              position: ToastPosition.top,
            ),
          ),

          const SizedBox(height: 16),

          // Warning Toast
          _buildToastCard(
            title: 'Warning',
            subtitle: 'Please proceed with caution',
            icon: Icons.warning,
            color: Colors.orange,
            onTap: () => NiceToast.warning(
              message: 'Your session will expire in 5 minutes. Please save your work.',
              title: 'Session Warning',
              position: ToastPosition.top,
            ),
          ),

          const SizedBox(height: 16),

          // Info Toast
          _buildToastCard(
            title: 'Information',
            subtitle: 'Here\'s something you should know',
            icon: Icons.info,
            color: Colors.blue,
            onTap: () => NiceToast.info(
              message: 'New features are available! Check out the latest updates.',
              title: 'What\'s New',
              position: ToastPosition.top,
            ),
          ),

          const SizedBox(height: 32),

          // Quick actions
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildQuickButton(
                        'Persistent',
                        Icons.push_pin,
                        Colors.purple,
                        () => NiceToast.successPersistent(
                          message: 'This toast stays until you dismiss it!',
                          title: 'Persistent Toast',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildQuickButton(
                        'Dismiss All',
                        Icons.clear_all,
                        Colors.grey,
                        () => NiceToast.dismiss(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToastCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickButton(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Position demo page - perfect for position screenshots
class PositionDemoPage extends StatelessWidget {
  const PositionDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Toast Positions',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'See how toasts appear in different positions',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),

          // Position buttons
          _buildPositionButton(
            'Top Position',
            'Toast appears at the top of the screen',
            Icons.keyboard_arrow_up,
            Colors.blue,
            () => NiceToast.success(
              message: 'This toast appears at the top!',
              title: 'Top Position',
              position: ToastPosition.top,
            ),
          ),

          const SizedBox(height: 16),

          _buildPositionButton(
            'Center Position',
            'Toast appears in the center of the screen',
            Icons.center_focus_strong,
            Colors.green,
            () => NiceToast.info(
              message: 'This toast appears in the center!',
              title: 'Center Position',
              position: ToastPosition.center,
            ),
          ),

          const SizedBox(height: 16),

          _buildPositionButton(
            'Bottom Position',
            'Toast appears at the bottom of the screen',
            Icons.keyboard_arrow_down,
            Colors.orange,
            () => NiceToast.warning(
              message: 'This toast appears at the bottom!',
              title: 'Bottom Position',
              position: ToastPosition.bottom,
            ),
          ),

          const SizedBox(height: 32),

          // Visual representation
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Stack(
              children: [
                // Phone outline
                Center(
                  child: Container(
                    width: 120,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: Column(
                      children: [
                        // Top indicator
                        Container(
                          margin: const EdgeInsets.all(8),
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(
                            child: Text('TOP', style: TextStyle(fontSize: 8)),
                          ),
                        ),
                        // Center indicator
                        Expanded(
                          child: Center(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Center(
                                child: Text('CENTER', style: TextStyle(fontSize: 8)),
                              ),
                            ),
                          ),
                        ),
                        // Bottom indicator
                        Container(
                          margin: const EdgeInsets.all(8),
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.orange.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(
                            child: Text('BOTTOM', style: TextStyle(fontSize: 8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24), // Add bottom padding
        ],
      ),
    );
  }

  Widget _buildPositionButton(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom toasts page - perfect for custom styling screenshots
class CustomToastsPage extends StatelessWidget {
  const CustomToastsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Custom Themes',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create beautiful custom toast designs',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),

          // Custom theme examples
          _buildCustomToastCard(
            'Purple Gradient',
            'Beautiful purple gradient theme',
            const LinearGradient(
              colors: [Colors.purple, Colors.deepPurple],
            ),
            Icons.stars,
            () => _showCustomToast(
              'Purple Gradient',
              'This is a beautiful purple gradient toast!',
              const LinearGradient(colors: [Colors.purple, Colors.deepPurple]),
              Icons.stars,
            ),
          ),

          const SizedBox(height: 16),

          _buildCustomToastCard(
            'Ocean Blue',
            'Cool ocean blue gradient theme',
            LinearGradient(
              colors: [Colors.blue[400]!, Colors.cyan[300]!],
            ),
            Icons.waves,
            () => _showCustomToast(
              'Ocean Blue',
              'Dive into this refreshing ocean blue theme!',
              LinearGradient(colors: [Colors.blue[400]!, Colors.cyan[300]!]),
              Icons.waves,
            ),
          ),

          const SizedBox(height: 16),

          _buildCustomToastCard(
            'Sunset Orange',
            'Warm sunset orange gradient theme',
            LinearGradient(
              colors: [Colors.orange[400]!, Colors.red[300]!],
            ),
            Icons.wb_sunny,
            () => _showCustomToast(
              'Sunset Orange',
              'Experience the warmth of a beautiful sunset!',
              LinearGradient(colors: [Colors.orange[400]!, Colors.red[300]!]),
              Icons.wb_sunny,
            ),
          ),

          const SizedBox(height: 16),

          _buildCustomToastCard(
            'Forest Green',
            'Natural forest green gradient theme',
            LinearGradient(
              colors: [Colors.green[400]!, Colors.teal[300]!],
            ),
            Icons.eco,
            () => _showCustomToast(
              'Forest Green',
              'Connect with nature through this green theme!',
              LinearGradient(colors: [Colors.green[400]!, Colors.teal[300]!]),
              Icons.eco,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomToastCard(String title, String subtitle, Gradient gradient, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.touch_app,
              color: Colors.white70,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomToast(String title, String message, Gradient gradient, IconData icon) {
    final customTheme = ToastTheme(
      backgroundColor: Colors.purple, // Fallback color
      gradient: gradient as LinearGradient,
      iconData: icon,
      textColor: Colors.white,
      iconColor: Colors.white,
      borderRadius: 12.0,
      borderWidth: 0,
      borderColor: Colors.transparent,
    );

    NiceToast.custom(
      message: message,
      title: title,
      theme: customTheme,
      position: ToastPosition.top,
    );
  }
}

/// Advanced demo page - for advanced features screenshots
class AdvancedDemoPage extends StatefulWidget {
  const AdvancedDemoPage({super.key});

  @override
  State<AdvancedDemoPage> createState() => _AdvancedDemoPageState();
}

class _AdvancedDemoPageState extends State<AdvancedDemoPage> {
  bool _dismissible = true;
  bool _persistent = false;
  double _margin = 50.0;
  Duration _duration = const Duration(seconds: 3);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Advanced Features',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Customize toast behavior and appearance',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),

          // Settings card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Toast Settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),

                // Duration slider
                Text('Duration: ${_duration.inSeconds}s'),
                Slider(
                  value: _duration.inSeconds.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  onChanged: _persistent
                      ? null
                      : (value) {
                          setState(() {
                            _duration = Duration(seconds: value.round());
                          });
                        },
                ),

                const SizedBox(height: 16),

                // Margin slider
                Text('Margin: ${_margin.round()}px'),
                Slider(
                  value: _margin,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  onChanged: (value) {
                    setState(() {
                      _margin = value;
                    });
                  },
                ),

                const SizedBox(height: 16),

                // Toggle switches
                Row(
                  children: [
                    Expanded(
                      child: SwitchListTile(
                        title: const Text('Dismissible'),
                        subtitle: const Text('Swipe to dismiss'),
                        value: _dismissible,
                        onChanged: (value) {
                          setState(() {
                            _dismissible = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                SwitchListTile(
                  title: const Text('Persistent'),
                  subtitle: const Text('Stays until manually closed'),
                  value: _persistent,
                  onChanged: (value) {
                    setState(() {
                      _persistent = value;
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Test button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_persistent) {
                  NiceToast.successPersistent(
                    message: 'This is a persistent toast with your custom settings!',
                    title: 'Custom Settings',
                    margin: _margin,
                  );
                } else {
                  NiceToast.success(
                    message: 'This toast uses your custom settings!',
                    title: 'Custom Settings',
                    duration: _duration,
                    margin: _margin,
                    dismissible: _dismissible,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Test Custom Settings',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Feature showcase
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.blue[600]),
                    const SizedBox(width: 8),
                    const Text(
                      'Pro Tips',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text('• Swipe horizontally to dismiss toasts'),
                const Text('• Tap on toasts to trigger custom actions'),
                const Text('• Use persistent toasts for important messages'),
                const Text('• Customize margins for different screen sizes'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
