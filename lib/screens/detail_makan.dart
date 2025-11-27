import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uts/models/makanan_model.dart';

class DetailMakan extends StatelessWidget {
  final MakananModel data;

  DetailMakan({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.zero,
              height: 280,
              width: double.infinity,
              child: Image.asset(data.gambar, fit: BoxFit.cover),
            ),

            Column(
              children: [
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 100),
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Tombol back
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xFFF4A9C2),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.reply,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xFFF4A9C2),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: Icon(Icons.more_horiz, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        color: Color(0xFFCBC2C2),
                        thickness: 5,
                        indent: 130,
                        endIndent: 130,
                      ),
                      const SizedBox(height: 30),

                      // JUDUL
                      Text(
                        data.judul,
                        style: GoogleFonts.moul(
                          fontSize: 30,
                          color: const Color(0xFFC97DAF),
                        ),
                      ),
                      Divider(color: Color(0xFFCBC2C2), thickness: 2),
                      const SizedBox(height: 10),

                      Text(
                        data.deskripsi,
                        style: GoogleFonts.namdhinggo(
                          fontSize: 12,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),

                      Divider(color: Color(0xFFCBC2C2), thickness: 2),

                      const SizedBox(height: 10),

                      Text(
                        data.resep,
                        style: GoogleFonts.namdhinggo(
                          fontSize: 12,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
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
