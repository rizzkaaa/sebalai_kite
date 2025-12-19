import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogConfirm extends StatelessWidget {
  final String title;
  final String deskripsi;
  final VoidCallback onPressed;

  const DialogConfirm({
    super.key,
    required this.title,
    required this.deskripsi,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 260,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFAFF4), Color(0xFFB64BC9)],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                title,
                style: GoogleFonts.lora(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    deskripsi,
                    style: GoogleFonts.josefinSans(
                      color: Color(0xFFB64BC9),
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    "Batal",
                    style: GoogleFonts.josefinSans(color: Color(0xFFFFAFF4)),
                  ),
                ),
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFAFF4),
                  ),
                  child: Text(
                    "Okay!",
                    style: GoogleFonts.josefinSans(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
