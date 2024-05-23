// import 'package:flutter/material.dart';
// import 'package:DefeDroid/screens/home_screen.dart';

// class GetStarted extends StatelessWidget {
//   const GetStarted({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             color: const Color(0xFF2E2E3D), // Background color '2E2E3D'
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/getstarted.png', // Path to your get started image
//                   width: 500, // Adjust the width of the image as needed
//                   height: 500, // Adjust the height of the image as needed
//                 ),
//                 const SizedBox(height: 24), // Spacing below the get started image
//                 const Text(
//                   'Welcome to your safety',
//                   style: TextStyle(
//                     fontFamily: 'Urbanist',
//                     fontWeight: FontWeight.bold,
//                     fontSize: 24,
//                     color: Colors.white, // White color
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 8), // Spacing below the first text
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   child: Text(
//                     'Introducing Defendozer Scanner - the world\'s fastest malware detection with a vast server network ensuring ultimate protection for your devices. Welcome to enhanced cybersecurity!',
//                     style: TextStyle(
//                       fontFamily: 'Urbanist',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 15,
//                       color: Colors.white, // White color
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const SizedBox(height: 56), // Spacing below the second text
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pushReplacement(
//                       MaterialPageRoute(
//                         builder: (_) => const HomeScreen(),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFD29E1A), // Button color 'D29E1A'
//                   ),
//                   child: const Text(
//                     'Get Started',
//                     style: TextStyle(
//                       fontFamily: 'Urbanist',
//                       color: Colors.black, // Black color
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:DefeDroid/nav_bar/bottom_nav_bar.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFF2E2E3D), // Background color '2E2E3D'
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Positioned(
                  top: 15,
                  right: -6,
                  child: Image.asset(
                    'assets/getstarted.png', // Path to your logo image
                    width: 500, // Adjust the width of the logo
                    height: 400, // Adjust the height of the logo
                  ),
                ),
                /*  Image.asset(
                  'assets/getstarted.png', // Path to your get started image
                  width: 500, // Adjust the width of the image as needed
                  height: 500, // Adjust the height of the image as needed
                ),*/
                const SizedBox(
                    height: 24), // Spacing below the get started image
                const Text(
                  'Welcome to your safety',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white, // White color
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                    height: 16), // Additional space between the texts
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Introducing Defendozer Scanner - the world\'s fastest malware detection with a vast server network ensuring ultimate protection for your devices. Welcome to enhanced cybersecurity!',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.white, // White color
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24), // Spacing below the second text
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const MyBottomNavBar(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFD29E1A), // Button color 'D29E1A'
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.black, // Black color
                    ),
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
