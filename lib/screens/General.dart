import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:DefeDroid/screens/theme.dart';

class GeneralPage extends StatelessWidget {
  const GeneralPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("General Settings"),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _SingleSection(
                title: "Application Theme",
                children: [
                  _CustomListTile(
                    title: "Dark Mode",
                    icon: Icons.dark_mode_outlined,
                    trailing: Switch(
                      value: themeNotifier.isDark,
                      onChanged: (value) {
                        themeNotifier.setDarkMode(value);
                      },
                    ),
                  ),
                ],
              ),
              const Divider(),
              _SingleSection(
                title: "Language",
                children: [
                  _CustomListTile(
                    title: "App Language",
                    icon: Icons.language,
                    onTap: () {
                      _showLanguageDialog(
                          context); // Show language selection dialog
                    },
                  ),
                ],
              ),
              const Divider(),
              const _SingleSection(
                title: "Preferences",
                children: [
                  _CustomListTile(
                    title: "Keep History Saved",
                    icon: Icons.history,
                  ),
                  _CustomListTile(
                    title: "Control Site Data",
                    icon: Icons.info_outline_rounded,
                  ),
                  _CustomListTile(
                    title: "Store Password",
                    icon: Icons.password,
                  ),
                  _CustomListTile(
                    title: "Clear Saved Data",
                    icon: Icons.delete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text("Select Language"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _LanguageOption(title: "English"),
                _LanguageOption(title: "Arabic"),
                _LanguageOption(title: "French"),
                // Add more language options as needed
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;

  const _CustomListTile({
    required this.title,
    required this.icon,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing,
      onTap: onTap,
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ...children,
      ],
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String title;

  const _LanguageOption({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        // Implement language selection logic here
        Navigator.pop(context); // Close the dialog after selection
      },
    );
  }
}
