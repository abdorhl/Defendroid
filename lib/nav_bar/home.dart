import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:DefeDroid/nav_bar/search.dart';
import 'package:DefeDroid/screens/theme.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class HomePage extends StatefulWidget {
  final String? appName;
  final String? appIconPath;
  final Function(String)? onScanPressed;
  final Function(String)? onAppSelected;

  const HomePage({
    super.key,
    this.appName,
    this.appIconPath,
    this.onScanPressed,
    this.onAppSelected,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bool _isModelLoaded = false;
  bool _isScanning = false;
  late Stopwatch _stopwatch;
  late Timer _timer;

  late Interpreter _interpreter; // Declare interpreter

  final String _lastAppScanned = "No app scanned yet";
  final List<String> _maliciousInfo = [
    "Malicious APK found: Riskware",
    "Suspicious APK detected: Adware",
    "Malicious APK found: Trojan",
    "Suspicious APK detected: Spyware"
  ];
  int _currentInfoIndex = 0;
  late Timer _infoSwitchTimer;

  void _startScanTimer() {
    _stopwatch.reset();
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  void _stopScanTimer() {
    _stopwatch.stop();
    _timer.cancel();
    setState(() {
      _isScanning = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _infoSwitchTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentInfoIndex = (_currentInfoIndex + 1) % _maliciousInfo.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _infoSwitchTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.isDark;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: isDarkMode
                ? Colors.grey[900]
                : const Color.fromARGB(136, 126, 126, 122),
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/map.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 50,
            left: 20,
            child: Text(
              "Defendozer",
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 23,
            right: -6,
            child: Image.asset(
              'assets/logo.png',
              width: 100,
              height: 100,
            ),
          ),
          Positioned(
            top: 150, // Adjusted this value to move the button higher
            left: MediaQuery.of(context).size.width / 2 - 125,
            right: MediaQuery.of(context).size.width / 2 - 125,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoritePage()),
                );
              },
              child: Container(
                width: 250,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDarkMode
                        ? const Color(0xFF242424)
                        : Colors.grey[300]!,
                    width: 1,
                  ),
                  color: isDarkMode
                      ? const Color.fromARGB(255, 54, 54, 54)
                      : Colors.white,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Choose App',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 250, // Adjusted this value to move the circle higher
            left: MediaQuery.of(context).size.width / 2 - 163,
            child: GestureDetector(
              // onTap: () async {
              //   if (!_isModelLoaded) {
              //     await loadModel();
              //   } else {
              //     print('Model is loaded. Now you can use it for scanning.');
              //     // Perform the APK analysis when the circle is tapped
              //     await _analyzeAPK();
              //   }
              // },
              child: SizedBox(
                width: 326,
                height: 326,
                child: Stack(
                  children: [
                    Positioned(
                      left: -7,
                      top: -7,
                      child: Opacity(
                        opacity: 0.10,
                        child: Container(
                          width: 340,
                          height: 340,
                          decoration:
                              const ShapeDecoration(shape: OvalBorder()),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 48.76,
                      top: 47.40,
                      child: Opacity(
                        opacity: 0.86,
                        child: Container(
                          width: 229.84,
                          height: 229.84,
                          decoration: const ShapeDecoration(
                            shape: OvalBorder(
                              side: BorderSide(
                                  width: 2.50, color: Color(0xFFD29E1A)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 100.44,
                      top: 99.08,
                      child: Opacity(
                        opacity: 0.80,
                        child: Container(
                          width: 126.48,
                          height: 126.48,
                          decoration: const ShapeDecoration(
                            color: Color.fromARGB(255, 223, 220, 220),
                            shape: OvalBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xFFD29E1A)),
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/scanico.png',
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 130,
                      top: 300,
                      child: SizedBox(
                        width: 68,
                        height: 55.64,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Text(
                                'Tap to Scan',
                                style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 600, // Adjusted this value to position the cards below the circle
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HistoryPage()),
                    );
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 60) / 2, // Square width
                    height: (MediaQuery.of(context).size.width - 60) / 2, // Square height
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? const Color.fromARGB(255, 54, 54, 54)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDarkMode
                            ? const Color(0xFF242424)
                            : Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          color: isDarkMode ? Colors.white : Colors.black,
                          size: 40,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Last app scanned:\n$_lastAppScanned',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width - 60) / 2, // Square width
                  height: (MediaQuery.of(context).size.width - 60) / 2, // Square height
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color.fromARGB(255, 54, 54, 54)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDarkMode
                          ? const Color(0xFF242424)
                          : Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bug_report,
                        color: isDarkMode ? Colors.white : Colors.black,
                        size: 40,
                      ),
                      SizedBox(height: 10),
                      Text(
                        _maliciousInfo[_currentInfoIndex],
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan History'),
      ),
      body: Center(
        child: const Text('History of scanned apps will be shown here.'),
      ),
    );
  }
}