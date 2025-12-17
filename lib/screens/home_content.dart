import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uts/models/berita_model.dart';
import 'package:uts/services/berita_service.dart';
import 'package:uts/widgets/card_berita.dart';

class HomeContent extends StatefulWidget {
  final String searchQuery;

  const HomeContent({super.key, this.searchQuery = ''});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final BeritaService service = BeritaService();
  late Future<List<BeritaModel>> dataBerita;

  @override
  void initState() {
    super.initState();
    _loadBerita();
  }

  @override
  void didUpdateWidget(HomeContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      _loadBerita();
    }
  }

  void _loadBerita() {
    setState(() {
      if (widget.searchQuery.isEmpty) {
        dataBerita = service.getLatestBerita();
      } else {
        dataBerita = service.searchBeritaByJudul(widget.searchQuery);
      }
    });
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
                  "Menelusuri Warisan \nBudaya Bangka",
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
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.red),
                        SizedBox(height: 16),
                        Text(
                          "Error: ${snapshot.error}",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _loadBerita,
                          child: Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          widget.searchQuery.isEmpty
                              ? Icons.newspaper
                              : Icons.search_off,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          widget.searchQuery.isEmpty
                              ? "Tidak ada data berita"
                              : "Tidak ada hasil untuk\n\"${widget.searchQuery}\"",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        if (widget.searchQuery.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              "Coba kata kunci lain",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                } else {
                  final listBerita = snapshot.data!;
                  return ListView.builder(
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
