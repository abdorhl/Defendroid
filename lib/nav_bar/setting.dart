import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:DefeDroid/screens/General.dart';
import 'package:DefeDroid/screens/theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the ThemeNotifier
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            color: themeNotifier.isDark
                ? Colors.white
                : const Color(0xFF2E2E3D), // Adjust text color based on theme
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // Use the Theme widget to apply the current theme
      body: Theme(
        data: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: _SingleSection(
                    title: "General",
                    children: [
                      _CustomListTile(
                        title: "General Settings",
                        icon: Icons.settings_accessibility,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GeneralPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: const _SingleSection(
                    title: "Notification Settings",
                    children: [
                      _CustomListTile(
                        title: "Push Notifications",
                        icon: Icons.notifications_none_rounded,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: const _SingleSection(
                    title: "More",
                    children: [
                      _CustomListTile(
                          title: "Rate our App", icon: Icons.rate_review),
                      _CustomListTile(title: "Support", icon: Icons.email),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;
  const _CustomListTile({
    required this.title,
    required this.icon,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            color: Theme.of(context)
                .textTheme
                .bodyLarge!
                .color), // Adjust text color based on theme
      ),
      leading: Icon(icon,
          color: Theme.of(context)
              .iconTheme
              .color), // Adjust icon color based on theme
      trailing: trailing,
      onTap: onTap, // Call onTap when the tile is tapped
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _SingleSection({
    this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .color, // Adjust text color based on theme
              ),
            ),
          ),
        Column(
          children: children,
        ),
      ],
    );
  }
}
