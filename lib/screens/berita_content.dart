import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uts/models/berita_model.dart';
import 'package:uts/widgets/card_berita.dart';
import 'package:uts/services/berita_service.dart';

class BeritaContent extends StatefulWidget {
  const BeritaContent({super.key});

  @override
  State<BeritaContent> createState() => _BeritaContentState();
}

class _BeritaContentState extends State<BeritaContent> {
  final BeritaService service = BeritaService();
  late Future<List<BeritaModel>> dataBerita;

  @override
  void initState() {
    super.initState();
    dataBerita = service.fetchBerita();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      color: Colors.white,
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
    );
  }
}
