import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard
// TODO: Add necessary plugin imports:
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart'; // Recommended for Theme management
// import 'package:contacts_service/contacts_service.dart'; // Or flutter_contacts
// import 'package:add_2_calendar/add_2_calendar.dart';
// import 'package:vibration/vibration.dart';
// import 'package:audioplayers/audioplayers.dart';

// --- Constants ---
const String prefKeyTheme = 'app_theme';
const String prefKeySound = 'scan_sound_enabled';
const String prefKeyVibrate = 'scan_vibrate_enabled';
const String prefKeyBrowser = 'default_browser'; // 'in_app' or 'external'
const String prefKeyHistory = 'history_management'; // 'keep', 'delete_30d'

// --- Main App Entry Point ---
void main() {
  // TODO: Initialize SharedPreferences or Provider before runApp if needed
  runApp(
    // TODO: Wrap with ChangeNotifierProvider if using Provider for theme/settings
    const QRScannerApp(),
  );
}

class QRScannerApp extends StatelessWidget {
  const QRScannerApp({super.key});

  // TODO: Add logic here (or in a Provider) to load the theme preference
  ThemeMode _getThemeMode() {
    // Placeholder: Load from SharedPreferences or Provider state
    // String themePref = prefs.getString(prefKeyTheme) ?? 'system';
    // switch (themePref) {
    //   case 'light': return ThemeMode.light;
    //   case 'dark': return ThemeMode.dark;
    //   default: return ThemeMode.system;
    // }
    return ThemeMode.dark; // Default to dark for now
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Listen to theme changes if using Provider
    // final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'QR Scanner UI',
      themeMode: _getThemeMode(), // Use dynamic theme mode
      theme: ThemeData(
        // Light Theme definition
        brightness: Brightness.light,
        primarySwatch: Colors.cyan,
        scaffoldBackgroundColor: Colors.grey[100],
        cardColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.cyan, // Example light theme appbar
          elevation: 1,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.cyan,
          unselectedItemColor: Colors.grey[600],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
          titleMedium:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          labelSmall: TextStyle(color: Colors.black54, fontSize: 11),
        ),
        iconTheme: IconThemeData(color: Colors.grey[700]),
        dividerColor: Colors.grey[300],
        tabBarTheme: TabBarTheme(
          indicatorColor: Colors.cyan,
          labelColor: Colors.cyan,
          unselectedLabelColor: Colors.grey[600],
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.cyan, // Default color for leading icons in settings
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.selected)) return Colors.cyan;
            return null; // Defaults
          }),
          trackColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.selected))
              return Colors.cyan.withOpacity(0.5);
            return null; // Defaults
          }),
        ),
      ),
      darkTheme: ThemeData(
        // Dark Theme definition (original)
        brightness: Brightness.dark,
        primarySwatch: Colors.cyan,
        scaffoldBackgroundColor: const Color(0xFF1F1F1F),
        cardColor: const Color(0xFF2C2C2E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1F1F1F),
          selectedItemColor: Color(0xFF00BCD4),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white70),
          titleMedium:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          labelSmall: TextStyle(color: Colors.white70, fontSize: 11),
        ),
        iconTheme: const IconThemeData(color: Colors.white70),
        dividerColor: Colors.grey[800],
        tabBarTheme: TabBarTheme(
          indicatorColor: const Color(0xFF00BCD4),
          labelColor: const Color(0xFF00BCD4),
          unselectedLabelColor: Colors.grey[400],
        ),
        listTileTheme: ListTileThemeData(
          iconColor: const Color(
              0xFF00BCD4), // Default color for leading icons in settings
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.selected))
              return const Color(0xFF00BCD4);
            return null; // Defaults
          }),
          trackColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.selected))
              return const Color(0xFF00BCD4).withOpacity(0.5);
            return null; // Defaults
          }),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
      routes: {
        // Define route for settings screen
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}

// --- Main Screen (Bottom Navigation) --- remains largely the same
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1; // Start with Scan screen

  static const List<Widget> _widgetOptions = <Widget>[
    CreateScreen(),
    ScanScreen(),
    HistoryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        // Use IndexedStack to preserve state of screens
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              activeIcon: Icon(Icons.add_box),
              label: 'Create'),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner_outlined),
              activeIcon: Icon(Icons.qr_code_scanner),
              label: 'Scan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined),
              activeIcon: Icon(Icons.history),
              label: 'History'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// --- Create Screen (Added more types) ---
class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.menu), // Or Icons.settings for direct nav
            onPressed: () {
              // TODO: Implement drawer or navigate directly to Settings
              Navigator.pushNamed(context, '/settings');
            }),
        title: const Text('Create'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('QR Codes', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.0,
              children: const [
                _GridButton(
                    icon: Icons.content_paste,
                    label: 'Clipboard',
                    color: Colors.green),
                _GridButton(
                    icon: Icons.link, label: 'Website', color: Colors.blue),
                _GridButton(
                    icon: Icons.wifi,
                    label: 'Wi-Fi',
                    color: Colors.lightBlueAccent),
                _GridButton(
                    icon: Icons.text_fields,
                    label: 'Text',
                    color: Colors.orange),
                _GridButton(
                    icon: Icons.person_outline,
                    label: 'Contact (vCard)',
                    color: Colors.purpleAccent), // Updated Label
                _GridButton(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    color: Colors.pinkAccent),
                _GridButton(
                    icon: Icons.phone_outlined,
                    label: 'Phone Number',
                    color: Colors.deepPurpleAccent),
                _GridButton(
                    icon: Icons.sms_outlined,
                    label: 'SMS',
                    color: Colors.amber),
                _GridButton(
                    icon: Icons.event,
                    label: 'Calendar Event',
                    color: Colors.teal), // New
                _GridButton(
                    icon: Icons.location_on_outlined,
                    label: 'Geo Location',
                    color: Colors.red), // New
                _GridButton(
                    icon: Icons.store_mall_directory_outlined,
                    label: 'App Store Link',
                    color: Colors.indigo), // New
                // Placeholder for Customization trigger? Or done in detail view.
              ],
            ),
            const SizedBox(height: 24),
            Padding(
              // Add padding for section title
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text('QR Code Customization',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            // TODO: Add UI elements for QR customization (Color, Logo, Error Level)
            // These would typically be on the *next* screen after selecting a type & entering data.
            // Example placeholder:
            ListTile(
              leading: const Icon(Icons.color_lens_outlined),
              title: const Text("Customize Appearance"),
              subtitle: const Text("Set colors, add logo (on next screen)"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                /* TODO: Navigate to QR detail/customization screen after type selected */
              },
            ),

            const SizedBox(height: 24),
            Text('Barcodes', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.0,
              children: const [
                _GridButton(
                    icon: Icons.barcode_reader,
                    label: 'EAN-8',
                    color: Colors.redAccent),
                _GridButton(
                    icon: Icons.barcode_reader,
                    label: 'EAN-13',
                    color: Colors.redAccent),
                _GridButton(
                    icon: Icons.barcode_reader,
                    label: 'UPC-E',
                    color: Colors.redAccent),
                _GridButton(
                    icon: Icons.barcode_reader,
                    label: 'UPC-A',
                    color: Colors.redAccent),
                _GridButton(
                    icon: Icons.barcode_reader,
                    label: 'CODE-39',
                    color: Colors.redAccent),
                _GridButton(
                    icon: Icons.barcode_reader,
                    label: 'CODE-93',
                    color: Colors.redAccent),
                _GridButton(
                    icon: Icons.barcode_reader,
                    label: 'CODE-128',
                    color: Colors.redAccent), // New
                _GridButton(
                    icon: Icons.grid_on,
                    label: 'Data Matrix',
                    color: Colors.deepOrange), // New (using generic grid icon)
                _GridButton(
                    icon: Icons.view_column,
                    label: 'PDF417',
                    color:
                        Colors.deepOrange), // New (using generic column icon)
                _GridButton(
                    icon: Icons.apps,
                    label: 'Aztec',
                    color: Colors.deepOrange), // New (using generic apps icon)
                // Add ITF, Codabar if needed
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Helper Grid Button (remains the same)
class _GridButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _GridButton({
    required this.icon,
    required this.label,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    /* ... as before ... */ return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          /* TODO: Handle button tap - navigate to specific creation form */
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}

// --- Scan Screen (Added Gallery Scan Icon) ---
class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool _isFlashOn = false;
  double _zoomLevel = 0.5; // Example zoom state

  // TODO: Initialize camera controller here (e.g., mobile_scanner)

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
    // TODO: Add logic to control actual camera flash using the controller
    print("Flash Toggled: $_isFlashOn");
  }

  void _scanFromGallery() async {
    // TODO: Implement image picking using image_picker plugin
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // if (image != null) {
    // TODO: Process the image file (image.path) using a suitable QR scanning library
    // that supports scanning from files/bitmaps. mobile_scanner might need adapting
    // or use another library like zxing_lib or google_ml_kit_barcode_scanning.
    print("Scan from Gallery selected");
    // }
  }

  void _handleZoom(double value) {
    setState(() {
      _zoomLevel = value;
    });
    // TODO: Control camera zoom using the controller
    print("Zoom changed: $_zoomLevel");
  }

  @override
  void initState() {
    super.initState();
    // TODO: Initialize and start camera stream here
  }

  @override
  void dispose() {
    // TODO: Dispose camera controller here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background (Simulated Camera Feed)
          Container(
            color: Colors.black,
            // TODO: Replace with actual CameraPreview widget
            child: const Center(
                child: Text("Camera Preview Area",
                    style: TextStyle(color: Colors.grey))),
          ),

          // 2. Scanning Area and UI Elements
          Column(
            /* ... as before ... */
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Text(
                "Point the camera at the\nqr or barcode",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.9), fontSize: 16),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                height: MediaQuery.of(context).size.width * 0.65,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.cyan.withOpacity(0.7), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.60,
                height: 2,
                decoration: BoxDecoration(
                  color: Colors.cyanAccent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyanAccent.withAlpha(150),
                      blurRadius: 8.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                margin: const EdgeInsets.only(top: 5),
              ),
              const Spacer(flex: 3),
            ],
          ),

          // 3. Top Icons (Flash, Gallery)
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off,
                      color: Colors.white),
                  tooltip: 'Toggle Flash',
                  onPressed: _toggleFlash,
                ),
                IconButton(
                  icon: const Icon(Icons.image_outlined, color: Colors.white),
                  tooltip: 'Scan from Gallery',
                  onPressed: _scanFromGallery, // Added action
                ),
              ],
            ),
          ),

          // 4. Zoom Slider
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            bottom: MediaQuery.of(context).size.height * 0.3,
            right: 10,
            child: RotatedBox(
              quarterTurns: 3,
              child: Slider(
                value: _zoomLevel,
                min: 0.0,
                max: 1.0, // TODO: Adjust max based on camera capabilities
                activeColor: Colors.cyan,
                inactiveColor: Colors.white30,
                onChanged: _handleZoom, // Added action
              ),
            ),
          ),

          // TODO: Add indicator for Continuous Scan mode if implemented
        ],
      ),
    );
  }
}

// --- History Screen (Added Contextual Actions on Tap) ---
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // Dummy Data - Replace with actual data loaded from storage/state management
  final List<Map<String, dynamic>> _scannedItems = [
    {
      'type': 'Website',
      'data': 'http://facebook.com',
      'icon': Icons.link,
      'color': Colors.blue,
      'timestamp': DateTime.now().subtract(const Duration(hours: 1))
    },
    {
      'type': 'Clipboard',
      'data': 'This is a single line input copied to clipboard.',
      'icon': Icons.content_paste,
      'color': Colors.green,
      'timestamp': DateTime.now().subtract(const Duration(hours: 2))
    },
    {
      'type': 'Email',
      'data': 'mailto:ahukarli@lyrebirdstudio.example.com',
      'icon': Icons.email_outlined,
      'color': Colors.pinkAccent,
      'timestamp': DateTime.now().subtract(const Duration(days: 1))
    },
    {
      'type': 'Barcode: EAN-8',
      'data': '4012345',
      'icon': Icons.barcode_reader,
      'color': Colors.redAccent,
      'timestamp': DateTime.now().subtract(const Duration(days: 1))
    },
    // Example vCard like structure (simplified)
    {
      'type': 'Contact',
      'data':
          'BEGIN:VCARD\nVERSION:3.0\nN:Karli;Ahu\nORG:Lyrebird Studio\nTEL;TYPE=WORK,VOICE:(555) 555-1234\nEMAIL:ahu@example.com\nADR;TYPE=WORK:;;123 Flutter Ln;Anytown;CA;91234;USA\nEND:VCARD',
      'icon': Icons.person_outline,
      'color': Colors.purpleAccent,
      'timestamp': DateTime.now().subtract(const Duration(days: 2))
    },
    {
      'type': 'Phone Number',
      'data': 'tel:+15555551234',
      'icon': Icons.phone_outlined,
      'color': Colors.deepPurpleAccent,
      'timestamp': DateTime.now().subtract(const Duration(days: 3))
    },
    // Example Wi-Fi structure
    {
      'type': 'Wi-Fi',
      'data': 'WIFI:S:MyNetwork;T:WPA;P:MyPassword;;',
      'icon': Icons.wifi,
      'color': Colors.lightBlueAccent,
      'timestamp': DateTime.now().subtract(const Duration(days: 4))
    },
    // Example Geo structure
    {
      'type': 'Geo Location',
      'data': 'geo:37.7749,-122.4194?q=Golden+Gate+Bridge',
      'icon': Icons.location_on_outlined,
      'color': Colors.red,
      'timestamp': DateTime.now().subtract(const Duration(days: 5))
    },
    // Example Calendar Event structure (simplified iCalendar)
    {
      'type': 'Calendar Event',
      'data':
          'BEGIN:VEVENT\nSUMMARY:Team Meeting\nDTSTART:20240815T100000Z\nDTEND:20240815T110000Z\nLOCATION:Conference Room A\nEND:VEVENT',
      'icon': Icons.event,
      'color': Colors.teal,
      'timestamp': DateTime.now().subtract(const Duration(days: 6))
    },
  ];
  final List<Map<String, dynamic>> _createdItems = [/* ... as before ... */];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            }),
        title: const Text('History'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Scanned'),
            Tab(text: 'Created'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildHistoryList(_scannedItems),
          _buildHistoryList(_createdItems),
        ],
      ),
    );
  }

  Widget _buildHistoryList(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return const Center(child: Text("No history yet."));
    }
    // TODO: Add Sorting/Filtering controls here if needed

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        // Basic display logic - real parsing needed for complex types
        String displayData = item['data'];
        if (item['type'] == 'Contact' ||
            item['type'] == 'Wi-Fi' ||
            item['type'] == 'Calendar Event' ||
            item['type'] == 'Geo Location') {
          // Show a summary instead of raw data
          displayData = _summarizeComplexData(item['type'], item['data']);
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: (item['color'] as Color).withOpacity(0.2),
                child: Icon(item['icon'], color: item['color'], size: 24),
              ),
              title: Text(item['type'],
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 15)),
              subtitle: Text(
                displayData,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 13),
              ),
              trailing: IconButton(
                icon: Icon(Icons.copy_outlined,
                    size: 20,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.6)),
                tooltip: 'Copy Raw Data',
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: item['data']));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Raw data copied to clipboard'),
                        duration: Duration(seconds: 1)),
                  );
                },
              ),
              onTap: () {
                // *** Show Contextual Actions ***
                _showContextualActions(context, item);
              },
            ),
          ),
        );
      },
    );
  }

  // Helper to show summarized data for complex types in the list
  String _summarizeComplexData(String type, String data) {
    // TODO: Implement proper parsing for vCard, WIFI, iCal, Geo URI etc.
    switch (type) {
      case 'Contact':
        return data
            .split('\n')
            .firstWhere((line) => line.startsWith('N:'),
                orElse: () => 'Contact Details')
            .substring(2); // Crude name extraction
      case 'Wi-Fi':
        return data
            .split(';')
            .firstWhere((part) => part.startsWith('S:'),
                orElse: () => 'Wi-Fi Network')
            .substring(2); // Crude SSID extraction
      case 'Calendar Event':
        return data
            .split('\n')
            .firstWhere((line) => line.startsWith('SUMMARY:'),
                orElse: () => 'Calendar Event')
            .substring(8); // Crude summary extraction
      case 'Geo Location':
        return data.split('?').first; // Show coordinates part
      default:
        return data;
    }
  }

  // --- Contextual Actions Logic ---
  void _showContextualActions(BuildContext context, Map<String, dynamic> item) {
    final type = item['type'] as String;
    final data = item['data'] as String;
    List<Widget> actions = [];

    // Helper for adding actions
    void addAction(String title, IconData icon, VoidCallback onTap) {
      actions.add(ListTile(
        leading: Icon(icon, color: Theme.of(context).listTileTheme.iconColor),
        title: Text(title),
        onTap: () {
          Navigator.pop(context); // Close bottom sheet/dialog
          onTap(); // Execute action
        },
      ));
    }

    // --- Determine Actions based on Type ---

    // Common Action: Copy Raw Data (if different from simple copy)
    // addAction('Copy Raw Data', Icons.copy_all_outlined, () => _copyToClipboard(data, 'Raw data'));

    // Common Action: Share Raw Data
    addAction('Share Raw Data', Icons.share_outlined, () => _shareData(data));

    if (type.contains('Website') ||
        data.startsWith('http://') ||
        data.startsWith('https://')) {
      addAction('Open in Browser', Icons.open_in_browser,
          () => _launchURL(data, context));
      addAction('Copy Link', Icons.link, () => _copyToClipboard(data, 'Link'));
      // Share action is already common
    } else if (type.contains('Email') || data.startsWith('mailto:')) {
      addAction(
          'Send Email',
          Icons.email_outlined,
          () => _launchURL(
              data, context)); // mailto: links work with url_launcher
      final emailAddress =
          data.replaceFirst('mailto:', '').split('?').first; // Extract address
      addAction('Copy Email Address', Icons.copy,
          () => _copyToClipboard(emailAddress, 'Email address'));
      addAction('Add to Contacts', Icons.person_add_alt_1,
          () => _addEmailToContacts(emailAddress));
    } else if (type.contains('Phone') || data.startsWith('tel:')) {
      final phoneNumber = data.replaceFirst('tel:', '');
      addAction('Call Number', Icons.phone_outlined,
          () => _launchURL('tel:$phoneNumber', context));
      addAction('Send SMS', Icons.sms_outlined,
          () => _launchURL('sms:$phoneNumber', context));
      addAction('Copy Number', Icons.copy,
          () => _copyToClipboard(phoneNumber, 'Phone number'));
      addAction('Add to Contacts', Icons.person_add_alt_1,
          () => _addPhoneToContacts(phoneNumber));
    } else if (type.contains('SMS') ||
        data.startsWith('smsto:') ||
        data.startsWith('sms:')) {
      addAction(
          'Send SMS', Icons.sms_outlined, () => _launchURL(data, context));
      // Potentially parse number/body to copy separately
      addAction('Copy SMS Data', Icons.copy,
          () => _copyToClipboard(data, 'SMS data'));
    } else if (type.contains('Contact')) {
      // Assuming vCard format in 'data'
      addAction('Add to Contacts', Icons.person_add_alt_1,
          () => _addVCardToContacts(data));
      // TODO: Add options to call/email directly by parsing vCard data? (more complex)
    } else if (type.contains('Wi-Fi')) {
      // Assuming WIFI: format
      addAction(
          'Connect to Wi-Fi',
          Icons.wifi_tethering,
          () => _connectToWifi(
              data, context)); // Needs special permissions/plugins
      addAction('Copy Network Name (SSID)', Icons.copy,
          () => _copyWifiDetail(data, 'S:', 'Network name'));
      addAction('Copy Password', Icons.password_outlined,
          () => _copyWifiDetail(data, 'P:', 'Password'));
    } else if (type.contains('Geo')) {
      // Assuming geo: format
      addAction(
          'Open in Maps', Icons.map_outlined, () => _launchURL(data, context));
      addAction('Copy Coordinates', Icons.copy,
          () => _copyToClipboard(data.split('?').first, 'Coordinates'));
    } else if (type.contains('Calendar Event')) {
      // Assuming iCalendar VEVENT format
      addAction(
          'Add to Calendar', Icons.event, () => _addEventToCalendar(data));
    } else if (type.contains('Barcode')) {
      addAction(
          'Search Online',
          Icons.search,
          () => _launchURL(
              'https://www.google.com/search?q=${Uri.encodeComponent(data)}',
              context));
      addAction(
          'Copy Code', Icons.copy, () => _copyToClipboard(data, 'Barcode'));
    } else {
      // Default for Text, Clipboard, etc.
      addAction('Copy Text', Icons.copy, () => _copyToClipboard(data, 'Text'));
      addAction(
          'Search Web',
          Icons.search,
          () => _launchURL(
              'https://www.google.com/search?q=${Uri.encodeComponent(data)}',
              context));
    }

    // --- Show the Actions ---
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          // Ensures content avoids notches/system areas
          child: SingleChildScrollView(
            // In case there are many actions
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: actions.isNotEmpty
                  ? actions
                  : [
                      const ListTile(
                          title: Text('No specific actions available.'))
                    ],
            ),
          ),
        );
      },
    );
  }

  // --- Placeholder Action Handlers ---
  // TODO: Implement these using appropriate plugins (url_launcher, share_plus, contacts_service, etc.)

  void _launchURL(String url, BuildContext context) async {
    print("Attempting to launch: $url");
    // TODO: Get browser preference from settings
    // bool useInApp = await _getBrowserPreference() == 'in_app';
    // final uri = Uri.parse(url);
    // if (await canLaunchUrl(uri)) {
    //    await launchUrl(uri, mode: useInApp ? LaunchMode.inAppWebView : LaunchMode.externalApplication);
    // } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Could not launch $url')));
    // }
  }

  void _copyToClipboard(String text, String dataType) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$dataType copied to clipboard')));
    print("Copied: $text");
  }

  void _shareData(String data) {
    print("Sharing: $data");
    // TODO: Use share_plus plugin
    // Share.share(data);
  }

  void _addEmailToContacts(String email) {
    print("Adding email to contacts: $email");
    // TODO: Use contacts_service or flutter_contacts
    // Contact newContact = Contact(emails: [Item(label: "email", value: email)]);
    // await ContactsService.addContact(newContact);
  }

  void _addPhoneToContacts(String phone) {
    print("Adding phone to contacts: $phone");
    // TODO: Use contacts_service or flutter_contacts
    // Contact newContact = Contact(phones: [Item(label: "mobile", value: phone)]);
    // await ContactsService.addContact(newContact);
  }

  void _addVCardToContacts(String vCardData) {
    print("Adding vCard to contacts");
    // TODO: Parse vCard data and use contacts_service
    // This is more involved, requires parsing the vCard string fields.
    // Contact contact = Contact.fromVcard(vCardData); // Hypothetical parsing
    // await ContactsService.addContact(contact);
  }

  void _connectToWifi(String wifiData, BuildContext context) {
    print("Attempting to connect to Wi-Fi");
    // TODO: Parse SSID, Password, Type from wifiData
    // TODO: Use wifi_connector or platform channels. This is often restricted by OS.
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('Wi-Fi connection requires specific permissions and setup.')));
  }

  void _copyWifiDetail(String wifiData, String prefix, String dataType) {
    // Very basic parsing, assumes simple WIFI:S:ssid;T:WPA;P:pass;; format
    final parts = wifiData.replaceFirst('WIFI:', '').split(';');
    String value = '';
    for (String part in parts) {
      if (part.startsWith(prefix)) {
        value = part.substring(prefix.length);
        break;
      }
    }
    if (value.isNotEmpty) {
      _copyToClipboard(value, dataType);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$dataType not found in QR code')));
    }
  }

  void _addEventToCalendar(String iCalData) {
    print("Adding event to calendar");
    // TODO: Parse iCalData (VEVENT) - This can be complex!
    // Use the add_2_calendar plugin
    // Example (requires parsing SUMMARY, DTSTART, DTEND, LOCATION etc. from iCalData):
    // final Event event = Event(
    //   title: 'Parsed Title',
    //   description: 'Parsed Description',
    //   location: 'Parsed Location',
    //   startDate: DateTime.parse('Parsed Start Date'), // Needs proper DateTime parsing
    //   endDate: DateTime.parse('Parsed End Date'),
    // );
    // await Add2Calendar.addEvent2Cal(event);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Calendar integration requires parsing iCal data.')));
  }
}

// --- Settings Screen ---
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // TODO: Load initial values from SharedPreferences or Provider
  bool _soundEnabled = true;
  bool _vibrateEnabled = true;
  String _browserPreference = 'external'; // 'in_app', 'external'
  String _historyPreference = 'keep'; // 'keep', 'delete_30d'
  ThemeMode _themeMode = ThemeMode.system; // Example state

  // TODO: Add AudioPlayer instance for sound feedback if needed
  // final _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    // TODO: Load preferences using shared_preferences plugin
    // final prefs = await SharedPreferences.getInstance();
    setState(() {
      // _soundEnabled = prefs.getBool(prefKeySound) ?? true;
      // _vibrateEnabled = prefs.getBool(prefKeyVibrate) ?? true;
      // _browserPreference = prefs.getString(prefKeyBrowser) ?? 'external';
      // _historyPreference = prefs.getString(prefKeyHistory) ?? 'keep';
      // String themePref = prefs.getString(prefKeyTheme) ?? 'system';
      // _themeMode = themePref == 'light' ? ThemeMode.light : (themePref == 'dark' ? ThemeMode.dark : ThemeMode.system);
    });
    print("Settings Loaded (Placeholders)");
  }

  Future<void> _updateSetting(String key, dynamic value) async {
    // TODO: Save preference using shared_preferences plugin
    // final prefs = await SharedPreferences.getInstance();
    // if (value is bool) await prefs.setBool(key, value);
    // if (value is String) await prefs.setString(key, value);
    print("Setting Updated: $key = $value (Placeholder)");

    // If theme changed, notify the app (e.g., using Provider)
    if (key == prefKeyTheme) {
      // TODO: Use Provider to update theme globally
      // Provider.of<ThemeProvider>(context, listen: false).setTheme(value);
      print(
          "Theme change requires Provider/State Management to take effect visually.");
    }
    if (key == prefKeySound && value == true) _playSound();
    if (key == prefKeyVibrate && value == true) _vibrate();

    // Reload settings locally for UI update (can be removed if using Provider)
    _loadSettings();
  }

  void _playSound() {
    if (_soundEnabled) {
      print("Playing scan sound (placeholder)");
      // TODO: Play a short sound using audioplayers
      // _audioPlayer.play(AssetSource('sounds/scan_beep.wav')); // Example
    }
  }

  void _vibrate() {
    if (_vibrateEnabled) {
      print("Vibrating (placeholder)");
      // TODO: Use vibration plugin
      // Vibration.vibrate(duration: 100);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Scan Feedback'),
          SwitchListTile(
            title: const Text('Sound on Scan'),
            secondary: const Icon(Icons.volume_up_outlined),
            value: _soundEnabled,
            onChanged: (value) {
              setState(() => _soundEnabled = value); // Optimistic UI update
              _updateSetting(prefKeySound, value);
            },
          ),
          SwitchListTile(
            title: const Text('Vibrate on Scan'),
            secondary: const Icon(Icons.vibration),
            value: _vibrateEnabled,
            onChanged: (value) {
              setState(() => _vibrateEnabled = value); // Optimistic UI update
              _updateSetting(prefKeyVibrate, value);
            },
          ),

          _buildSectionHeader('Opening Links'),
          ListTile(
            leading: const Icon(Icons.open_in_browser_outlined),
            title: const Text('Default Browser'),
            trailing: DropdownButton<String>(
              value: _browserPreference,
              underline: Container(), // Remove underline
              items: const [
                DropdownMenuItem(
                    value: 'external', child: Text('External App')),
                DropdownMenuItem(
                    value: 'in_app', child: Text('In-App Browser')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _browserPreference = value);
                  _updateSetting(prefKeyBrowser, value);
                }
              },
            ),
          ),

          _buildSectionHeader('Appearance'),
          ListTile(
            leading: const Icon(Icons.brightness_6_outlined),
            title: const Text('Theme'),
            trailing: DropdownButton<ThemeMode>(
              value: _themeMode,
              underline: Container(),
              items: const [
                DropdownMenuItem(
                    value: ThemeMode.system, child: Text('System Default')),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _themeMode = value);
                  String themePref = value == ThemeMode.light
                      ? 'light'
                      : (value == ThemeMode.dark ? 'dark' : 'system');
                  _updateSetting(prefKeyTheme, themePref);
                }
              },
            ),
          ),

          _buildSectionHeader('History'),
          ListTile(
            leading: const Icon(Icons.history_toggle_off_outlined),
            title: const Text('Manage History'),
            trailing: DropdownButton<String>(
              value: _historyPreference,
              underline: Container(),
              items: const [
                DropdownMenuItem(value: 'keep', child: Text('Keep Forever')),
                DropdownMenuItem(
                    value: 'delete_30d', child: Text('Delete after 30 days')),
                // Add more options if needed
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _historyPreference = value);
                  _updateSetting(prefKeyHistory, value);
                }
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.delete_forever_outlined,
                color: Colors.redAccent[100]),
            title: Text('Clear Scan History',
                style: TextStyle(color: Colors.redAccent[100])),
            onTap: () {
              // TODO: Show confirmation dialog
              // TODO: Implement history clearing logic (delete from storage/database)
              print("Clear History Tapped");
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Clear history action (placeholder)')));
            },
          ),

          _buildSectionHeader('iOS Widget (Informational)'),
          const ListTile(
            leading: Icon(Icons.widgets_outlined),
            title: Text('Home Screen Widget'),
            subtitle: Text(
                'Requires native setup in Xcode using WidgetKit and communication (MethodChannel/background tasks) with the Flutter app.'),
            enabled: false, // Make it non-interactive
          ),

          // Add other settings like About, Rate App, Privacy Policy etc.
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 16.0, right: 16.0, top: 20.0, bottom: 8.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary, // Use primary color
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

// --- Helper Barcode Icon Extension (remains the same) ---
extension BarcodeIcon on IconData {
  static const IconData barcode_reader = Icons.qr_code_scanner;
}
