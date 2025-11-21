import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uts/widgets/card_berita.dart';

class HomeContent extends StatelessWidget {
  final List<Map<String, dynamic>> listBerita = [
    {
      'id': 1,
      'judul': "Festival Tari Campak Meriahkan Peringatan Hari Budaya Bangka",
      'image': "assets/images/tari/tari-campak.jpg",
      'deskripsi':
          "Festival tahunan ini menghadirkan penampilan dari berbagai sanggar seni di Pulau Bangka. Tari Campak, simbol keceriaan masyarakat Melayu Bangka, kembali memukau penonton lokal dan wisatawan.",
    },
    {
      'id': 2,
      'judul': "Tradisi Nganggung, Simbol Kebersamaan Masyarakat Bangka",
      'image': "assets/images/tradisiNganggung.png",
      'deskripsi':
          "Festival tahunan ini menghadirkan penampilan dari berbagai sanggar seni di Pulau Bangka. Tari Campak, simbol keceriaan masyarakat Melayu Bangka, kembali memukau penonton lokal dan wisatawan.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "“Menelusuri Warisan \nBudaya Bangka”",
                      style: GoogleFonts.niconne(fontSize: 25),
                    ),
                    Text(
                      "Dari tarian tradisional, musik dambus, hingga kuliner khas yang penuh makna.",
                      style: GoogleFonts.inriaSerif(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFDBB6E0),
                  ),
                  child: Text(
                    "Pelajari Lebih Lanjut",
                    style: GoogleFonts.judson(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: listBerita.map((berita) {
                return CardBerita(berita: berita);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
