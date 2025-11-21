import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uts/screens/makanan_khas_content.dart';
import 'package:uts/screens/pakaian_content.dart';
import 'package:uts/screens/rumah_adat_content.dart';
import 'package:uts/screens/tari_content.dart';

class KatalogContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 15, left: 15),
              child: Text(
                "Kategori",
                style: GoogleFonts.judson(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8C67AC),
                ),
              ),
            ),

            TabBar(
              tabs: [
                Tab(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xFFE8D1E7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Tari',
                      style: GoogleFonts.judson(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xFFE8D1E7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Pakaian',
                      style: GoogleFonts.judson(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xFFE8D1E7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Rumah',
                      style: GoogleFonts.judson(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xFFE8D1E7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Makan',
                      style: GoogleFonts.judson(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  TariContent(),
                  BajuAdatContent(),
                  RumahAdatContent(),
                  MakananKhasContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
