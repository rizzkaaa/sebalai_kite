import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uts/screens/home_screen.dart';

class LottieWidget extends StatefulWidget {
  const LottieWidget({super.key});

  @override
  _LottieWidgetState createState() => _LottieWidgetState();
}

class _LottieWidgetState extends State<LottieWidget> {
  final List<String> _lottieAnimations = [
    'assets/animasi/kembangApi.json',
    'assets/animasi/travel.json',
    'assets/animasi/traveler.json',
  ];

  final List<String> _deskripsiList = [
    'Selamat datang di aplikasi SeBalai Kite! Mari jelajahi kekayaan budaya Bangka Belitung bersama kami.',
    'Temukan keindahan pakaian adat, rumah tradisional, dan makanan khas yang mencerminkan keberagaman daerah ini.',
    'Dengan SeBalai Kite, pelajari dan rayakan warisan budaya Bangka Belitung dengan cara yang menyenangkan dan interaktif!',
  ];

  int _currentIndex = 0;
  final PageController _controller = PageController();

  void _nextAnimation(BuildContext context) {
    if (_currentIndex == _lottieAnimations.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      setState(() {
        _currentIndex++;
      });
      _controller.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _lottieAnimations.length,
                  itemBuilder: (context, index) {
                    return Lottie.asset(
                      _lottieAnimations[index],
                      width: 220,
                      height: 220,
                      fit: BoxFit.contain,
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'SeBalai Kite',
                style: GoogleFonts.aclonica(
                  fontSize: 26,
                  color: const Color(0xFF6E5996),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: Text(
                    _deskripsiList[_currentIndex],
                    key: ValueKey<int>(_currentIndex),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.figtree(
                      fontSize: 14,
                      color: const Color.fromARGB(221, 48, 47, 47),
                      height: 1.6,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _nextAnimation(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB02D8F),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  _currentIndex == _lottieAnimations.length - 1
                      ? 'Mulai ➜'
                      : 'Lanjut ➜',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
