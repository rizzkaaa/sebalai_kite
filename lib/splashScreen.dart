import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uts/screens/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Pindah ke halaman berikutnya setelah 3 detik
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LottieWidget()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Peta.png',
                height: 254,
                width: 262,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10),
              Text(
                'Sebalai Kite',
                style: GoogleFonts.aclonica(fontSize: 24, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
