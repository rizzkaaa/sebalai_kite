import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uts/models/berita_model.dart';
import 'package:uts/services/berita_service.dart';
import 'package:uts/widgets/card_berita.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final BeritaService service = BeritaService();
  late Future<List<BeritaModel>> dataBerita;

  @override
  void initState() {
    super.initState();
    dataBerita = service.fetchLatestBerita();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
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
          ),

          SizedBox(height: 20),

          Expanded(
            child: FutureBuilder(
              future: dataBerita,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Tidak ada data"));
                } else {
                  final listBerita = snapshot.data!;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: listBerita.length,
                      itemBuilder: (context, index) {
                        final berita = listBerita[index];

                        return SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                berita.tanggal,
                                style: GoogleFonts.judson(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF77426A),
                                ),
                              ),
                              CardBerita(berita: berita),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
