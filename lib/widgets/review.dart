import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Review extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: EdgeInsets.only(top: 50),
        child: Row(
          children: [
            Container(
              width: 250,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              decoration: BoxDecoration(
                color: Color(0xFFF2B8D5),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Stack(
                children: [
                  Transform.translate(
                    offset: const Offset(80, -55),
                    child: CircleAvatar(
                      radius: 47,
                      backgroundColor: Color(0xFFF2B8D5),
                      child: CircleAvatar(
                        radius: 42,
                        backgroundImage: AssetImage('assets/images/av1.jpeg'),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 55, 12, 15),
                    child: Column(
                      children: [
                        // Rating bintang
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.purple[400],
                              size: 25,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.purple[400],
                              size: 25,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.purple[400],
                              size: 25,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.purple[400],
                              size: 25,
                            ),
                            Icon(
                              Icons.star_border,
                              color: Colors.purple[400],
                              size: 25,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Judul tebal
                        Text(
                          "Wow, sekali !!",
                          style: GoogleFonts.judson(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),

                        // Isi review
                        Text(
                          "Tari Zapin menurut saya sangat indah karena gerakannya lembut dan mencerminkan keanggunan budaya Melayu Bangka Belitung.",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.namdhinggo(
                            fontSize: 12,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: 250,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              decoration: BoxDecoration(
                color: Color(0xFFDBB6E0),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Stack(
                children: [
                  Transform.translate(
                    offset: const Offset(80, -55),
                    child: CircleAvatar(
                      radius: 47,
                      backgroundColor: Color(0xFFDBB6E0),
                      child: CircleAvatar(
                        radius: 42,
                        backgroundImage: AssetImage('assets/images/av2.jpeg'),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 55, 12, 15),
                    child: Column(
                      children: [
                        // Rating bintang
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.purple[400],
                              size: 25,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.purple[400],
                              size: 25,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.purple[400],
                              size: 25,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.purple[400],
                              size: 25,
                            ),
                            Icon(
                              Icons.star_border,
                              color: Colors.purple[400],
                              size: 25,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Judul tebal
                        Text(
                          "Wow, sekali !!",
                          style: GoogleFonts.judson(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),

                        // Isi review
                        Text(
                          "Tari Zapin menurut saya sangat indah karena gerakannya lembut dan mencerminkan keanggunan budaya Melayu Bangka Belitung.",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.namdhinggo(
                            fontSize: 12,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: 250,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              decoration: BoxDecoration(
                color: Color(0xFFF2B8D5),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Stack(
                children: [
                  Transform.translate(
                    offset: const Offset(80, -55),
                    child: CircleAvatar(
                      radius: 47,
                      backgroundColor: Color(0xFFF2B8D5),
                      child: CircleAvatar(
                        radius: 42,
                        backgroundImage: AssetImage('assets/images/av3.jpeg'),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 55, 12, 15),
                    child: Column(
                      children: [
                        // Rating bintang
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.purple[400],
                              size: 25,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.purple[400],
                              size: 25,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.purple[400],
                              size: 25,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.purple[400],
                              size: 25,
                            ),
                            Icon(
                              Icons.star_border,
                              color: Colors.purple[400],
                              size: 25,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Judul tebal
                        Text(
                          "Wow, sekali !!",
                          style: GoogleFonts.judson(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),

                        // Isi review
                        Text(
                          "Tari Zapin menurut saya sangat indah karena gerakannya lembut dan mencerminkan keanggunan budaya Melayu Bangka Belitung.",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.namdhinggo(
                            fontSize: 12,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
