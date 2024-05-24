import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'package:DefeDroid/nav_bar/search.dart';
import 'package:DefeDroid/nav_bar/more.dart';
import 'package:DefeDroid/nav_bar/setting.dart';

import 'home.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int myCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomePage(),
      const FavoritePage(), // Replace this with the appropriate constructor or method call for the FavoritePage class
      const SettingsPage(),
      const MorePage(),
    ];

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2B2B2B), // Dark background color
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        height: 80, // Adjust the height as needed
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: const Color.fromRGBO(210, 158, 26, 1),
              color: Colors.white,
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: LineIcons.cog,
                  text: 'Settings',
                ),
                GButton(
                  icon: LineIcons.magic,
                  text: 'More',
                ),
              ],
              selectedIndex: myCurrentIndex,
              onTabChange: (index) {
                setState(() {
                  myCurrentIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
