import 'dart:convert';
import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:DefeDroid/nav_bar/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:DefeDroid/screens/theme.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  static const MethodChannel _platform =
      MethodChannel('com.DefeDroid.app/channel');
  List<String> _installedApps = [];
  List<String> _filteredApps = [];
  String? _selectedApp;

  @override
  void initState() {
    super.initState();
    _getInstalledApps();
  }

  Future<void> _getInstalledApps() async {
    try {
      final List<String>? installedApps =
          await _platform.invokeListMethod<String>('getInstalledApps');
      setState(() {
        _installedApps = installedApps ?? [];
        _filteredApps = List.from(_installedApps);
      });
    } on PlatformException catch (e) {
      print("Failed to get installed apps: '${e.message}'.");
      // Handle the error accordingly
    }
  }

  void _filterApps(String query) {
    setState(() {
      _filteredApps = _installedApps
          .where((app) => app.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _selectApp(String app) {
    setState(() {
      if (_selectedApp == app) {
        _selectedApp = null;
      } else {
        _selectedApp = app;
      }
    });
  }

  Future<void> _onSelectButtonPressed() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Feature Not Available'),
        content: const Text(
            'This feature is not available right now. It will be available in future updates.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _onDownloadButtonPressed() async {
    try {
      // Open a file picker for APK files
      const typeGroup = XTypeGroup(
        label: 'apk',
        extensions: ['apk'],
      );
      final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);

      if (file != null) {
        // Show a progress dialog indicating scanning is in progress
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const AlertDialog(
              title: Text('Scanning in Progress'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Please wait while the APK is being analyzed.'),
                ],
              ),
            );
          },
        );

        // Create a multipart request
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://192.168.0.186:8000/analyze_apk'),
        );

        // Add the file to the request
        request.files.add(http.MultipartFile.fromBytes(
          'apk',
          await file.readAsBytes(),
          filename: file.name,
          contentType: MediaType('application', 'vnd.android.package-archive'),
        ));

        // Send the request
        var response = await request.send();

        // Handle the response
        if (response.statusCode == 200) {
          var responseData = await response.stream.bytesToString();
          var result = json.decode(responseData);
          print('Analysis Result: $result');

          // Dismiss the progress dialog
          Navigator.of(context).pop();

          // Show the analysis result
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Analysis Result'),
              content:
                  Text('The APK scanned is: ${file.name}\n\nResult: $result'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          print('Failed to analyze APK: ${response.reasonPhrase}');
          // Dismiss the progress dialog
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      if (e is HttpException) {
        print('Error sending request: ${e.message}');
        // Show an error message to the user (e.g., network issue)
      } else {
        print('Error selecting or analyzing APK: $e');
      }
      // Dismiss the progress dialog
      Navigator.of(context).pop();
    }
  }

  void _startSearch() {
    showSearch(
      context: context,
      delegate: _AppSearchDelegate(_installedApps, _filterApps),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Theme(
      data: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Applications",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const MyBottomNavBar(),
                ),
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _startSearch,
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: _filteredApps.length,
          itemBuilder: (context, index) {
            final app = _filteredApps[index];
            final isSelected = _selectedApp == app;
            return GestureDetector(
              onTap: () {
                _selectApp(app);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                margin: const EdgeInsets.symmetric(horizontal: 21, vertical: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onSurface, width: 1),
                  color: Theme.of(context).colorScheme.background,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      app,
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.grey[900],
                      ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFD29E1A), // Yellow color
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 90),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: _onDownloadButtonPressed,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  backgroundColor: const Color(0xFFD29E1A), // Green color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Go to download',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _onSelectButtonPressed,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                  backgroundColor:
                      Colors.grey, // Grey color to indicate disabled
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child:
                    const Text('Select', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppSearchDelegate extends SearchDelegate<String> {
  final List<String> apps;
  final Function(String) onSearchChanged;

  _AppSearchDelegate(this.apps, this.onSearchChanged);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearchChanged(query);
    return ListView(
      children: apps
          .where((app) => app.toLowerCase().contains(query.toLowerCase()))
          .map((app) => ListTile(
                title: Text(app),
                onTap: () {
                  close(context, app);
                },
              ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? []
        : apps
            .where((app) => app.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}
