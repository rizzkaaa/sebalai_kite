import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uts/screens/detail_berita.dart';

class CardBerita extends StatelessWidget {
  final Map<String, dynamic> berita;

  const CardBerita({Key? key, required this.berita}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(berita['id'] % 2 == 1 ? 0xFFEBBCDF : 0xFFDBB6E0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                width: 150,
                padding: EdgeInsets.only(left: 8, bottom: 5),
                child: Text(
                  berita['judul']!,
                  style: GoogleFonts.judson(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Container(
                width: 150,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white, width: 5),
                  image: DecorationImage(
                    image: AssetImage(berita['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                width: 190,
                padding: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Color(0xFF8E6B97), width: 3),
                  ),
                ),
                child: Text(
                  berita['deskripsi']!,
                  style: GoogleFonts.inriaSerif(fontSize: 10, height: 1),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailBeritaScreen(idBerita: berita['id']!),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(
                    berita['id'] % 2 == 1 ? 0xFFC3A4C7 : 0xFFF2D3EA,
                  ),
                ),
                child: Text(
                  "Baca Selengkapnya",
                  style: GoogleFonts.judson(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
