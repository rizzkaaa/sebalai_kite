import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  final Color color;
  const Footer({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
        height: 80,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Text(
              "© 2025 Budaya Bangka | Semua hak cipta dilindungi",
              style: GoogleFonts.inriaSerif(fontSize: 14),
            ),
            Text(
              "“Menjaga Warisan, Merangkai Masa Depan Bangka”",
              style: GoogleFonts.inriaSerif(fontSize: 12),
            ),
          ],
        ),
      );
  }
}