import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:DefeDroid/screens/theme.dart'; // Import ThemeNotifier from theme.dart

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    // final mode = Mode();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "More",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildText('Rating', context),
            const SizedBox(height: 20),
            _buildRectangleForWriting(),
            const SizedBox(height: 20),
            _buildText('Support', context),
            const SizedBox(height: 20),
            _buildSupportItem(
              context,
              title: 'Help',
              description: 'Get assistance for using the app.',
            ),
            const SizedBox(height: 10),
            _buildSupportItem(
              context,
              title: 'FAQ',
              description: 'Find answers to frequently asked questions.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text, BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: TextStyle(
        color: theme.textTheme.titleLarge!.color,
        fontSize: 20,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w800,
        height: 0.06,
      ),
    );
  }

  Widget _buildSupportItem(BuildContext context,
      {required String title, required String description}) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          // Handle onTap
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: theme.textTheme.titleLarge!.color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(
                  color: theme.textTheme.bodyLarge!.color,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRectangleForWriting() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Write here...',
          ),
        ),
      ),
    );
  }
}
