import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:DefeDroid/screens/get_started.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const GetStarted(),
      ));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(
                'assets/map.png'), // Path to your map image in assets
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(
                  0.3), //  Adjust the opacity of the map image as needed
              BlendMode.darken,
            ),
          ),
        ),
      ),
      Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(240, 46, 46, 61),
              Color(0xFF2E2E3D),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Path to your logo image in assets
              width: 500, // Adjust the width of the logo as needed
              height: 500, // Adjust the height of the logo as needed
            ),
            const SizedBox(
                height: 16), //Adjust the spacing between the logo and the text
            const Text(
              'Defendozer',
              style: TextStyle(
                color: Color(0xFFD6A21E), // Color D6A21E
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
                height:
                    8), //Adjust the spacing between the app name and the additional text
            const Text(
              'Best detector app',
              style: TextStyle(
                color: Colors.white, //White color
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      )
    ]));
  }
}
